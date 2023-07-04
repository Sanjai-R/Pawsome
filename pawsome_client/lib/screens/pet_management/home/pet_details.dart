import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:pawsome_client/provider/pet_provier.dart';

import 'package:provider/provider.dart';

class PetDetails extends StatefulWidget {
  // final PetModel pet;
  final String petId;

  const PetDetails({super.key, required this.petId});

  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  Map<String, dynamic>? pet;

  @override
  void initState() {
    super.initState();
    final petProvider = Provider.of<PetProvider>(context, listen: false);
    petProvider.fetchPetById(widget.petId).then((result) {
      setState(() {
        pet = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/');
          },
        ),
        title: const Text('Pet Details')
      ),
      body: Consumer<PetProvider>(
        builder: (context, petProvider, child) {
          if (petProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (pet == null) {
            return const Center(child: Text('Failed to load pet details.'));
          }
          return Container(
            child: Center(child: Text(pet!['name'])),
          );
        },
      ),
    );
  }
}
