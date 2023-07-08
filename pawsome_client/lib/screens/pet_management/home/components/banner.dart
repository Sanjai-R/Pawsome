
import 'package:flutter/material.dart';


class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: const DecorationImage(
                image:NetworkImage(
                  "https://img.freepik.com/free-photo/lovely-pet-portrait-isolated_23-2149192357.jpg?w=900&t=st=1688361622~exp=1688362222~hmac=1dd88a6d80b8e10d4d66662e976b03502c7bd4ea7fc5b0dccb038166f222728f",
                  ),
                fit: BoxFit.cover,
              ),
            ),

          ),
          Positioned(
            left: 0,
            bottom: 20,
            right: MediaQuery.of(context).size.width * 0.5,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Adopting can be one of the best rewarding",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                  fontWeight: FontWeight.bold
                ),


              ),
            ),
          )
        ],
      ),
    );
  }
}
