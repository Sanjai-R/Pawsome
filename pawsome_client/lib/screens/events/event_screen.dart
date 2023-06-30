import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/screens/events/components/event_category_list.dart';
import 'package:pawsome_client/screens/events/components/event_container.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  final List<String> _list = [
    "Grooming",
    "Parasite",
    "Vaccination",
    "Vet Visit",
    "Medications",
    "Nutrition",
    "Training",
    "Custom Event"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffF9FAFB),
      appBar: AppBar(
        title: Text("Event Calander"),
        centerTitle: true,
        backgroundColor: Color(0xffF9FAFB),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        // height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Today,", style: headingStyle),
                      Text(
                        DateFormat.MMMMd().format(DateTime.now()),
                        style: headingStyle,
                      ),
                    ],
                  )
                ],
              ),
            ),
            // EventList(),
            Expanded(child: EventCategoryList(categories: _list)),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
                      padding: EdgeInsets.symmetric(vertical: 12)),
                  onPressed: () {
                    context.go('/event/add');
                  },
                  icon: Icon(
                    Icons.add,
                    size: 24,
                  ),
                  label: Text(
                    "Add Event",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
            // EventCategoryList(events: _list)
          ],
        ),
      ),
    );
  }

  TextStyle get subheadingStyle {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.grey,
    );
  }

  TextStyle get headingStyle {
    return const TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  }
}
