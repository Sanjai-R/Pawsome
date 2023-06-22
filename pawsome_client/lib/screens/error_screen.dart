import 'package:flutter/material.dart';

class Error404Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://github.com/abuanwar072/20-Error-States-Flutter/blob/master/assets/images/2_404%20Error.png?raw=true",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.3,
            right: MediaQuery.of(context).size.width * 0.3,
            child: FilledButton(

              // color: Color(0xFF6B92F2),
              //
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(50)),
              onPressed: () {},
              child: Text(
                "Go Home".toUpperCase(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}