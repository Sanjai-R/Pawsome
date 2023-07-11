import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/model/bookmark_model.dart';
import 'package:pawsome_client/model/pet_model.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/screens/pet_management/pet/pet_details.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class PetList extends StatefulWidget {
  const PetList({Key? key}) : super(key: key);

  @override
  State<PetList> createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  late num userId;
  final TextEditingController _searchController = TextEditingController();
  List<PetModel> filteredPets = []; // New filtered pets list
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      userId = authProvider.user['userId'];
      Provider.of<PetProvider>(context, listen: false)
          .fetchAllPets(userId)
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });
    });
  }

  List<PetModel> getPetByName(List<PetModel> pets, String name) {
    return pets
        .where((pet) => pet.name.toString().toLowerCase().contains(name.toLowerCase()))
        .toList();
  }

  void filterPets(String query) {
    setState(() {
      if (query.isNotEmpty) {
        filteredPets =
            getPetByName(Provider.of<PetProvider>(context, listen: false).pets, query).toList();

      } else {
        filteredPets = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PetProvider>(
      builder: (BuildContext context, PetProvider petProvider, _) {
        final pets = petProvider.pets ?? [];
        final bookmarks = petProvider.bookmarks;
        final bookMarksId = petProvider.bookmarks.map((e) => e.petId).toList() ?? [];

        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            forceMaterialTransparency: true,
            title: const Text(
              'Explore',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 2,
            onPressed: () {
              GoRouter.of(context).go('/pet/create');
            },
            child: const Icon(CupertinoIcons.paw),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextFormField(
                  controller: _searchController,
                  onChanged: filterPets, // Call filterPets method when text changes
                  decoration: InputDecoration(
                    prefixIcon: const Icon(CupertinoIcons.search),
                    hintText: 'Enter your search query',
                    contentPadding: const EdgeInsets.all(16.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.grey[200],
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    filled: true,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                if (pets.isEmpty && !isLoading)
                  const Center(child: Text('No Pets Found')),
                Expanded(
                  child: Stack(
                    children: [
                      Visibility(
                        visible: !isLoading,
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount:
                          filteredPets.length > 0 ? filteredPets.length : pets.length,
                          itemBuilder: (context, index) {
                            final pet =
                            filteredPets.length > 0 ? filteredPets[index] : pets[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PetDetails(
                                            petId: pets[index].petId.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        pet.image.toString(),
                                        height: 300,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              pet.name.toString(),
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              child: Text(
                                                pet.description.toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          final data = {
                                            'userId': userId,
                                            'petId': pet.petId,
                                          };

                                          if (bookMarksId.contains(pet.petId)) {
                                            late BookmarkModel temp;
                                            for (var element in bookmarks) {
                                              if (element.petId == pet.petId) {
                                                temp = element;
                                              }
                                            }
                                            final res = await petProvider
                                                .deleteBookmarks(temp.id!);
                                            if (res['status']) {
                                              petProvider.getBookmarks(userId);
                                              context
                                                  .read<AppProvider>()
                                                  .changeIndex(4);

                                              context.go('/');
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Something went wrong')));
                                            }
                                          } else {
                                            final res =
                                            await petProvider.postBookmarks(data);
                                            if (res['status']) {
                                              petProvider.getBookmarks(userId);
                                              context
                                                  .read<AppProvider>()
                                                  .changeIndex(4);

                                              context.go('/');
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Something went wrong')));
                                            }
                                          }
                                        },
                                        icon: Center(
                                          child: Icon(
                                            bookMarksId.contains(pet.petId)
                                                ? CupertinoIcons.bookmark_fill
                                                : CupertinoIcons.bookmark,
                                            size: 24,
                                            color:
                                            Theme.of(context).colorScheme.error,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: isLoading,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
