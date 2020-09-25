import 'package:countries/provider/rest_countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong/latlong.dart" as latLng;
import 'package:provider/provider.dart';

class CountryDetailsScreen extends StatelessWidget {
  final List<dynamic> coordinates;
  final String numericCode;
  final List<dynamic> borders;
  final List<dynamic> currency;
  final String name;
  CountryDetailsScreen({
    this.coordinates,
    this.borders,
    this.numericCode,
    this.currency,
    this.name,
  });

  String getCurrencies() {
    final List<String> localCurrencies = [];
    currency.forEach((element) {
      localCurrencies.add(element["name"]);
    });
    final string =
        localCurrencies.reduce((value, element) => value + ', ' + element);
    return string;
  }

  String getBorders(BuildContext context) {
    final List<String> countries = [];
    if (borders.length == 0) {
      return 'None';
    } else {
      borders.forEach((element) {
        countries.add(Provider.of<RestCountries>(context, listen: false)
            .getCountryName(element));
      });
      final string =
          countries.reduce((value, element) => value + ', ' + element);
      return string;
    }
  }

  @override
  Widget build(BuildContext context) {
    MapController mapController = MapController();
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.infinity,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                center: latLng.LatLng(coordinates[0], coordinates[1]),
                zoom: name == 'Russian Federation' ? 2.0 : 5.0,
              ),
              layers: [
                MarkerLayerOptions(
                  markers: [],
                ),
              ],
              children: <Widget>[
                TileLayerWidget(
                  options: TileLayerOptions(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/tonishiva/ckduqbyhs05kj19qngzgcswpy/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoidG9uaXNoaXZhIiwiYSI6ImNrZHVxODh1eDJhNHQyd21xdnN0ZmVieG4ifQ.NsQZXSLTOrVCPYOowGKi3g",
                    additionalOptions: {
                      'accessToken':
                          'pk.eyJ1IjoidG9uaXNoaXZhIiwiYSI6ImNrZHVxODh1eDJhNHQyd21xdnN0ZmVieG4ifQ.NsQZXSLTOrVCPYOowGKi3g',
                      'id': 'mapbox.mapbox-streets-v8',
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Numeric Code:'),
                        Text(numericCode),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Borders:'),
                        Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Text(
                            getBorders(context),
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Currencies:'),
                        Text(getCurrencies()),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
