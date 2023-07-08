import 'package:flutter/material.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/food_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/screens/pet_management/pet/manage_pet.dart';
import 'package:provider/provider.dart';

class RecommendedFoods extends StatefulWidget {
  const RecommendedFoods({super.key});

  @override
  State<RecommendedFoods> createState() => _RecommendedFoodsState();
}

class _RecommendedFoodsState extends State<RecommendedFoods> {
  late num petId;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final foodProvider = Provider.of<PetProvider>(context, listen: false);
      petId = foodProvider.selectedPet['petId'];
      Provider.of<FoodProvider>(context, listen: false).getFoods(petId);

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Consumer<FoodProvider>(
            builder: (context, foodProvider, child) {
              final foods = foodProvider.foods;
              if (foods.isEmpty) {
                return Text('No Recommended Foods');
              }
              else{
                return Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: foods.length,
                    itemBuilder: (context, index) {
                      final food = foods[index];
                      return  Container(
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                        decoration: BoxDecoration(
                          boxShadow: boxShadow,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                food['img'].toString(),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [

                                          Text('Food Name: ',
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              )),
                                          Text(
                                            food['name'].toString(),
                                            style: const TextStyle(
                                              fontSize: 18,

                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text('Contain Nutrients: ',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        )),
                                      Text(
                                        food['containNutrient'].toString(),
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),

                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

            },
          ),
        ],
      ),
    );
  }
}
