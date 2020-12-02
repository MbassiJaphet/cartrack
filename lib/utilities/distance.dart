import 'dart:math' as math;
import 'package:latlong/latlong.dart';


double getDistance(LatLng ll_1, LatLng ll_2){
  return math.sqrt(math.pow(ll_1.latitude - ll_2.latitude, 2) + math.pow(ll_1.longitude - ll_2.longitude, 2)) * 100;
}