import 'dart:convert';
import 'dart:developer';

import 'package:user_app/constants/constants_export.dart';
import 'package:user_app/models/models_export.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static Future<ApiResponse> placeAnOrder(
      String token, Map<String, dynamic> data) async {
    final uri = Uri.parse(PLACE_AN_ORDER_URL);

    final headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    final response =
        await http.post(uri, headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ApiResponse apiResponse = ApiResponse.fromMap(data);
      return apiResponse;
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> getOrdersList(
      String date, String id, String guard, String token) async {
    final uri = Uri.parse('$GET_ORDER_LIST?date=$date&id=$id&guard=$guard');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> getSingleOrder(
      String orderId, String token) async {
    final uri = Uri.parse('$GET_SINGLE_ORDER/$orderId');

    final headers = {
      "Accept": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> getIncomeStatistic(
      String type, String id, String token) async {
    final uri = Uri.parse('$GET_INCOME_STATISTIC$type&id=$id');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.get(uri, headers: headers);
    log('DATA: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }

  static Future<ApiResponse> ratingDriver(String id, String token, Map<String, dynamic> data) async {
    final uri = Uri.parse('$RATING_DRIVER/$id');

    final headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    };

    final response = await http.put(uri, headers: headers, body: jsonEncode(data));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ApiResponse.fromMap(data);
    } else if (response.statusCode == 500) {
      return const ApiResponse(success: false, data: null, message: INVALID);
    }
    return const ApiResponse(
        success: false, data: null, message: SOME_THING_WENT_WRONG);
  }
}
