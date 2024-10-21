import 'dart:convert';

import 'package:user_app/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:user_app/constants/constants_export.dart';
import 'package:user_app/models/api_response.dart';

class AuthServicer {
  static Future<ApiResponse> login(Map<String, dynamic> data) async {
    final uri = Uri.parse(LOGIN_URL);

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(data)
    );

    if(response.statusCode == 200) {
      final data = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromMap(data); 
      return apiResponse;
    } else if(response.statusCode == 500) {
      return const ApiResponse(
        success: false, 
        data: null, 
        message: INVALID
      );
    }
    return const ApiResponse(
      success: false, 
      data: null, 
      message: SOME_THING_WENT_WRONG
    );
  }

  static Future<ApiResponse> register(Map<String, dynamic> data) async {
    final uri = Uri.parse(REGISTER_URL);

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json"
    };

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(data)
    );

    if(response.statusCode == 200) {
      final data = json.decode(response.body);
      ApiResponse apiResponse = ApiResponse.fromMap(data); 
      return apiResponse;
    } else if(response.statusCode == 500) {
      return const ApiResponse(
        success: false, 
        data: null, 
        message: INVALID
      );
    }
    return const ApiResponse(
      success: false, 
      data: null, 
      message: SOME_THING_WENT_WRONG
    );
  }
}