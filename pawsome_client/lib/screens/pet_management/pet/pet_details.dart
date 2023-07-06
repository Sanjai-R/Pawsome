import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/model/adopt_model.dart';
import 'package:pawsome_client/provider/auth_provider.dart';

import 'package:pawsome_client/provider/pet_provier.dart';

import 'package:provider/provider.dart';

class PetDetails extends StatefulWidget {
  final String petId;

  const PetDetails({super.key, required this.petId});

  @override
  State<PetDetails> createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  Map<String, dynamic>? pet;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final petProvider = Provider.of<PetProvider>(context, listen: false);
    petProvider.fetchPetById(widget.petId).then((result) {
      setState(() {
        pet = result;
      });
    });
    petProvider.fetchAdoptData();
  }

  void onSubmit() {
    _isLoading = true;
    final petProvider = Provider.of<PetProvider>(context, listen: false);
    final authData = Provider.of<AuthProvider>(context, listen: false).user;
    final data = {
      'petId': widget.petId,
      'buyerId': authData['userId'],
      'status': 'pending',
      'date': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(DateTime.now().toUtc())
    };

    petProvider.adoptPet(data).then((result) {
      setState(() {
        _isLoading = false;
      });
      if (result['status']) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            context.go('/');
          },
        ),
        backgroundColor: Colors.blueGrey[100],
      ),
      body: Consumer<PetProvider>(
        builder: (context, petProvider, child) {
          List<AdoptModel> adopt = petProvider.adopts;

          bool isRequested = adopt.any((element) =>
              element.petId == int.parse(widget.petId) &&
              element.status == 'pending');
          bool isSold = adopt.any((element) =>
              element.petId == int.parse(widget.petId) &&
              element.status == 'approved');

          print(isSold);
          if (petProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (pet == null) {
            return const Center(child: Text('Failed to load pet details.'));
          }

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    bottom: defaultPadding,
                    left: defaultPadding,
                    right: defaultPadding),
                height: 300,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    pet!['image'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        topLeft: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${pet!['name'].toString()}, 3 YRO",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              pet!['user']!['location'].toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.grey),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: _buildCard("Age", "2.5 years",
                                        const Color(0xFFDDF8E6))),
                                Expanded(
                                    child: _buildCard("Weight", "2.5 kg",
                                        const Color(0xFFFFF9C4))),
                                Expanded(
                                    child: _buildCard("gender", "male",
                                        const Color(0xFFDAEBFF))),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Description",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Look for a pet with unique or eye-catching features that stand out in photos. This could include beautiful fur colors or patterns, expressive eyes, or adorable facial expressions",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    padding: const EdgeInsets.all(15),
                                    backgroundColor: isRequested
                                        ? Colors.grey
                                        : isSold
                                            ? Colors.red
                                            : Theme.of(context)
                                                .colorScheme
                                                .primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: isRequested
                                      ? () {}
                                      : () {
                                          onSubmit();
                                        },
                                  child: _isLoading
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                      : Text(
                                          isRequested
                                              ? "Requested"
                                              : isSold
                                                  ? "Sold"
                                                  : "Adopt",
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          )),
                                ))
                          ],
                        ),
                      ),
                    )),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildCard(title, value, color) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: boxShadow,
        color: color,
        border: Border.all(width: 2, color: color),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
