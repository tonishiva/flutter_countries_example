import 'package:flutter/material.dart';

class Country {
  final String name;
  final String subregion;
  final String alpha2Code;
  final String alpha3Code;
  final String flag;
  final List<dynamic> latlng;
  final String numericCode;
  final List<dynamic> borders;
  final List<dynamic> currencies;

  Country({
    this.name,
    this.subregion,
    this.alpha2Code,
    this.alpha3Code,
    this.flag,
    this.latlng,
    this.numericCode,
    this.borders,
    this.currencies,
  });
}
