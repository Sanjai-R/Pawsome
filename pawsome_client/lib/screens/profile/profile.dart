import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/provider/tracker_provider.dart';
import 'package:pawsome_client/screens/profile/bookmark.dart';
import 'package:pawsome_client/screens/profile/donated_pet.dart';
import 'package:pawsome_client/widgets/adopt_container.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/components/sign_up_form.dart';

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
      context.read<PetProvider>().getBookmarks(user['userId']);
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
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('authData');
              if (context.mounted) {
                Provider.of<AuthProvider>(context, listen: false).clear();
                Provider.of<AppProvider>(context, listen: false).clear();
                Provider.of<EventProvider>(context, listen: false).clear();
                Provider.of<PetProvider>(context, listen: false).clear();
                Provider.of<TrackerProvider>(context, listen: false).clear();
                context.go('/login');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logout Success'),
                    backgroundColor: Colors.green,
                  ),
                );
              }

              // Add your logout functionality here
            },
          ),
        ],
      ),
      body: Consumer2<AuthProvider, PetProvider>(
        builder: (context, AuthProvider authProvider, PetProvider petProvider,
            child) {
          final authData = authProvider.user;

          final petData = petProvider.myPets;
          final savedData = petProvider.bookmarks;
          // print(savedData);
          final adoptedData = petProvider.adopts
              .where((element) =>
                  element.pet?.userId == authProvider.user['userId'])
              .toList();
          final pets = petData
              .where((element) => element.userId == authData['userId'])
              .toList();
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
            child: Column(
              children: [
                _buildProfile(authData, petData, adoptedData),
                const SizedBox(height: defaultPadding),
                TabBar(
                  controller: tabController,
                  tabs: const [
                    Tab(text: 'Saved'),
                    Tab(text: 'Your Pets'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      BookMark(bookmarks: savedData),
                      DonatedPets(pets: pets),
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

  Widget _buildProfileAnalytics(authData, petData, adoptedData) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildAnalyticsCard('Adopted', adoptedData.length.toString()),
          _buildAnalyticsCard('Challanges', '2'),
          _buildAnalyticsCard('Posted', petData.length.toString()),
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

  Widget _buildProfile(authData, petData, adoptedData) {
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
                  authData['profile'] ??
                      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                  fit: BoxFit.cover,
                  width: double.infinity, // or set a specific value
                  height: double.infinity, // or set a specific value
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            _buildProfileAnalytics(authData, petData, adoptedData),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Text(
          authData['username'],
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
        ),
        const SizedBox(height: defaultPadding / 2),
        Text(
          authData['email'],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 16,
              ),
        ),
        const SizedBox(height: defaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              IconlyLight.location,
              size: 20,
            ),
            const SizedBox(
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
        const SizedBox(height: defaultPadding),
        Container(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              openBottomSheet(context, authData);
            },
            child: const Text('Edit Profile'),
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

  void openBottomSheet(BuildContext context, dynamic user) {
    bool isLoading = false;
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    final TextEditingController _location = TextEditingController();

    final TextEditingController _mobile = TextEditingController();
    final TextEditingController _image = TextEditingController();

    _location.text = user['location'];
    _mobile.text = user['mobile'];
    _image.text = user['profile'];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update Profile',
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                // optional padding around the container
                child: Column(
                  children: [
                    SignUpForm(formKey: _formKey, inputs: [

                      {
                        'label': 'Location',
                        'hintText': 'Chennai,TN',
                        'type': 'text',
                        'controller': _location
                      },
                      {
                        'label': 'Mobile',
                        'hintText': "1234567890",
                        'type': 'number',
                        'controller': _mobile
                      },
                      {
                        'label': 'Image URL',
                        'hintText': 'https://example.com/image.png',
                        'type': 'text',
                        'controller': _image,
                      },
                    ])
                    ,
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 1,
                            padding: const EdgeInsets.symmetric(vertical: 12)),
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            user['location'] = _location.text;
                            user['mobile'] = _mobile.text;
                            user['profile'] = _image.text;
                            final res = await context.read<AuthProvider>().updateProfile(user);
                           if(res['status']){
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(res['message']),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                           }else{
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(res['message']),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              Navigator.pop(context);
                           }
                          }
                        },

                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              )
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
