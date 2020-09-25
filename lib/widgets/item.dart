import 'package:countries/provider/country.dart';
import 'package:countries/screens/item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CountryItem extends StatelessWidget {
  final Country country;
  CountryItem({this.country});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryDetailsScreen(
              borders: country.borders,
              currency: country.currencies,
              coordinates: country.latlng,
              name: country.name,
              numericCode: country.numericCode,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.grey[100],
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  child: SvgPicture.network(
                    country.flag,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                    '${country.name}, ${country.alpha2Code}, ${country.subregion}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
