import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/event_colot_palatte.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:provider/provider.dart';

class Event {
  final String title;
  final String date;
  final String time;

  Event({required this.title, required this.date, required this.time});
}

class EventList extends StatefulWidget {

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<EventProvider>(context, listen: false).fetchAllEvents();
    });
    super.initState();
  }
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Events",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Consumer<EventProvider>(
                builder: (context, eventProvider, child) {

                  final events = eventProvider.events;
                  if (eventProvider.isLoading) {
                    return Center(
                      child: Text('loading'), // Loading indicator
                    );
                  }
                  return events.isEmpty
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
                        final event = events[index];
                        DateTime dateTime = DateTime.parse(event.eventDateTime.toString());

                        return Container(
                          width: 150, // Adjust the width as needed
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: EventPallate[event.eventTitle],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  event.eventTitle.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                RichText(
                                  text: TextSpan(
                                    text: DateFormat.MMMMd().format(dateTime),
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black),
                                    children: [
                                      TextSpan(
                                        text:',${DateFormat('h a').format(dateTime)}',
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
                  );
                }

    )
            ],
          )),
    );
  }
}
