import 'package:flutter/material.dart';
import 'package:pawsome_client/core/constant/event_colot_palatte.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:provider/provider.dart';

class Event {
  final String title;
  final String date;
  final String time;

  Event({required this.title, required this.date, required this.time});
}

class EventList extends StatelessWidget {
  final List<Event> events = [
    Event(title: "Grooming", date: "15 March", time: "3.00pm"),
    Event(title: "Parasite", date: "15 March", time: "3.00pm"),
    Event(title: "Vaccination", date: "15 March", time: "3.00pm"),
    // Event(title: "Medications", date: "15,March", time: "3.00pm"),
    // Event(title: "Training", date: "15,March", time: "3.00pm"),
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(5.0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
        ),
        // Adjust the height as needed
        child: Consumer<EventProvider>(
          builder: (context, data, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Events",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                events.isEmpty
                    ? Container(
                        height: 80, // Adjust the height as needed
                        alignment: Alignment.center,
                        child: const Text(
                          "No events today",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : SizedBox(
                        height: 80, // Adjust the height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: events.length,
                          itemBuilder: (context, index) {
                            Event event = events[index];
                            return Container(
                              width: 150, // Adjust the width as needed
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: EventPallate[event.title],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      event.title,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    RichText(
                                      text: TextSpan(
                                        text: event.date,
                                        style: const TextStyle(
                                            fontSize: 14, color: Colors.black),
                                        children: [
                                          TextSpan(
                                            text: ', ${event.time}',
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
