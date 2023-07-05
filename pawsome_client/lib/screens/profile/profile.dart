import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/provider/tracker_provider.dart';
import 'package:pawsome_client/screens/profile/donated_pet.dart';
import 'package:pawsome_client/widgets/adopt_container.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<AuthProvider>().getAuthData();
      final user = context.read<AuthProvider>().user;
      Provider.of<PetProvider>(context, listen: false)
          .fetchAllPetsByUser(user['userId']);
      context.read<PetProvider>().fetchAdoptData();
    });

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        actions: [
          IconButton(
            icon: const Icon(IconlyLight.logout),
            onPressed: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance() ;
              prefs.remove('authData');
              Provider.of<AuthProvider>(context, listen: false).clear();
               Provider.of<AppProvider>(context, listen: false).clear();
               Provider.of<EventProvider>(context, listen: false).clear();
               Provider.of<PetProvider>(context, listen: false).clear();
              Provider.of<TrackerProvider>(context, listen: false).clear();
              context.go('/login');
             ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logout Success'),
                  backgroundColor: Colors.green,
                ),
              );

              // Add your logout functionality here
            },
          ),
        ],

      ),
      body: Consumer2<AuthProvider, PetProvider>(
        builder: (context, AuthProvider authProvider, PetProvider petProvider,
            child) {
          final authData = authProvider.user;
          final petData = petProvider.pets;
          final adoptedData = petProvider.adopts
              .where((element) =>
                  element.pet?.userId == authProvider.user['userId'] )
              .toList();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                _buildProfile(authData,petData,adoptedData),
                SizedBox(height: defaultPadding),
                TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(text: 'Saved'),
                    Tab(text: 'Donated'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      DonatedPets(pets: adoptedData),
                      DonatedPets(pets:  adoptedData),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ));
  }

  Widget _buildProfileAnalytics(authData,petData,adoptedData) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnalyticsCard('Adopted', adoptedData.length.toString()),
          _buildAnalyticsCard('Challanges', '2'),
          _buildAnalyticsCard('Donated', petData.length.toString()),
        ],
      ),
    );
  }

  Widget _buildAnalyticsCard(title, value) {
    return Container(
      width: 90,
      height: 100,
      // margin: EdgeInsets.symmetric(horizontal: ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Color(0xffF5F5F5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildProfile(authData,petData,adoptedData) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  'https://img.freepik.com/premium-psd/3d-render-cartoon-avatar-isolated_570939-44.jpg?w=740',
                  fit: BoxFit.cover,
                  width: double.infinity, // or set a specific value
                  height: double.infinity, // or set a specific value
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            _buildProfileAnalytics(authData,petData,adoptedData),
          ],
        ),
        SizedBox(height: defaultPadding),
        Text(
          authData['username'],
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        SizedBox(height: defaultPadding / 2),
        Text(
          authData['email'],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 16,
              ),
        ),
        SizedBox(height: defaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              IconlyLight.location,
              size: 20,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              authData['location'],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontSize: 16,
                  ),
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            child: Text('Edit Profile'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
