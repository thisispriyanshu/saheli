import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

Future<dynamic> makeSafeRouteRequest(LatLng source, LatLng destination, String mode) async {


  
  final url = Uri.parse('https://saheli-backend-ufs3.onrender.com/safest-route');

  print('Source: ${source}');
  print('Destination: ${destination}');
  print('Mode: ' + mode);
  
  final response = await http.post(
    url,
    body: {
      'source': {
        'lat': source.latitude,
        'lng': source.longitude,
      },
      'destination': {
        'lat': destination.latitude,
        'lng': destination.longitude,
      },
      'mode': mode,
    },
  );

  print(response.statusCode);
  
  if (response.statusCode == 200) {
    // Request successful
    final body = jsonDecode(response.body);
    print('Safe route request successful');
    List steps = body["safestRoute"]['legs'][0]['steps'];
    print(steps); 
    return steps;

  } else {
    // Request failed
    print('Safe route request failed');
  }
}
