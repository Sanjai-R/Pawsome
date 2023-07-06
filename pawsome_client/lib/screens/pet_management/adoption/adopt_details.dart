import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/screens/pet_management/adoption/request.dart';
import 'package:pawsome_client/screens/pet_management/adoption/requested_pets.dart';
import 'package:provider/provider.dart';

class ViewAdoptDetails extends StatefulWidget {
  const ViewAdoptDetails({Key? key}) : super(key: key);

  @override
  State<ViewAdoptDetails> createState() => _ViewAdoptDetailsState();
}

class _ViewAdoptDetailsState extends State<ViewAdoptDetails>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<PetProvider>(context, listen: false).fetchAdoptData();
      Provider.of<AuthProvider>(context, listen: false).getAuthData();
    });
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
        leading: BackButton(
          onPressed: () {
            context.go('/');
          },
        ),
        title: Text(
          "Adopt Details",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Requests for your Pets'),
            Tab(text: 'Requested by you'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Consumer2<PetProvider, AuthProvider>(
            builder: (BuildContext context, PetProvider petProvider,
                AuthProvider authProivider, Widget? child) {
              final adopts = petProvider.adopts
                  .where((element) =>
                      element.pet?.userId == authProivider.user['userId'] && element.status == 'pending')
                  .toList();

              if (adopts.isEmpty) {
                return const Center(
                  child: Text('No Adopt Requests'),
                );
              } else {
                return Request(adopts: adopts);
              }
            },
          ),
          Consumer2<PetProvider, AuthProvider>(
            builder: (BuildContext context, PetProvider petProvider,
                AuthProvider authProivider, Widget? child) {
              final adopts = petProvider.adopts
                  .where((element) =>
                      element.buyerId == authProivider.user['userId'])
                  .toList();

              if (adopts.isEmpty) {
                return const Center(
                  child: Text('You have not requested any adoptions'),
                );
              } else {
                return RequestedPets(adopts: adopts);
              }
            },
          )
        ],
      ),
    );
  }

 
}
