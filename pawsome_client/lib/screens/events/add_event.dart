import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();
  late DateTime selectedDate;

  Map<String, dynamic> data = {
    "petId": 4,
    "eventDateTime": "2023-05-29T05:33:11.237Z",
    "eventTitle": "",
    "eventDesc": "Lorem",
    "hasReminder": false
  };
  TextEditingController _hasReminder = TextEditingController();
  bool _isLoading = false;
  bool hasReminder = false;

  void _onSubmit() {
    setState(() {
      _isLoading = true;
    });
    print(selectedDate);
    if (_title.text.isNotEmpty && _description.text.isNotEmpty) {
      data['eventTitle'] = _title.text;
      data['eventDesc'] = _description.text;
      data["eventDateTime"] = selectedDate;
      data['hasReminder'] = hasReminder;

      print(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Event",
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: DatePicker(
                      DateTime.now(),
                      initialSelectedDate: DateTime.now(),
                      selectionColor: theme.primary,
                      selectedTextColor: Colors.white,
                      onDateChange: (date) {
                        setState(() {
                          selectedDate = date;
                        });
                        print(date);
                      },
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 1.5),
                  MyCustomInput(
                    label: "Enter Title",
                    hintText: "Grooming",
                    type: "text",
                    onSaved: (va) {},
                    controller: _title,
                  ),
                  MyCustomInput(
                    label: "Enter Description",
                    hintText: "Grooming",
                    type: "text",
                    onSaved: (va) {},
                    controller: _description,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Reminder me before event",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Switch(
                        value: hasReminder,
                        onChanged: (val) {
                          setState(() {
                            hasReminder = !hasReminder;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 1.5),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Select Time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.fromDateTime(selectedDate),
                            );

                            if (pickedTime != null) {
                              setState(() {
                                selectedDate = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                                print(selectedDate);
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding,
                vertical: defaultPadding * 0.75,
              ),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: defaultPadding * 0.75,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _onSubmit,
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Create",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
