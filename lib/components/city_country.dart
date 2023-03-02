import 'package:flutter/material.dart';

class CityCountry extends ChangeNotifier {
  final List _cityCountry = [
    'Milan,Italy',
    'Rome,Italy',
    'Bologna,Italy',
    'Paris,France',
    'Madrid,Spain',
    'Cape Town,South Africa',
    'New York,USA',
    'Carlifornia,USA',
    'Sao Paulo,Brazil',
  ];

  // get method for city description

  get cityCountry => _cityCountry;
}
