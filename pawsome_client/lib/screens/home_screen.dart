import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pawsome_client/screens/events/event_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    EventScreen(),
    WalkTrackerTab(),
    MealTrackerTab(),
    DashboardTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        // backgroundColor: Colors.white,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 2,

        selectedIndex: _currentIndex,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        labelBehavior: NavigationDestinationLabelBehavior.values[1],
        animationDuration: const Duration(seconds: 3),
        destinations: [
          NavigationDestination(
            icon: Icon(CupertinoIcons.home,),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.arrow_up_doc),

            label: 'Diary',
          ),
          NavigationDestination(
            icon: Icon(Icons.event_busy_rounded),

            label: 'Meal Tracker',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.profile_circled),
            selectedIcon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class EventTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Event Tab'),
    );
  }
}

class WalkTrackerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Walk Tracker Tab'),
    );
  }
}

class MealTrackerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Meal Tracker Tab'),
    );
  }
}

class DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Dashboard Tab'),
    );
  }
}
