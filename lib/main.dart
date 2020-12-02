import 'package:cartrack/app.dart';
import 'package:cartrack/routes/home/home.dart';
import 'package:flutter/material.dart' show runApp;

void main() => runApp(CarTrackApp(CarTrackAppSession(child: HomePage())));

  