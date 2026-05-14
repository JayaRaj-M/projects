import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';
import '../core/services/storage_service.dart';

class ApiService {
  static Map<String, String> get _headers => {
    'Content-Type': ApiConstants.contentType,
    'Authorization': '${ApiConstants.bearerPrefix}${StorageService.getString(StorageService.keyAuthToken) ?? ''}',
  };

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final res = await http.get(Uri.parse('${ApiConstants.baseUrl}$endpoint'), headers: _headers);
    return _handle(res);
  }

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    final res = await http.post(
      Uri.parse('${ApiConstants.baseUrl}$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handle(res);
  }

  static Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body) async {
    final res = await http.put(
      Uri.parse('${ApiConstants.baseUrl}$endpoint'),
      headers: _headers,
      body: jsonEncode(body),
    );
    return _handle(res);
  }

  static Future<Map<String, dynamic>> delete(String endpoint) async {
    final res = await http.delete(Uri.parse('${ApiConstants.baseUrl}$endpoint'), headers: _headers);
    return _handle(res);
  }

  static Map<String, dynamic> _handle(http.Response res) {
    final data = jsonDecode(res.body);
    if (res.statusCode >= 200 && res.statusCode < 300) return data;
    throw Exception(data['message'] ?? 'API error ${res.statusCode}');
  }
}