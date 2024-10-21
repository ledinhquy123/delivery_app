import 'dart:convert';

import 'package:user_app/constants/apis.dart';
import 'package:http/http.dart' as http;
import 'package:user_app/constants/constants_export.dart';
import 'package:user_app/models/models_export.dart';

class DriverService {
  static Future<ApiResponse> getDriverList(String token) async {
    final uri = Uri.parse(GET_DRIVER_LIST);

    final headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse.fromMap(data);
      return apiResponse;
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }
}
