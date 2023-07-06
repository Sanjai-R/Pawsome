import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../SizeConfig.dart';
import '../../../../core/constant/constant.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  late Map<String, dynamic> authData;

  CustomAppBar({super.key, required this.authData});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isSearchPressed = false;

  void toggleSearch() {
    setState(() {
      isSearchPressed = !isSearchPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        forceMaterialTransparency: true,
        backgroundColor: const Color(0xffF9FAFB),
        title: SizedBox(
          width: SizeConfig.screenWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: boxShadow,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: IconButton(
                  icon: Icon(
                    isSearchPressed
                        ? CupertinoIcons.xmark
                        : CupertinoIcons.search,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: toggleSearch,
                ),
              ),
              !isSearchPressed
                  ? Row(
                      children: [
                        Icon(
                          IconlyLight.location,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Text(
                          'Chennai,TN',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.grey[200],
                      ),
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextFormField(
                        // Customize the TextFormField as needed
                        decoration: InputDecoration(
                          prefixIcon: const Icon(CupertinoIcons.search),
                          hintText: 'Enter your search query',
                          contentPadding: const EdgeInsets.all(16.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.grey[200],
                          hintStyle: TextStyle(color: Colors.grey[600]),
                          filled: true,
                        ),
                      ),
                    ),
              const CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(

                    'https://img.freepik.com/premium-photo/digital-painting-boy-with-freckles-red-hoodie_921202-1.jpg?size=626&ext=jpg&ga=GA1.2.873758883.1686891337&semt=sph'),
              ),
            ],
          ),
        ));
  }
}
