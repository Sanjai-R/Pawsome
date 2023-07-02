
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/provider/event_provider.dart';
import 'package:pawsome_client/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class AddEvent extends StatefulWidget {
  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Provider.of<EventProvider>(context, listen: false).data['eventTitle'] !=
        null) {
      _title.text =
          Provider.of<EventProvider>(context, listen: false).data['eventTitle'];
    } else {
      selectedDate = DateTime.now();
    }
  }

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  late DateTime selectedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool hasReminder = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        Provider.of<EventProvider>(context, listen: false).data;
    final theme = Theme.of(context).colorScheme;
    void onSubmit() async {
      if (_formKey.currentState!.validate()) {
        setState(() => _isLoading = true);
        _formKey.currentState!.save();
        data['eventTitle'] = _title.text;
        data['eventDesc'] = _description.text;
        data["eventDateTime"] = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
            .format(selectedDate.toUtc());
        data['hasReminder'] = hasReminder;
        final res = await Provider.of<EventProvider>(context, listen: false)
            .postEvent(data);
        if (res != null) {
          setState(() {
            _isLoading = false;
          });
        }

        if (res['status']) {
          setState(() => _isLoading = false);
          Provider.of<AppProvider>(context, listen: false).changeIndex(2);
          context.go('/');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res['message']),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }

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
        leading: IconButton(
          onPressed: () {
            Provider.of<AppProvider>(context, listen: false).changeIndex(2);
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
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
                  DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: theme.primary,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) {
                      setState(() {
                        selectedDate = date;
                      });

                    },
                    height: 100,
                  ),
                  const SizedBox(height: defaultPadding * 1.5),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                      ],
                    ),
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
                  Row(
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
                        icon: const Icon(Icons.access_time),
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
                  onPressed: onSubmit,
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
