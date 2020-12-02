import 'package:cartrack/models/car.dart';
import 'package:cartrack/models/command.dart';
import 'package:flutter/material.dart';
import 'package:cartrack/utilities/distance.dart';
import 'package:cartrack/routes/home/home.dart';

class CommandsPanel extends PopupRoute{
  CommandsPanel({
    this.barrierLabel,
    this.builder,
    this.theme,
    RouteSettings settings,
  }) : super(settings: settings){
    Commands.forEach((command){
       if(command.running)
         _runningCommands.add(CommandCard(command,this,isRunningCommand: true));
    });
  }
  String carName;
  String carId;
  String carAsset;
  final WidgetBuilder builder;
  final ThemeData theme;
  List<Widget> _runningCommands = [];

  @override
  Duration get transitionDuration =>  Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Color get barrierColor => Colors.white.withOpacity(0);

  @override
  Future get popped => end();

  @override
  void dispose() {
    print('Commands disposed');
    super.dispose();
  }

  void refreshRunningCommands(){
    this._runningCommands.clear();
    Commands.forEach((command){
       if(command.running)
         _runningCommands.add(CommandCard(command,this,isRunningCommand: true,));
    });
    this.setState(
      () {
        _runningCommands = _runningCommands;
      }
    );
  }

  Future<void> start(){
    print('Commnands\n');
    return null;
  }

  Future<void> end(){
    print('Commands\n');
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
    Navigator.push(context, CommandsPanel());
  }

  static void close(context){
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    this.carName = Car.selectedCar.value.name;
    this.carId = Car.selectedCar.value.id;
    this.carAsset = Car.selectedCar.value.asset;
    Widget commandsPanel = AnimatedPositioned(
      duration: Duration(milliseconds :200),
      child: Theme(
        data: ThemeData(
          primarySwatch: Colors.green,
          dividerColor: Colors.white,
          backgroundColor: Colors.transparent,
          canvasColor: Colors.black54,
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.transparent,
          cardTheme: CardTheme(
            margin: EdgeInsets.all(0),
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            elevation: 0
          ),
          iconTheme: IconThemeData(
            size: 28
          ),
        ),
        child: Material(
            child: Container(
            width: MediaQuery.of(context).size.width*0.85,
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                AnimatedContainer(
                  duration: Duration(milliseconds: 800),
                  padding: EdgeInsets.only(bottom: 12, left: 4),
                  height: 90 + MediaQuery.of(context).padding.top,
                  alignment: Alignment.bottomLeft,
                  color: Color(0xFF00600f).withOpacity(0.6),
                  child: Text(
                    'Commands',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none
                    ),
                  ),
                ),
                Divider(height: 0),
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
                Divider(height: 0),
                ExpansionTile(
                  title: Text('Recents', style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.access_time,),
                  ),
                Divider(height: 0),
                ExpansionTile(
                  key: UniqueKey(),
                  title: Text('Running', style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.autorenew,),
                  children: _runningCommands,
                ),
                Divider(height: 0),
                ExpansionTile(
                  initiallyExpanded: true,
                  title: Text('All', style: TextStyle(color: Colors.white),),
                  leading: Icon(Icons.view_module,),
                  children: <Widget>[
                    Container(
                      height: 400,
                      child: GridView.extent(
                        // maxCrossAxisExtent: MediaQuery.of(context).size.width*0.85/100,
                        maxCrossAxisExtent: 180,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        childAspectRatio: 11/6,
                        physics: const NeverScrollableScrollPhysics(),
                        children:  Commands.map<Widget>((Command command) {
                          return CommandCard(command,this);
                        }).toList(),
                        // children: Commands,
                      )
                    )
                  ],
                ),
                Divider(height: 0),
              ]
            )
          ),
        ),
      )
    );

    if (theme != null)
      commandsPanel = Theme(data: theme, child: commandsPanel);
    return Padding(
      // padding: only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.all(0),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          commandsPanel,
          Container(color: Color(0xFF00600f), height: MediaQuery.of(context).padding.top, margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width*0.15),)
        ],
      ),
    );
  }
}
