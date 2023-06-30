import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pawsome_client/core/constant/event_colot_palatte.dart';

class EventCategoryList extends StatelessWidget {
  final List<String> categories;

  const EventCategoryList({Key? key, required this.categories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0, bottom: 8.0),
          child: Text(
            "Choose category and create event",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Expanded(
          child: GridView.builder(
            // shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1 / 0.3),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: EventPallate[categories[index]],
                ),
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8.0),
                height: 15,
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline_rounded),
                    SizedBox(width: 8.0),
                    Text(
                      categories[index],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,),
                    ),
                  ],
                ),
              );
            },
            itemCount: categories.length,
          ),
        ),
      ],
    );
  }
}
