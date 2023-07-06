
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/screens/pet_management/home/categories.dart';
import 'package:pawsome_client/screens/pet_management/home/components/banner.dart';
import 'package:pawsome_client/screens/pet_management/home/components/custom_app_bar.dart';
import 'package:pawsome_client/screens/pet_management/pet/pet_list.dart';
import 'package:provider/provider.dart';

class PetHomePage extends StatefulWidget {
  const PetHomePage({super.key});

  @override
  State<PetHomePage> createState() => _PetHomePageState();
}

class _PetHomePageState extends State<PetHomePage> {
  bool isSearchPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).getAuthData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder:
        (BuildContext context, AuthProvider authProvider, Widget? child) {
      final authData = authProvider.user;
      return Scaffold(
        // backgroundColor: Colors.grey.shade100,
        appBar: CustomAppBar(
          authData: authData,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hey ${authData['username']},",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: defaultPadding),
                const HomeBanner(),
                const SizedBox(height: defaultPadding),
// Banner(),
                const PetCategories(),
                const SizedBox(height: defaultPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular Pets',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'See All',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ],
                ),
                const PetList(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
