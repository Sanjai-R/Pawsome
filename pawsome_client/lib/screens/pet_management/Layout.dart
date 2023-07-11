import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/screens/news/news_screen.dart';
import 'package:pawsome_client/screens/pet_management/home/home_screen.dart';
import 'package:pawsome_client/screens/pet_management/pet/pet_list.dart';
import 'package:pawsome_client/screens/pet_management/tracker/dashboard.dart';
import 'package:pawsome_client/screens/profile/profile.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final List<Widget> _tabs = [
    const PetHomePage(),
    const NewsScreen(),
    const PetList(),
    const Dashboard(),
    const Profile(),
  ];
  final List<dynamic> _navItems = [
    {
      "icon": IconlyBold.home,
      "label": "Home",
    },
    {
      "icon": IconlyBold.document,
      "label": "News",
    },
    {
      "icon": IconlyBold.search,
      "label": "Explore",
    },
    {
      "icon": IconlyBold.chart,
      "label": "Dashboard",
    },
    {
      "icon": IconlyBold.profile,
      "label": "Profile",
    }
  ];

  @override
  Widget build(BuildContext context) {
    int currentIndex = Provider.of<AppProvider>(context).currentIndex;
    Color primaryColor = Theme.of(context).colorScheme.primary;
    Color mutedPrimaryColor = Theme.of(context).colorScheme.secondary; // Adjust the opacity as needed

    return Scaffold(
      body: _tabs[currentIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          Provider.of<AppProvider>(context, listen: false).changeIndex(index);
        },
        destinations: [
          for (var i in _navItems)
            NavigationDestination(
              icon: Icon(
                i["icon"],
                color: mutedPrimaryColor,
                size: 24,
              ),
              selectedIcon: Icon(i["icon"], color: primaryColor, size: 24,),
              label: i["label"],
            )
        ],
      ),
    );
  }
}
