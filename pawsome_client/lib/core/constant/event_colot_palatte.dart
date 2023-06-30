import 'dart:math';

import 'package:flutter/material.dart';
Color generateLightColor() {
  // Generate random RGB values
  List<int> rgbValues = List.generate(3, (index) => Random().nextInt(255));

  // Return a light color with the generated RGB values
  return Color.fromARGB(255, rgbValues[0], rgbValues[1], rgbValues[2]);
}
final EventPallate = {
  "Grooming": Color(0xFFDDEFB3),
  "Parasite":Color(0xFFDDEFB3),
  "Vaccination": Color(0xFFFFF9C4),
  "Vet Visit": Color(0xFFFFF9C4),
  "Medications": Color(0xFFFFEAD5),
  "Nutrition": Color(0xFFFFEAD5),
  "Training": Color(0xFFF4EBFF),
  "Custom Event": Color(0xFFF4EBFF),

};

