import 'package:cartrack/models/car.dart';
import 'package:cartrack/routes/home/home.dart';
import 'package:flutter/material.dart';
import 'package:cartrack/utilities/distance.dart';
import 'package:latlong/latlong.dart';

class CarSelector extends StatefulWidget {

  // ValueNotifier<CarSelectorMode> mode;
  Key key;
  final CarSelectorController controller;
  static ValueNotifier<CarSelectorMode> mode = ValueNotifier<CarSelectorMode>(CarSelectorMode.Normal);

  CarSelector({this.controller, this.key}):super(key: key){
    // this.mode = ValueNotifier<CarSelectorMode>(mode);
    // this.mode.addListener(() {this.createState();});
    if(this.controller != null)
      this.controller.selector = this;
  }
  @override
  _CarSelectorState createState() => _CarSelectorState();
}

class _CarSelectorState extends State<CarSelector> {

  CarSelectorMode mode;
  String carName;
  String carAsset;
  String carId;
  double distance;
  _CarSelectorState(){print('New car selector initialised\n');}
  @override
  Widget build(BuildContext context) {
    return Material(child: (this.mode == CarSelectorMode.Normal) ? normalModeBuilder() : selectionModeBuilder());
  }

  Widget normalModeBuilder(){
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 0, 8),
      child: Row(
        children: <Widget>[
          InkWell(
            child: Hero(transitionOnUserGestures: true,
              tag: 'Car image',
                child: AnimatedContainer(
                duration: Duration(milliseconds: 800),
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Colors.green
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(this.carAsset), fit: BoxFit.fill,)
                ),
              ),
            ),
            onTap: () {CarSelector.mode.value = CarSelectorMode.SelectionMode;}
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                this.carName,
                style: TextStyle(
                  fontWeight: FontWeight.w500
                )
              ),
              SizedBox(height: 2.5),
              Text(
                '${getDistance(HomePage.latlng, Car.selectedCar.value.latlng).toStringAsFixed(2)} km',
                style: TextStyle(
                  color: Color(0xFF616161),
                  decoration: TextDecoration.underline
                )
              ),
            ],
          )
        ],
      ),
    );
  }
  Widget selectionModeBuilder(){
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: Column(
        children: <Widget>[
          InkWell(
            onTap: () {},
            //splashColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 88,
                    width: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      image: DecorationImage(image: AssetImage(this.carAsset), fit: BoxFit.cover,)
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(this.carName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(height: 6),
                      Text(this.carId, style: TextStyle(fontSize: 16,)),
                      SizedBox(height: 6),
                      RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: '${getDistance(HomePage.latlng, Car.selectedCar.value.latlng).toStringAsFixed(2)} km',
                              style: TextStyle(color: Color(0xFF616161), fontSize: 16, decoration: TextDecoration.underline),
                            ),
                            TextSpan(text: ' from your position', style: TextStyle(color: Color(0xFF616161), fontSize: 16)),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                  Spacer(),
                  Icon(Icons.chevron_right),
                ]
              ),
            ),
          ),
          Divider(),
          Row(
            children: <Widget>[
              Text(
                '   Select a car',
                style: TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ),
              Spacer(),
              InkWell(
                  child: Icon(
                  Icons.search,
                ),
                onTap: () {},
              ),
              SizedBox(width: 6),
            ],
          ),
          Container(
            height: 114,
            child: ListView(
              children: CARS,
              scrollDirection: Axis.horizontal,
            ),
          ),
          Text(CARS.length.toString() + ' cars in total'),
        ]
      ),
    );
  }
  @override
  void initState() {
    super.initState();
    this.mode = CarSelector.mode.value;
    this.carName = Car.selectedCar.value.name;
    this.carId = Car.selectedCar.value.id;
    this.carAsset = Car.selectedCar.value.asset;
    CarSelector.mode.addListener(() {
      if(CarSelector.mode.value  == CarSelectorMode.Normal){
        print('Switching to selection mode!\n');
        switchToSelectionMode();
      }else{
        print('Switching to normal mode!\n');
        switchToNormalMode();
        switchToSelectionMode();
      }
    });
    Car.selectedCar.addListener(() {
      reset();
    });
  }
  void switchToNormalMode(){
    setState(() {
      this.mode = CarSelectorMode.Normal;
    });
  }
  void switchToSelectionMode(){
    setState(() {
      this.mode = CarSelectorMode.SelectionMode;
    });
  }
  void reset(){
    setState(() {
      this.carName = Car.selectedCar.value.name;
      this.carId = Car.selectedCar.value.id;
      this.carAsset = Car.selectedCar.value.asset;
      // this.mode = this.mode;
    });
  }
}

class CarSelectorController{
  CarSelector selector;
}

enum CarSelectorMode{
  Normal,
  SelectionMode
}