import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import './place_detail_screen.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future:
            Provider.of<GreatPlace>(context, listen: false).fetchAndSetPlace(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlace>(
                child: Center(
                  child: const Text(
                    'Got no places yet, start adding some!',
                    style: TextStyle(
                        color: Colors.amber,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[i].image),
                              ),
                              title: Text(greatPlaces.items[i].title),
                              subtitle:
                                  Text(greatPlaces.items[i].location.address),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  PlaceDetailScreen.routeName,
                                  arguments: greatPlaces.items[i].id,
                                );
                              },
                            ),
                            Divider(),
                          ],
                        ),
                      ),
              ),
      ),
    );
  }
}
