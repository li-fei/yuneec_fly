import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  MapPageState createState() => new MapPageState();
}

class MapPageState extends State<MapPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new FlutterMap(
      options: new MapOptions(
        center: new LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken': 'pk.eyJ1IjoieXVuZWVjZmVpIiwiYSI6ImNrOTJmemR3NjA4YTIzaGxoMTgzcW9uMHYifQ.BembqkRiN1tmo2PzytpdzA',
            'id': 'yuneecAirMap',
          },
        ),
//        new MarkerLayerOptions(
//          markers: [
//            new Marker(
//              width: 80.0,
//              height: 80.0,
//              point: new LatLng(51.5, -0.09),
//              builder: (ctx) => new Container(
////                child: new FlutterLogo(),
//              ),
//            ),
//          ],
//        ),
      ],
    );
  }
}
