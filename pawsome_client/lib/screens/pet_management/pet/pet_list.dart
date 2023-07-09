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

class PetList extends StatefulWidget {
  const PetList({super.key});

  @override
  State<PetList> createState() => _PetListState();
}

class _PetListState extends State<PetList> {
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
    List<String> imgs = [
      "https://img.freepik.com/free-photo/portrait-beautiful-purebred-pussycat-with-shorthair-orange-collar-neck-sitting-floor-reacting-camera-flash-scared-looking-light-indoor_8353-12551.jpg?w=360&t=st=1688887223~exp=1688887823~hmac=9b259dea6b308a5358b7b6810bbc54b0002d265192626c665e415d22a2b20ea0",
    ];
    return SizedBox(
        height: 300,
        child: Consumer(
          builder: (BuildContext context, PetProvider petProvider, child) {
            final pets = petProvider.pets ?? [];
            final bookmarks = petProvider.bookmarks;
            final bookMarksId =
                petProvider.bookmarks.map((e) => e.petId).toList() ?? [];

            return Scaffold(
              appBar: AppBar(),
              body: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
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
                    SizedBox(height: defaultPadding),
                    Expanded(
                      child: ListView.builder(
                          itemCount: pets.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context.go('/pet/details?dynamicData=${pets[index].petId}');
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
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                        IconButton(

                                          onPressed: () {},
                                          icon: Icon(
                                            size: 26,
                                            bookMarksId
                                                    .contains(pets[index].petId)
                                                ? IconlyBold.bookmark
                                                : IconlyLight.bookmark,
                                            color: bookMarksId
                                                    .contains(pets[index].petId)
                                                ? Theme.of(context).colorScheme.error
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
