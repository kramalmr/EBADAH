import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

String cityData = "Jakarta";
String countryData = "Indonesia";


Future<Map<String, String>> getUserLocation() async {
  // Request permission
  LocationPermission permission = await Geolocator.requestPermission();
  if (permission == LocationPermission.denied ||
      permission == LocationPermission.deniedForever) {
    throw Exception("Location permission denied");
  }

  // Get current position
  Position position = await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
  );

  // Reverse geocode to get city/country
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );

  Placemark place = placemarks[0];
  return {
    "city": place.locality ?? "Unknown City",
    "country": place.country ?? "Unknown Country",
  };
}
