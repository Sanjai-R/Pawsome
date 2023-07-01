import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/screens/events/event_screen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Widget> _tabs = [
    DashboardTab(),
    WalkTrackerTab(),
    const EventScreen(),
    MealTrackerTab(),
  ];

  @override
  Widget build(BuildContext context) {
  int _currentIndex = Provider.of<AppProvider>(context).currentIndex;
    return Scaffold(

      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        // backgroundColor: Colors.white,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 2,

        selectedIndex: _currentIndex,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (index) {
          Provider.of<AppProvider>(context, listen: false).changeIndex(index);

        },
        labelBehavior: NavigationDestinationLabelBehavior.values[1],
        animationDuration: const Duration(seconds: 3),
        destinations: const [
          NavigationDestination(
            icon: Icon(
              IconlyLight.home,
            ),
            selectedIcon: Icon(IconlyBold.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.heart),
            selectedIcon: Icon(IconlyBold.heart),
            label: 'Diary',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.calendar),
            selectedIcon: Icon(IconlyBold.calendar),
            label: 'Meal Tracker',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.user),
            selectedIcon: Icon(IconlyBold.user_2),
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 1'),
      ),
      body: Center(
        child: Text('Page 1 content'),
      ),
    );;
  }
}

class WalkTrackerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 2'),
      ),
      body: Center(
        child: Text('Page 3 content'),
      ),
    );;
  }
}

class MealTrackerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Meal Tracker Tab'),
    );
  }
}

class DashboardTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Dashboard Tab'),
    );
  }
}
