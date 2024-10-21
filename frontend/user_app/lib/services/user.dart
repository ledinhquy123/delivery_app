import 'dart:convert';

import 'package:user_app/app_export.dart';
import 'package:user_app/constants/constants_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<ApiResponse> activeUser(String token, Map<String, dynamic> data, String userId) async {
    final uri = Uri.parse('$ACTIVE_USER/$userId');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.put(uri, headers: headers, body: jsonEncode(data));
    log('SERVICE: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse.fromMap(data);
      return apiResponse;
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> logout(String token) async {
    final uri = Uri.parse(LOGOUT_URL);

    final headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.post(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse.fromMap(data);
      return apiResponse;
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  // Don't need token
  static Future<ApiResponse> getUserNotifications(String guard, String id) async {
    final uri = Uri.parse('$GET_USER_NOTIFICATIONS$guard&id=$id');

    final headers = {
      "Accept": "application/json"
    };

    final response = await http.get(
      uri,
      headers: headers
    );

    if(response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
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

  static Future<ApiResponse> updateProfile(String token, Map<String, dynamic> data, String userId) async {
    final uri = Uri.parse('$UPDATE_PROFILE/$userId');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.put(uri, headers: headers, body: jsonEncode(data));
    log('SERVICE: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse.fromMap(data);
      return apiResponse;
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }
}