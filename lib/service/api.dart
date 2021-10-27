import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_api/models/api_response.dart';
import 'package:login_api/models/api_error.dart';
import 'package:login_api/models/user.dart';

String _baseUrl = "http://192.168.0.151:9001";
Future<ApiResponse> authenticateUser(String username, String password) async {
  ApiResponse _apiResponse = ApiResponse();

  try {
    final response = await http.post(Uri.parse('$_baseUrl/user/login'), body: {
      'username': username,
      'password': password,
    });

    switch (response.statusCode) {
      case 200:
        _apiResponse.data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}

Future<ApiResponse> getUserDetails(String userId) async {
  ApiResponse _apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse('$_baseUrl/user/$userId'));

    switch (response.statusCode) {
      case 200:
        _apiResponse.data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        print((_apiResponse.ApiError as ApiError).error);
        _apiResponse.ApiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    _apiResponse.ApiError = ApiError(error: "Server error. Please retry");
  }
  return _apiResponse;
}
