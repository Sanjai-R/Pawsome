import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:pawsome_client/screens/events/components/event_container.dart';
import 'package:pawsome_client/screens/pet_tracker/tracker/components/meal_tracker_container.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<EventProvider>(context, listen: false).selectedDate = DateTime.now();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body:Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [   // Text('Dashboard'),
          Text(
            'Today, ${DateFormat('MMMMd').format(DateTime.now())}',
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              fontWeight: FontWeight.bold,

            )
          ),
            SizedBox(height: 16.0)
          ,
            EventList(),
            SizedBox(height: 16.0),
            MealTrackerContainer()
          ],
        ),
      )
    );
  }
}
