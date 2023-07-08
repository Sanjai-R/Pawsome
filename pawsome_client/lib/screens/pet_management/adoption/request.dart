import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/model/adopt_model.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:provider/provider.dart';

class Request extends StatefulWidget {
  final List<AdoptModel> adopts;

  const Request({super.key, required this.adopts});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  void onSubmit(data) async {
    final res = await Provider.of<PetProvider>(context, listen: false)
        .updateStatus(data);
    if (res['status']) {
      context.go('/');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Adopt request sent'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to send request'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: ListView.builder(
          itemCount: widget.adopts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: const EdgeInsets.all(defaultPadding),
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
                      widget.adopts[index].pet!.image!,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: defaultPadding / 2),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                '${widget.adopts[index].pet!.name!} - ${widget.adopts[index].pet!.breed!} ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: defaultPadding / 2),
                            Center(
                                child: Text(
                              "Buyer Details",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            )),
                            _buildText(
                                "Username",
                                widget.adopts[index].buyer!.username!
                                    .toString()),
                            _buildText("mobile",
                                widget.adopts[index].buyer!.mobile!.toString()),
                            _buildText(
                                "Requested Date",
                                DateFormat('dd-MM-yyyy')
                                    .format(widget.adopts[index].date!)),
                            const SizedBox(height: defaultPadding / 2),
                            Row(
                              children: [
                                Expanded(
                                  child: FilledButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF38A169),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      final data =
                                          widget.adopts[index].toJson();
                                      data['status'] = 'approved';

                                      onSubmit(data);
                                    },
                                    child: const Text(
                                      'Accept',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: FilledButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFFE53E3E),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    onPressed: () {
                                      final data =
                                          widget.adopts[index].toJson();
                                      data['status'] = 'rejected';

                                      onSubmit(data);
                                    },
                                    child: const Text(
                                      'Reject',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]))
                ],
              ),
            );
          },
        ));
  }

  Widget _buildText(icon, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Icon(icon),
        Text('$icon: ',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary)),
        Text(value,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                // color: Theme.of(context).colorScheme.secondaryContainer,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
