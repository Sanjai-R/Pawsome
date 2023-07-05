import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/screens/pet_management/home/home_screen.dart';
import 'package:pawsome_client/screens/pet_tracker/tracker/dashboard.dart';
import 'package:provider/provider.dart';
import '../home_screen.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<Widget> _tabs = [
    const PetHomePage(),
    EventTab(),
    EventTab(),
    Dashboard(),
    EventTab()
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<AppProvider>(context).currentIndex;
    return Scaffold(

      body: _tabs[currentIndex],
      bottomNavigationBar: NavigationBar(

        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 2,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        selectedIndex: currentIndex,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (index) {
          Provider.of<AppProvider>(context, listen: false).changeIndex(index);
        },

        animationDuration: const Duration(seconds: 1),
        destinations: [
          NavigationDestination(
            icon: Icon(IconlyLight.home,
                color: Theme.of(context).colorScheme.primary),
            selectedIcon: Icon(
              IconlyBold.home,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.heart,
                color: Theme.of(context).colorScheme.primary),
            selectedIcon: Icon(CupertinoIcons.heart_fill,
                color: Theme.of(context).colorScheme.primary),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(
              IconlyBold.plus,
              size: 40,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(IconlyLight.chart,
                color: Theme.of(context).colorScheme.primary),
            selectedIcon: Icon(IconlyBold.chart,
                color: Theme.of(context).colorScheme.primary),
            label: 'Account',
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.bag,
                color: Theme.of(context).colorScheme.primary),
            selectedIcon: Icon(CupertinoIcons.bag_fill,
                color: Theme.of(context).colorScheme.primary),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}
