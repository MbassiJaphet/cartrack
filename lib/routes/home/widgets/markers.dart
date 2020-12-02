import 'package:flutter/material.dart';

class UserMarkerIcon extends StatelessWidget {

  double latitude;
  double longitude;
  UserMarkerIcon({this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.location_on),
        color: Colors.blue,
        iconSize: 40.0,
        onPressed: () {
          print('Marker tapped');
        },
      ),
    );
  }
}

class CarMarkerIcon extends StatelessWidget {

  double latitude;
  double longitude;

  CarMarkerIcon({this.latitude, this.longitude});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.location_on),
        color: Colors.green,
        iconSize: 40.0,
        onPressed: () {
          print('Marker tapped');
        },
      ),
    );
  }
}