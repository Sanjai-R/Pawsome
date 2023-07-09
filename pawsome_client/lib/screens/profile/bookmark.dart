import 'package:flutter/material.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/model/bookmark_model.dart';

class BookMark extends StatefulWidget {
  final List<dynamic> bookmarks;
  const BookMark({super.key, required this.bookmarks});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  @override
  Widget build(BuildContext context) {
    if(widget.bookmarks.isEmpty){
      return const Center(
        child: Text('No Bookmarks'),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.builder(
        itemCount: widget.bookmarks.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            decoration: BoxDecoration(
              boxShadow: boxShadow
              ,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.bookmarks[index].pet!.image.toString(),
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
                            widget.bookmarks[index].pet!.name!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.bookmarks[index].pet!.description!,
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
