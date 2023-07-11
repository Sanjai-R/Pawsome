import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/provider/tracker_provider.dart';
import 'package:pawsome_client/screens/events/components/event_container.dart';
import 'package:pawsome_client/screens/pet_management/pet/manage_pet.dart';
import 'package:pawsome_client/screens/pet_management/tracker/components/meal_tracker_container.dart';
import 'package:pawsome_client/widgets/adopt_container.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  num userId = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final authProvider = context.read<AuthProvider>();

      setState(() {
        userId = authProvider.user['userId'];
      });
      context.read<PetProvider>().fetchAllPets(userId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today, ${DateFormat('MMMMd').format(DateTime.now())}',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                const ManagePet(),
                const SizedBox(height: 16.0),
                const AdoptContainer(),
                const SizedBox(height: 16.0),
                Consumer<PetProvider>(builder: (context, petProvider, child) {
                  final selectedPet = context.watch<PetProvider>().selectedPet;
                  print(petProvider.pets.length);
                  if (selectedPet.isEmpty) {
                    return const Center(child: Text('Please select a pet to get analytics'));
                  } else {
                    return Column(
                      children: [
                        EventList(),
                        const SizedBox(height: 16.0),
                        const MealTrackerContainer(),
                        const SizedBox(height: 16.0),

                      ],
                    );
                  }
                } ),
                // if (selectedPet.isEmpty)
                //   const Center(child: Text('Please select a pet to get analytics'))
                // else
                //   Column(
                //     children:  [
                //       EventList(),
                //       const SizedBox(height: 16.0),
                //       const MealTrackerContainer(),
                //       const SizedBox(height: 16.0),
                //       const AdoptContainer(),
                //     ],
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
