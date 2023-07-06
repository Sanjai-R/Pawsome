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
                    widget.pets[index].pet!.image!,
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
                            widget.pets[index].pet!.name!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                color: statusBgColor[
                                widget.pets[index].status.toString()],
                              ),
                              child: Text(
                                widget.pets[index].status.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: statusColor[widget
                                        .pets[index].status
                                        .toString()]),
                              ))
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.pets[index].pet!.description!,
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
