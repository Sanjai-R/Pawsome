// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/provider/tracker_provider.dart';
import 'package:provider/provider.dart';

class MealTrackerContainer extends StatefulWidget {
  const MealTrackerContainer({super.key});

  @override
  State<MealTrackerContainer> createState() => _MealTrackerContainerState();
}

class _MealTrackerContainerState extends State<MealTrackerContainer> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final selectedPet = context.read<PetProvider>().selectedPet;

      if (selectedPet.isNotEmpty) {
        context.read<TrackerProvider>().getMealTrack(selectedPet['petId']);
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 0.5,
              offset: const Offset(0, 0.5), // changes position of shadow
            ),
          ],
        ),
        // Adjust the height as needed
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Meal",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    context.go('/tracker');
                  },
                  icon: const Icon(CupertinoIcons.chart_pie),
                ),
              ],
            ),
            SizedBox(height: 8),
            Consumer(
              builder: (context, TrackerProvider trackerProvider, child) {
                final meal = trackerProvider.mealTracker;
                if (trackerProvider.isLoading) {
                  return Center(
                    child: Text('loading'), // Loading indicator
                  );
                }
                if (meal == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('You have not created a meal plan yet'),
                        SizedBox(height: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            context.go('/tracker/meal/create');
                          },
                          child: const Text('Create Meal Plan'),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Daily Plan: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                            TextSpan(
                                text: meal!.dailyPlan.toString(),
                                style: Theme.of(context).textTheme.bodySmall)
                          ])),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 80,
                                  height: 80,
                                  child: CircularProgressIndicator(
                                    value: meal.foodConsumed!.toInt() /
                                        meal.dailyPlan!.toInt(),
                                    strokeWidth: 6.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).colorScheme.primary),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${(meal.foodConsumed!).toInt()}  ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'of ${(meal.dailyPlan!).toInt()}g',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.grey),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'Remaining: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    )),
                            TextSpan(
                                text: (meal.dailyPlan! - meal.foodConsumed!)
                                    .toString(),
                                style: Theme.of(context).textTheme.bodySmall)
                          ])),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCol(
                              "Carbs",
                              meal.nutrientTracker!.carbsPlan!.toInt(),
                              meal.nutrientTracker!.carbsConsumed!.toInt(),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildCol(
                                "Fats",
                                meal.nutrientTracker!.fatPlan!.toInt(),
                                meal.nutrientTracker!.fatConsumed!.toInt()),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: _buildCol(
                              "Proteins",
                              meal.nutrientTracker!.proteinPlan!.toInt(),
                              meal.nutrientTracker!.proteinConsumed!.toInt(),
                            ),
                          )
                        ],
                      )
                    ],
                  );
                }
              },
            )
          ],
        ));
  }

  Widget _buildCol(String title, int plan, int value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(
          height: 4,
        ),
        LinearProgressIndicator(
          value: value / plan,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).colorScheme.primary),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '$value/$plan g',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
