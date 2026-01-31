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
    try {
      final logger = Logger();
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
      logger.i("Status code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      log("ApiService.post error:${e.toString()}");
    }
  }

  static Future get(String endpoints, String? token) async {
    try {
      final url = "$baseUrl/$endpoints";
      final uri = Uri.parse(url);
      final response = await http.get(
        uri,
        headers: {
          "Content-Type": "application/json",
          if (token != null) "Authorization": "Bearer $token",
        },
      );
      log("Status code: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      log("ApiService.get error:${e.toString()}");
    }
  }
}
