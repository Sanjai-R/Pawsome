import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:pawsome_client/screens/events/components/event_category_list.dart';
import 'package:pawsome_client/screens/events/components/event_container.dart';
import 'package:provider/provider.dart';

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
    DateTime selectedDate =
        Provider.of<EventProvider>(context, listen: false).selectedDate;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Events",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            context.go('/');
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              GoRouter.of(context).go("/event/add");
            },
            icon: const Icon(IconlyBroken.calendar),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        // height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectionColor: Theme.of(context).colorScheme.primary,
                selectedTextColor: Colors.white,
                onDateChange: (date) {
                  setState(() {
                    Provider.of<EventProvider>(context, listen: false)
                        .setDate(date);
                  });
                },
                height: 100,
              ),
            ),
            EventList(),
            Expanded(child: EventCategoryList(categories: _list)),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
                      padding: const EdgeInsets.symmetric(vertical: 12)),
                  onPressed: () {
                    Provider.of<EventProvider>(context, listen: false)
                        .data['eventTitle'] = '';
                    context.go('/event/add');
                  },
                  icon: const Icon(
                    Icons.add,
                    size: 24,
                  ),
                  label: const Text(
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
