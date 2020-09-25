import 'package:countries/provider/rest_countries.dart';
import 'package:countries/widgets/item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Europe'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.error != null) {
              return Center(
                child: Column(
                  children: [
                    Text(
                      'We have an error',
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return Consumer<RestCountries>(
                builder: (ctx, countriesData, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: countriesData.countriesList.length,
                  itemBuilder: (ctx, i) => CountryItem(
                    country: countriesData.countriesList[i],
                  ),
                ),
              );
            }
          },
          future:
              Provider.of<RestCountries>(context, listen: false).getCountries(),
        ),
      ),
    );
  }
}
