import 'package:countries/provider/country.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class RestCountries with ChangeNotifier {
  List<Country> _countriesList = [];
  List<Country> _allCountries = [];

  List<Country> get countriesList {
    return [..._countriesList];
  }

  String getCountryName(String code) {
    String countryName = code;
    _allCountries.forEach((element) {
      if (element.alpha3Code == code) {
        countryName = element.name;
      }
    });
    return countryName;
  }

  Future<void> getCountries() async {
    var url = 'https://restcountries.eu/rest/v2/region/europe';
    Dio dio = Dio();
    try {
      Response response = await dio.get(url);
      print(response.statusCode);
      List extractedCountries = response.data;
      List<Country> loadedCountries = [];
      extractedCountries.forEach((element) {
        loadedCountries.add(Country(
          name: element["name"],
          alpha2Code: element["alpha2Code"],
          alpha3Code: element["alpha3Code"],
          borders: element["borders"],
          subregion: element["subregion"],
          currencies: element["currencies"],
          flag: element["flag"],
          latlng: element["latlng"],
          numericCode: element["numericCode"],
        ));
      });
      _countriesList = loadedCountries;
      url = 'https://restcountries.eu/rest/v2/all';
      List<Country> allCountries = [];
      response = await dio.get(url);
      List newExtractedCountries = response.data;
      newExtractedCountries = response.data;
      newExtractedCountries.forEach((element) {
        allCountries.add(Country(
          name: element["name"],
          alpha2Code: element["alpha2Code"],
          alpha3Code: element["alpha3Code"],
          borders: element["borders"],
          subregion: element["subregion"],
          currencies: element["currencies"],
          flag: element["flag"],
          latlng: element["latlng"],
          numericCode: element["numericCode"],
        ));
      });
      _allCountries = allCountries;
    } on DioError catch (error) {
      if (error.response != null) {
        print(error.response.statusCode);
        print(error.response.statusMessage);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(error.request);
        print(error.message);
      }
      throw error;
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
