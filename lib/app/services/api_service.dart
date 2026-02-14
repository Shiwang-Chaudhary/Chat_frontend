import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {
  static const baseUrl =
      // "https://shiwang-chat-backend.onrender.com";
      "http://192.168.1.4:3000";
  //We use {String? token} so that during function call, ApiService.post(body,"chat/",{"token":token})
  static Future post(Map body, String endpoints, {String? token}) async {
    final logger = Logger();
    try {
      final url = "$baseUrl/$endpoints";
      final uri = Uri.parse(url);
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i("Status code get: ${response.statusCode}");
      } else {
        logger.e("Status code: ${response.statusCode}");
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final data = jsonDecode(response.body);
        logger.e("Error:${data["message"]}");
      }
    } catch (e) {
      final logger = Logger();
      logger.e("ApiService.post error:${e.toString()}");
    }
  }

  static Future get(String endpoints, String? token) async {
    try {
      final logger = Logger();
      final url = "$baseUrl/$endpoints";
      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );
      logger.i("Status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      final logger = Logger();
      logger.e("ApiService.get error:${e.toString()}");
    }
  }

  static Future patch(Map body, String endpoints, {String? token}) async {
    final logger = Logger();
    try {
      final url = "$baseUrl/$endpoints";
      final uri = Uri.parse(url);
      final response = await http.patch(
        uri,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i("Status code get: ${response.statusCode}");
      } else {
        logger.e("Status code: ${response.statusCode}");
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        final data = jsonDecode(response.body);
        logger.e("Error:${data["message"]}");
      }
    } catch (e) {
      final logger = Logger();
      logger.e("ApiService.patch error:${e.toString()}");
    }
  }
}
