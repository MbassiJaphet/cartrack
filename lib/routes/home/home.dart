import 'package:cartrack/app.dart';
import 'package:cartrack/models/car.dart';
import 'package:cartrack/routes/home/commands/commands.dart';
import 'package:cartrack/routes/home/widgets/appbar.dart';
import 'package:cartrack/routes/home/widgets/car_selector.dart';
import 'package:cartrack/routes/home/widgets/markers.dart';
import 'package:cartrack/routes/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {

  static LatLng latlng = LatLng(0.0, 0.0);

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {

  final CarSelectorController deviceController = CarSelectorController();
  CarSelectorMode selectorMode;
  Map<String, double> userLocation;
  Widget bkgd_map;
  LocationData currentLocation;
  double latitude = 0.0;
  double longitude = 0.0;
  static MapController  mapController = MapController();

  Location location;
  Widget carSelector;
  static bool isOnTop = true;
  List<Marker> markers = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void initState(){
    super.initState();

    getLocation().then((results) {
      setState(() {
        print('\nSetting State\n');
        bkgd_map = FlutterMap(
          mapController: mapController,
          key: UniqueKey(),
          options: MapOptions(
            center: LatLng(latitude, longitude),
            minZoom: 4.0,
            zoom: 15
          ),
          layers: [
            TileLayerOptions(
              urlTemplate:
                'https://api.mapbox.com/styles/v1/mbassijaphet/cjxvzuqy509441cqpv3akmyop/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoibWJhc3NpamFwaGV0IiwiYSI6ImNqeHZ4cTFzbzA0NWQzbXFwc3Y0N2U1YncifQ.S23RA3hkB-ka0MCqcEux5g',
              additionalOptions: {
                'accessToken': 'pk.eyJ1IjoibWJhc3NpamFwaGV0IiwiYSI6ImNqeHZ4cTFzbzA0NWQzbXFwc3Y0N2U1YncifQ.S23RA3hkB-ka0MCqcEux5g',
                'id': 'mapbox.mapbox-streets-v7'
              },
              maxZoom: 18,
            ),
            MarkerLayerOptions(
              markers: markers,
            )
          ]
        );
      });  
    });

    CarSelector.mode.addListener(() {
      setState(() {
        selectorMode = CarSelector.mode.value;
      });
    });
    bkgd_map = SizedBox();
    carSelector = CarSelector(key: UniqueKey());
    selectorMode = CarSelector.mode.value;
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    print('Route was pushed\n');
    setState(() {
    //  isOnTop = true; this.
    });
  }

  @override
  void didPopNext() {
    print('Backgroup map\n');
    setState(() {
     isOnTop = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          child: Scaffold(
        body: Stack(
          children: <Widget>[
            bkgd_map,
            Align(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).padding.top,
                        color: Colors.green,
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 2000),
                        alignment: Alignment.bottomCenter,
                        padding: (isOnTop) ? EdgeInsets.all(0) : EdgeInsets.fromLTRB(0, 0, 0, 58),
                        height: 58,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            CustomAppBar(title: 'Search in douala'),
                          ],
                        ),
                      )
                    ]
                  ),
                ],
              ),
            ),
            // Car selector & bottom navigation
            Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: (selectorMode == CarSelectorMode.Normal) ? 124 : 298,
                child: Theme(
                  data: ThemeData(
                    canvasColor: Colors.transparent,
                  ),
                                  child: ListView(
                    padding: EdgeInsets.all(0),
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      // Car selector
                      carSelector,
                      // Bottom navigation bar
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        height: (selectorMode == CarSelectorMode.Normal) ? 62 : 0,
                        child: BottomNavigationBar(
                          currentIndex: 1,
                          elevation: 12.0,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          onTap: (index) {(index == 0) ? SettingsPanel.show(context) : CommandsPanel.show(context);},
                          backgroundColor: Colors.white.withOpacity(0.9),
                          items: [
                            BottomNavigationBarItem(
                              title: Text("Settings"),
                              icon: Icon(Icons.settings, color: Color(0xFF212121))
                            ),
                            BottomNavigationBarItem(
                              title: Text("Commands"),
                              icon: Stack(alignment: Alignment.center ,children: <Widget>[Icon(Icons.code,size: 32, color: Color(0xFF212121)), Icon(Icons.code,size: 24, color: Color(0xFF212121))])
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                width: 80,
                height: (selectorMode == CarSelectorMode.SelectionMode) ? 425 : 210,
                padding: EdgeInsets.fromLTRB(0, 0, 16, (selectorMode == CarSelectorMode.SelectionMode) ? 300 : 60),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    FloatingActionButton(
                      heroTag: 'user_location',
                      backgroundColor: Colors.white,
                      child: Icon(Icons.my_location, color: Color(0xFF00600f)),
                      onPressed: () {mapController.move(LatLng(latitude, longitude), 15);},
                    ),
                    SizedBox(height: 8),
                    FloatingActionButton(
                      heroTag: 'car_location',
                      backgroundColor: Color(0xFF00600f),
                      child: Icon(Icons.location_on, color: Colors.white),
                      onPressed: () {mapController.move(LatLng(Car.selectedCar.value.latitude, Car.selectedCar.value.longitude), 15);},
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onWillPop: exit,
    );
  }
  
  void initMarkers(){
    markers.clear();
    markers.add(
      Marker(
        width: 40.0,
        height: 40.0,
        point: new LatLng(latitude, longitude),
        builder: (context) => UserMarkerIcon()
      )
    );
    CARS.forEach((car) {
      markers.add(car.getMarker());
    });
  }

  Future<void> getLocation() async{
      location = Location();
      currentLocation = await location.getLocation();
      latitude = double.parse(currentLocation.latitude.toStringAsFixed(3));
      longitude = double.parse(currentLocation.longitude.toStringAsFixed(3));
      HomePage.latlng = LatLng(latitude, longitude);
      
      initMarkers();
  }

  Future<bool> exit() async{
    print(CarSelector.mode.value);
    if(CarSelector.mode.value == CarSelectorMode.SelectionMode){
      print('Testing mode switching\n');
      CarSelector.mode.value = CarSelectorMode.Normal;
      this.setState(() {
        carSelector = CarSelector(key: UniqueKey());
      });
      return false;
    }
    print('\nWill not pop up\n');
    print(CarSelector.mode.value);
    return false;
  }
}
