import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdoptContainer extends StatefulWidget {
  const AdoptContainer({super.key});

  @override
  State<AdoptContainer> createState() => _AdoptContainerState();
}

class _AdoptContainerState extends State<AdoptContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 0.5,
            offset: const Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Adoption",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('View your Adoption status and details here'),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    context.go('/adopt');
                  },
                  child: const Text('View Adoptable Pets'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
