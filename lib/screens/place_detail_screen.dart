import 'package:flutter/material.dart';
import './map_screen.dart';
import '../providers/great_places.dart';
import 'package:provider/provider.dart';

class PlaceDetailScreen extends StatelessWidget {
  static const routeName = '/place-detail';
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final placeData =
        Provider.of<GreatPlace>(context, listen: false).getPlaceById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(placeData.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              placeData.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(height: 10),
          Text(
            placeData.description,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).accentColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Address: ${placeData.location.address}',
            style: TextStyle(
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => MapScreen(
                    initialLocation: placeData.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: Text(
              'Show on Map',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
