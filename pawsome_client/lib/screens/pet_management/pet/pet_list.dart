import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:provider/provider.dart';

import '../../../provider/auth_provider.dart';

class PetList extends StatefulWidget {
  const PetList({super.key});

  @override
  State<PetList> createState() => _PetListState();
}

class _PetListState extends State<PetList> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final userId = authProvider.user['userId'];
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
            return ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (var i in pets)
                  GestureDetector(
                    onTap: () {
                      context.go('/pet/details?dynamicData=${i.petId}');
                    },
                    child: Container(
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
                                            .copyWith(fontWeight: FontWeight.bold),
                                      ),

                                      Text(
                                        '12 KM away',
                                        style:Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.secondary),
                                      ),
                                    ],
                                  ),
                                ),
                                // const Spacer(),
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.0),
                                    boxShadow: boxShadow,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            );
          },
        ));
  }
}
