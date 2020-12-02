import 'package:cartrack/models/car.dart';
import 'package:flutter/material.dart';
import 'package:cartrack/utilities/distance.dart';
import 'package:cartrack/routes/home/home.dart';

class SettingsPanel extends PopupRoute{
  SettingsPanel({
    this.barrierLabel,
    this.builder,
    this.theme,
    // this.context,
    RouteSettings settings,
  }) : super(settings: settings);
  String carName;
  String carId;
  String carAsset;
  final WidgetBuilder builder;
  final ThemeData theme;
  // final BuildContext context;

  @override
  Duration get transitionDuration =>  Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.white.withOpacity(0);

  //@override
  //Future get popped => pet();

  @override
  Future get popped => end();
  @override
  void dispose() {
    print('Settings disposed');
    super.dispose();
  }

  Future<void> start(){
    print('Settings\n');
    return null;
  }

  Future<void> end(){
    print('Settings\n');
    return null;
  }

  AnimationController _animationController;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController = BottomSheet.createAnimationController(navigator.overlay);
    return _animationController;
  }

  static void show(context){
    Navigator.push(context, SettingsPanel());
  }

  static void close(context){
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    this.carName = Car.selectedCar.value.name;
    this.carId = Car.selectedCar.value.id;
    this.carAsset = Car.selectedCar.value.asset;
    Widget settingsPanel = AnimatedPositioned(
      duration: Duration(milliseconds :200),
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width*0.85,
          decoration: BoxDecoration(
            color: Colors.black54
          ),
          child: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 12, left: 4),
                height: 90 + MediaQuery.of(context).padding.top,
                alignment: Alignment.bottomLeft,
                color: Color(0xFF00600f).withOpacity(0.6),
                child: Text(
                  'Car Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none
                  ),
                )
              ),
              Divider(height: 0, color: Colors.white),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Hero(
                        tag: 'Car image',
                        transitionOnUserGestures: true,
                        child: Container(
                          height: 88,
                          width: 88,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            image: DecorationImage(image: AssetImage(this.carAsset), fit: BoxFit.cover,),
                            border: Border.all(
                              width: 0.5,
                              color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(this.carName, style: TextStyle(fontSize: 16,fontFamily: 'Roboto',color: Colors.white, fontWeight: FontWeight.w400, decoration: TextDecoration.none)),
                          SizedBox(height: 6),
                          Text(this.carId, style: TextStyle(fontSize: 15,fontFamily: 'Roboto',color: Colors.white, fontWeight: FontWeight.w400, decoration: TextDecoration.none)),
                          SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                text: '${getDistance(HomePage.latlng, Car.selectedCar.value.latlng).toStringAsFixed(2)} km',
                                  style: TextStyle(color: Color(0xFFc2c2c2), fontSize: 14, decoration: TextDecoration.underline),
                                ),
                                TextSpan(text: ' from your position', style: TextStyle(color: Color(0xFFc2c2c2), fontSize: 14),),
                              ],
                            ),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ],
                  ),
                )
              ),
              Divider(height: 0, color: Colors.white),
              ListTile(
                onTap: () {},
                title: Text(
                  'Command generation',
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                subtitle: Text(
                  'Generation 2',
                  style: TextStyle(
                    color: Colors.white70
                  )
                ),
              ),
              Divider(height: 0, color: Colors.white),
              ListTile(
                onTap: () {},
                title: Text(
                  'Continuos locate interval',
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                subtitle: Text(
                  '500 milliseconds',
                  style: TextStyle(
                    color: Colors.white70
                  )
                ),
              ),
              Divider(height: 0, color: Colors.white),
              ListTile(
                onTap: () {},
                title: Text(
                  'Time zone',
                  style: TextStyle(
                    color: Colors.white
                  )
                ),
                subtitle: Text(
                  'Buea, Cameroon',
                  style: TextStyle(
                    color: Colors.white70
                  )
                ),
              ),
              Divider(height: 0, color: Colors.white),
            ],
            
          )
        ),
      )
    );

    if (theme != null)
      settingsPanel = Theme(data: theme, child: settingsPanel);
    return Stack(
      children: <Widget>[
        settingsPanel,
      ],
    );
  }
}

