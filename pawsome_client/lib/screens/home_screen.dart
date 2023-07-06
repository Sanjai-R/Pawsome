import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/screens/events/event_screen.dart';
import 'package:pawsome_client/screens/pet_tracker/tracker/dashboard.dart';
import 'package:pawsome_client/screens/pet_tracker/tracker/tracker.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final List<Widget> _tabs = [
    const Dashboard(),
    Tracker(),
    const EventScreen(),
    EventTab(),
  ];

  @override
  Widget build(BuildContext context) {
  int _currentIndex = Provider.of<AppProvider>(context).currentIndex;
    return Scaffold(

      body: _tabs[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xffEDF2F7),
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
        title: const Text('Page 1'),
      ),
      body: const Center(
        child: Text('Page 1 content'),
      ),
    );;
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
