import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/model/meal_tracker_model.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/provider/tracker_provider.dart';

import 'package:pawsome_client/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class MealTracker extends StatefulWidget {


  const MealTracker({super.key});

  @override
  State<MealTracker> createState() => _MealTrackerState();
}

class _MealTrackerState extends State<MealTracker> {
  late num petId;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      petId =
          Provider.of<PetProvider>(context, listen: false).selectedPet['petId'];
      Provider.of<TrackerProvider>(context, listen: false).getMealTrack(petId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding / 2),
      child: Consumer2(
        builder: (context, TrackerProvider trackerProvider,
            PetProvider petProvider, child) {
          final meal = trackerProvider.mealTracker;

          if (trackerProvider.isLoading) {
            return const Center(
              child: Text('loading'), // Loading indicator
            );
          }
          if (meal == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('You have not created a meal plan yet'),
                  const SizedBox(height: 16.0),
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
              ), // Loading indicator
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: SizedBox(
                      width: 250,
                      height: 250,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // MealTrackerContainer(),
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: CircularProgressIndicator(
                              value: meal.foodConsumed!.toInt() /
                                  meal.dailyPlan!.toInt(),
                              strokeWidth: 6.0,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(theme.primary),
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('${(meal.foodConsumed!).toInt()}  ',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                        fontSize: 50,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      )),
                              Text(
                                'of ${(meal.dailyPlan!).toInt()}g',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[400],
                                    ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 0.5,
                          offset: const Offset(
                              0, 0.5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Your Plan",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                            GestureDetector(
                                onTap: () {
                                  openBottomSheet(context, meal);
                                },
                                child: const Icon(IconlyLight.edit))
                          ],
                        ),
                        const SizedBox(
                          height: 16.0,
                        ),
                        _buildValue(
                            "Proteins", meal.nutrientTracker?.proteinPlan),
                        Divider(
                          thickness: 2,
                          color: Colors.grey[300],
                        ),
                        _buildValue("Carbs", meal.nutrientTracker?.carbsPlan),
                        Divider(
                          thickness: 2,
                          color: Colors.grey[300],
                        ),
                        _buildValue("Fats", meal.nutrientTracker?.fatPlan),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 1,
                          padding: const EdgeInsets.symmetric(vertical: 12)),
                      onPressed: () {
                        addMeal(context, meal);
                      },
                      icon: const Icon(
                        Icons.add,
                        size: 24,
                      ),
                      label: const Text(
                        "Meal",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildValue(title, value) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xffDDEFB3),
              ),
              child: Text(value.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  void addMeal(BuildContext context, MealTrackerModel meal) {
    bool isLoading = false;

    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyCustomInput(
                  label: "Enter Meal",
                  hintText: "250 ml of milk,1 cup of rice",
                  type: "text",
                  onSaved: (val) {},
                  controller: controller),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 1,
                        padding: const EdgeInsets.symmetric(vertical: 12)),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      final res = await Provider.of<TrackerProvider>(context,
                              listen: false)
                          .updateMeal(meal, controller.text);
                      print(res);
                      if (res['status']) {
                        await Provider.of<TrackerProvider>(context,
                                listen: false)
                            .getMealTrack(petId);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(res['message']),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(res['message']),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                      setState(() {
                        isLoading = false;
                      });
                      // await Provider.of<TrackerProvider>(context, listen: false)
                      //     .getNutrients(controller.text);
                    },
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )),
              ),
            ],
          ),
        );
      },
    );
  }

  void openBottomSheet(BuildContext context, MealTrackerModel mt) {
    bool isLoading = false;

    final proteincontroller = TextEditingController();
    final fatcontroller = TextEditingController();
    final carbscontroller = TextEditingController();

    proteincontroller.text = mt.nutrientTracker!.proteinPlan.toString();
    fatcontroller.text = mt.nutrientTracker!.fatPlan.toString();
    carbscontroller.text = mt.nutrientTracker!.carbsPlan.toString();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Meal',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                // optional padding around the container
                child: Column(
                  children: [
                    MyCustomInput(
                        label: "Enter Protein",
                        hintText: "300g",
                        type: "text",
                        onSaved: (val) {},
                        controller: proteincontroller),
                    MyCustomInput(
                        label: "Enter Fats",
                        hintText: "400g",
                        type: "text",
                        onSaved: (val) {},
                        controller: fatcontroller),
                    MyCustomInput(
                        label: "Enter Carbs",
                        hintText: "200g",
                        type: "text",
                        onSaved: (val) {},
                        controller: carbscontroller),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(vertical: 12)),
                  onPressed: () async {
                    Map<String, dynamic> mp = mt.toJson()['nutrientTracker'];
                    mp['proteinPlan'] = proteincontroller.text;
                    mp['fatPlan'] = fatcontroller.text;
                    mp['carbsPlan'] = carbscontroller.text;

                    final res = await Provider.of<TrackerProvider>(context,
                            listen: false)
                        .updateMealPlan(mp);
                    if (res['status']) {
                      await Provider.of<TrackerProvider>(context, listen: false)
                          .getMealTrack(petId);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(res['message']),
                          backgroundColor: Colors.green,
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(res['message']),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                    context.go('/home');
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
