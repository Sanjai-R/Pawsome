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
import 'package:pawsome_client/screens/pet_tracker/tracker/components/meal_tracker_container.dart';
import 'package:pawsome_client/widgets/adopt_container.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  num userId=0;

  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      setState(() {
        userId = authProvider.user['userId'];
      });
      Provider.of<PetProvider>(context, listen: false).fetchAllPets(userId);

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedPet = Provider.of<PetProvider>(context).selectedPet;

    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            IconButton(
              onPressed: () {
                context.go('/event');
              },
              icon: const Icon(CupertinoIcons.calendar_badge_plus),
            ),
            IconButton(
              onPressed: () {
                context.go('/tracker');
              },
              icon: const Icon(CupertinoIcons.chart_pie),
            ),
          ],
          title: Text(
            "Dashboard $userId",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
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
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16.0),
                  const ManagePet(),
                  const SizedBox(height: 16.0),
                  selectedPet.isEmpty
                      ? const Center(child: Text('Please select a pet to get analytics'))
                      : Column(
                          children: [
                            EventList(),
                            const SizedBox(height: 16.0),
                            const MealTrackerContainer(),
                            const SizedBox(height: 16.0),
                            const AdoptContainer()
                          ],
                        )
                ],
              ),
            ),
          ),
        ));
  }
}
