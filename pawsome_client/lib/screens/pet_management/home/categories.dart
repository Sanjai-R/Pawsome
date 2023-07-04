import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:provider/provider.dart';

class PetCategories extends StatefulWidget {
  const PetCategories({super.key});

  @override
  State<PetCategories> createState() => _PetCategoriesState();
}

class _PetCategoriesState extends State<PetCategories> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PetProvider>(context, listen: false).fetchCategories();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: const Text(
            "Categories",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Consumer(builder: (context, PetProvider perProvider, child) {
          final categories = perProvider.categories;

          if (categories.isEmpty) {
            return const Center(child: Text('No Categories Found'));
          } else {
            final category = categories[0];
            return Container(
              height: 50,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: boxShadow,
                      color: Colors.white,
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          IconlyLight.filter,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Filter',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      children: [
                        for (var i in categories)
                          Container(
                            height: 40,
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 10,
                              top: 5,
                              bottom: 5,
                            ),
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: i == category
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.white,
                              boxShadow: boxShadow,
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        NetworkImage(i.img.toString())),
                                Text(i.categoryName.toString(),
                                    style: TextStyle(
                                        color: i == category
                                            ? Colors.white
                                            : Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16))
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        })
      ],
    );
  }
}
