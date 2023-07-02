import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/provider/tracker_provider.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class CreateMealPlan extends StatefulWidget {
  const CreateMealPlan({super.key});

  @override
  State<CreateMealPlan> createState() => _CreateMealPlanState();
}

class _CreateMealPlanState extends State<CreateMealPlan> {
  bool _isLoading = false;

  final _proteincontroller = TextEditingController();
  final _fatcontroller = TextEditingController();
  final _carbscontroller = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      _formKey.currentState!.save();
      final Map<String, dynamic> data =
          Provider.of<TrackerProvider>(context, listen: false).mealData;
      data['nutrientTracker']['proteinPlan'] =int.parse( _proteincontroller.text);
      data['nutrientTracker']['fatPlan'] = int.parse(_fatcontroller.text);
      data['nutrientTracker']['carbsPlan'] = int.parse(_carbscontroller.text);


      final res = await Provider.of<TrackerProvider>(context, listen: false)
          .createMealTrackerPlan(data);
      if (res != null) {
        setState(() {
          _isLoading = false;
        });
      }

      if (res['status']) {
        setState(() => _isLoading = false);
        Provider.of<AppProvider>(context, listen: false).changeIndex(2);
        context.go('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(res['message']),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Create Meal Plan",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Provider.of<AppProvider>(context, listen: false).changeIndex(1);
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: defaultPadding),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyCustomInput(
                      label: "Enter Protein in grams",
                      hintText: "300",
                      type: 'number',
                      onSaved: (val) {},
                      controller: _proteincontroller),
                  MyCustomInput(
                      label: "Enter Fats in grams",
                      hintText: "400",
                      type: 'number',
                      onSaved: (val) {},
                      controller: _fatcontroller),
                  MyCustomInput(
                      label: "Enter Carbs in grams",
                      hintText: "200",
                      type: 'number',
                      onSaved: (val) {},
                      controller: _carbscontroller),
                ],
              ),
            ),
            const SizedBox(height: defaultPadding),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding * 2,
                        vertical: defaultPadding * 0.75),
                  ),
                  onPressed: () {
                    onSubmit();
                  },
                  child: Text(
                    "Create",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
