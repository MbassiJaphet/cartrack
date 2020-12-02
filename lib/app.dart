import 'package:cartrack/routes/home/home.dart';
import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
class CarTrackApp extends StatelessWidget {
  // This widget is the root of your application.
  final CarTrackAppSession child;
  const CarTrackApp(this.child);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CarTrack',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
      onGenerateRoute: _getRoute,
      navigatorObservers: [routeObserver],
    );
  }
}

class CarTrackAppSession extends InheritedWidget {
  final bool isFirstUse;
  final bool userLoggedIn;
  final String password;
  final Widget child;

  CarTrackAppSession ({this.isFirstUse = false, this.password = 'password', this.userLoggedIn = false, this.child,}) : super(child : child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CarTrackAppSession of(BuildContext context) => 
    context.inheritFromWidgetOfExactType(CarTrackAppSession);
}
  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/home') {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => HomePage(),
        fullscreenDialog: true,
      );
    }else {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) => HomePage(),
        fullscreenDialog: true,
      );
    }
  }
