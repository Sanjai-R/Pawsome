import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/provider/tracker_provider.dart';
import 'package:provider/provider.dart';

class ManagePet extends StatefulWidget {
  const ManagePet({super.key});

  @override
  State<ManagePet> createState() => _ManagePetState();
}

class _ManagePetState extends State<ManagePet> {
  int selectedIndex = 0; // Track the selected pet index

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final user = Provider.of<AuthProvider>(context, listen: false).user;
      Provider.of<PetProvider>(context, listen: false)
          .fetchAllPetsByUser(user['userId']);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Manage Pet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.go('/pet/create');
                    },
                    child: Container(
                      height: 150,
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: boxShadow,
                        color: Colors.white,
                        border: Border.all(
                          color: selectedIndex == -1
                              ? Colors
                                  .blue // Set border color for the selected pet
                              : Colors.grey,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          IconlyLight.plus,
                          color: Colors.black54,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 150,
                  child: Consumer<PetProvider>(
                    builder: (context, petProvider, child) {
                      if (petProvider.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final pets = petProvider.pets ?? [];
                      final selectedPet = petProvider.selectedPet ?? {};
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final pet = pets[index];
                          return GestureDetector(
                            onTap: () {
                              petProvider.setSelectedPet(pet.toJson());
                              context
                                  .read<TrackerProvider>()
                                  .getMealTrack(pet.petId);
                              context
                                  .read<EventProvider>()
                                  .fetchAllEvents(pet.petId);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: boxShadow,
                                color: Colors.white,
                                border: Border.all(
                                  width: 2,
                                  color: selectedPet['petId'] == pet.petId
                                      ? Theme.of(context)
                                          .primaryColor // Set border color for the selected pet
                                      : Colors.grey,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              pet.image.toString()),
                                          fit: BoxFit
                                              .cover, // Set the desired fit
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    pet.name.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: pets.length,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
