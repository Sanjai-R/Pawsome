import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/screens/pet_tracker/tracker/meal_tracker.dart';

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Walking Tracker'),
            Tab(text: 'Meal Tracker'),
          ],

        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          buildWalkingTrackerTab(),
          MealTracker(),
        ],
      ),
    );
  }

  Widget buildWalkingTrackerTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16.0),
          Text('Daily Plan'),
          // Add your walking tracker plan widget here
        ],
      ),
    );
  }


}