import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/model/bookmark_model.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      userId = authProvider.user['userId'];
      Provider.of<PetProvider>(context, listen: false).fetchAllPets(userId);
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
                  // Customize the TextFormField as needed
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
                if(pets.isEmpty)
                  const Center(child: Text('No Pets Found')),
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: pets.length,
                    itemBuilder: (context, index) {
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
                                    builder: (context) =>  PetDetails(petId: pets[index].petId.toString()),
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  pets[index].image.toString(),
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
                                        pets[index].name.toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        pets[index].description.toString(),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    bookMarksId.contains(pets[index].petId)
                                        ? CupertinoIcons.bookmark_fill
                                        : CupertinoIcons.bookmark,
                                    size: 26,
                                    color: bookMarksId.contains(pets[index].petId)
                                        ? Theme.of(context).colorScheme.error
                                        : Colors.grey,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
