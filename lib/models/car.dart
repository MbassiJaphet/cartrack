import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:cartrack/routes/home/widgets/markers.dart';


class Car extends StatefulWidget {

  static final ValueNotifier<Car> selectedCar = ValueNotifier<Car>(CARS[0]);

  final String asset;
  final String name;
  final String id;
  double latitude;
  double longitude;
  bool isSelected = false;
  Car({@required this.name, @required this.asset, @required this.id, this.latitude, this.longitude});

  get latlng => LatLng(this.latitude, this.longitude);

  @override
  _CarState createState() => _CarState(this);
  
  Marker getMarker(){
    return Marker(
      width: 40.0,
      height: 40.0,
      point: new LatLng(latitude, longitude),
      builder: (context) => CarMarkerIcon()
    );
  }
}

class _CarState extends State<Car> {

  Car car;
  bool _isSelected = false;
  _CarState(this.car);
  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: Duration(milliseconds: 500),
      padding: _isSelected ? const EdgeInsets.all(8.0) : const EdgeInsets.fromLTRB(8, 12, 8, 12),
      child: InkWell(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: _isSelected ? 98 : 90,
          alignment: Alignment.topRight,
          decoration: BoxDecoration(
            //color: Colors.white,
            image: DecorationImage(image: AssetImage(this.car.asset), fit: BoxFit.cover,),
            borderRadius: BorderRadius.all(Radius.circular(12),),
          ),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Icon(Icons.panorama_fish_eye, color: (_isSelected) ? Color(0xFF219653) : Color(0xFFc2c2c2)),
                Icon(Icons.brightness_1, color: (_isSelected) ? Color(0xFF6FCF97) : Colors.blueGrey.withOpacity(0.3), size: 20,)
              ],
            )
        ),
        onTap: () {Car.selectedCar.value = this.car;},
      ),
    );
  }
    
  @override
  void initState() {
    super.initState();
      if (Car.selectedCar.value.id == this.car.id)
        this._isSelected = true;
      else
        this._isSelected = false;
    Car.selectedCar.addListener(() {
      if (Car.selectedCar.value.id == this.car.id)
        this._isSelected = true;
        this._isSelected = false;
      reset();
    });
  }

  void reset() {
    setState(() {
      if (Car.selectedCar.value.id == this.car.id)
        _isSelected = true;
      else
        this._isSelected = false;
    });
  }
}

var CARS = [
  Car(
    asset: 'assets/car-1.jpg',
    name: 'Travelling car',
    id: 'YD 6589 AW',
    latitude: 3.875,
    longitude: 11.454,
  ),
  Car(
    asset: 'assets/car-2.jpg',
    name: 'City car',
    id: 'YD 6481 DY',
    latitude: 3.884,
    longitude: 11.519,
  ),
  Car(
    asset: 'assets/car-3.jpg',
    name: 'England taxi',
    id: 'LT 2648 BH',
    latitude: 4.046,
    longitude: 9.759,
  ),
  Car(
    asset: 'assets/car-4.jpg',
    name: 'Coxinelle 56',
    id: 'SW 4512 PJ',
    latitude: 4.086,
    longitude: 9.312,
  ),
  Car(
    asset: 'assets/car-5.jpg',
    name: 'My collection car',
    id: 'LT 0321 NB',
    latitude: 4.070,
    longitude: 9.715,
  ),
  Car(
    asset: 'assets/car-6.jpg',
    name: 'Funk car',
    id: 'LT 8745 ML',
    latitude: 4.000,
    longitude: 9.763,
  ),
  Car(
    asset: 'assets/car-7.jpg',
    name: 'My love\'s car',
    id: 'SW 2036 VC',
    latitude: 4.155,
    longitude: 9.233,
  ),
];