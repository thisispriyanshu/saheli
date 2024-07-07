import 'dart:convert';
import 'dart:io';

import 'package:Saheli/apiRepository/apiHttpResponse.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String domain = 'https://saheli-backend-ufs3.onrender.com/';

Future<ApiHttpResponse> callPostMethod(Map<String, dynamic> authData, String apiUrl) async {
  try {
    String url = domain + apiUrl;
    debugPrint(url);
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'accept': ' */*'
    };

    http.Response response = await http.post(Uri.parse(url), body: json.encode(authData), headers: header);
    ApiHttpResponse apiResponse = ApiHttpResponse();

    apiResponse.responseCode = response.statusCode;
    apiResponse.responceString = response.body;

    return apiResponse;
  } on SocketException catch (_) {
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.message = _.message;
    apiResponse.responceString = json.encode({
      "success": false,
      "message": _.message
    });
    return apiResponse;
  } catch (e) {
    debugPrint("catch error $e");
    ApiHttpResponse apiResponse = ApiHttpResponse();
    apiResponse.responseCode = 401;
    apiResponse.responceString = json.encode({
      "success": false,
      "message": 'someThingWentWrong'
    });
    return apiResponse;
  }
}