import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreatePet extends StatefulWidget {
  const CreatePet({super.key});

  @override
  State<CreatePet> createState() => _CreatePetState();
}

class _CreatePetState extends State<CreatePet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Pet'),
        leading: BackButton(
          onPressed: () {
            context.go('/');
          },
        )
      ),
      body: Center(
        child: Text('Create Pet'),
      ),
    );
  }
}
