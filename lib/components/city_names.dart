import 'package:flutter/material.dart';

class CityNames extends ChangeNotifier {
  final List _cityName = [
    'Milan',
    'Rome',
    'Bologna',
    'Paris',
    'Madrid',
    'Cape Town',
    'New York',
    'Carlifonia',
    'Sao Paulo',
    'San Siro'
  ];

  // get method for city names

  get cityNames => _cityName;
}
