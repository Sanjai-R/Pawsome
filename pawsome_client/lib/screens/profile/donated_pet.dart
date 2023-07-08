import 'package:flutter/material.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/core/constant/event_colot_palatte.dart';

class DonatedPets extends StatefulWidget {
  final dynamic pets;
  const DonatedPets({super.key, required this.pets});

  @override
  State<DonatedPets> createState() => _DonatedPetsState();
}

class _DonatedPetsState extends State<DonatedPets> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
        itemCount: widget.pets.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              boxShadow: boxShadow,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.pets[index].image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.pets[index].name!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.pets[index].description!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 5),

                    ],
                  ),
                ),
              ],
            ),
          );
        },

      ),
    );
  }
}
