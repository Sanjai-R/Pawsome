import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/core/constant/event_colot_palatte.dart';
import 'package:pawsome_client/model/adopt_model.dart';

class RequestedPets extends StatefulWidget {
  final List<AdoptModel> adopts;

  const RequestedPets({super.key, required this.adopts});

  @override
  State<RequestedPets> createState() => _RequestedPetsState();
}

class _RequestedPetsState extends State<RequestedPets> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView.builder(
        itemCount: widget.adopts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: boxShadow,
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14.0),
                  child: Image.network(
                    widget.adopts[index].pet!.image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.adopts[index].pet!.name.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  '12 KM away',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3.0),
                                color: statusBgColor[
                                    widget.adopts[index].status.toString()],
                              ),
                              child: Text(
                                widget.adopts[index].status.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: statusColor[widget
                                            .adopts[index].status
                                            .toString()]),
                              )),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          Text('Requested Data',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  )),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('MMMM d,yyyy').format(DateTime.parse(
                                widget.adopts[index].date.toString()!)),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary),
                          ),
                        ],
                      )
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
