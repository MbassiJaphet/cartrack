import 'package:flutter_test/flutter_test.dart';
import 'dart:math' as math;
import 'package:latlong/latlong.dart';
import 'package:cartrack/models/car.dart';


double getDistance(LatLng ll_1, LatLng ll_2){
  return math.sqrt(math.pow(ll_1.latitude - ll_2.latitude, 2) + math.pow(ll_1.longitude - ll_2.longitude, 2)) * 100;
}
void main() {
  test('Distance between coordinates', () {
    final distance = getDistance(CARS[0].latlng, CARS[1].latlng);

    expect(distance,  math.sqrt(math.pow(CARS[0].latlng.latitude - CARS[1].latlng.latitude, 2) + math.pow(CARS[0].latlng.longitude - CARS[1].latlng.longitude, 2)) * 100);
  });
}