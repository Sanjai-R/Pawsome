import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/model/bookmark_model.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class PopularPets extends StatefulWidget {
  const PopularPets({super.key});

  @override
  State<PopularPets> createState() => _PopularPetsState();
}

class _PopularPetsState extends State<PopularPets> {
  late num userId;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      userId = authProvider.user['userId'];
      Provider.of<PetProvider>(context, listen: false).fetchAllPets(userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 300,
        child: Consumer(
          builder: (BuildContext context, PetProvider petProvider, child) {
            final pets = petProvider.pets ?? [];
            final bookmarks = petProvider.bookmarks;
            final bookMarksId =
                petProvider.bookmarks.map((e) => e.petId).toList() ?? [];
            if (pets.length > 3) {
              pets.removeRange(3, pets.length);
            }
            if(pets.isEmpty){
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  boxShadow: boxShadow,
                  color: Colors.white,
                ),
                child: Center(
                  child: Text("No Pets Found"),
                ),
              );
            }
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i in pets)
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      boxShadow: boxShadow,
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              context.go('/pet/details?dynamicData=${i.petId}');
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: Image.network(
                                i.image.toString(),
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      i.name.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      i.gender.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
                                    ),
                                  ],
                                ),
                              ),

                              IconButton(
                                onPressed: () async {
                                  final data = {
                                    'userId': userId,
                                    'petId': i.petId,
                                  };

                                  if (bookMarksId.contains(i.petId)) {
                                    late BookmarkModel temp;
                                    for (var element in bookmarks) {
                                      if (element.petId == i.petId) {
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
                                    bookMarksId.contains(i.petId)
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
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ));
  }
}
