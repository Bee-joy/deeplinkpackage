import 'dart:io';
import 'package:deeplink/Enum/NetworkStatus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  Dio dio = Dio();
  ApiService() {
    dio.options.headers['content-Type'] = 'application/json';
  }

  final _storage = const FlutterSecureStorage();

  post(String url, data, context) async {
    var jwtToken = await _storage.read(key: 'token');
    dio.options.headers["authorization"] = "token $jwtToken";
    try {
      Response response = await dio.post(url, data: data);
      print(response.data);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return ApiResponse(status: NetworkStatus.SUCCESS, data: response.data);
      } else {
        throw DioErrorType.response;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        return ApiResponse(
            status: NetworkStatus.IDLE, error: e.response?.data['msg']);
      }
      if (e.error is SocketException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[400],
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'No internet Connection',
                ),
              ],
            ),
          ),
        );
        return ApiResponse(
            status: NetworkStatus.ERROR, error: "No internet Connection");
      } else {
        return ApiResponse(status: NetworkStatus.ERROR, error: e.message);
      }
    } catch (e) {
      print(e);
      return ApiResponse(status: NetworkStatus.ERROR, error: e.toString());
    }
  }

  get(String url, context) async {
    var jwtToken = await _storage.read(key: 'token');
    dio.options.headers["authorization"] = "token $jwtToken";

    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        return ApiResponse(status: NetworkStatus.SUCCESS, data: response.data);
      } else {
        throw DioErrorType.response;
      }
    } on DioError catch (e) {
      if (e.error is SocketException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red[400],
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  'No internet Connection',
                ),
              ],
            ),
          ),
        );
        return ApiResponse(
            status: NetworkStatus.ERROR, error: "No internet Connection");
      } else {
        return ApiResponse(status: NetworkStatus.ERROR, error: e.message);
      }
    } catch (e) {
      print(e);
      return ApiResponse(status: NetworkStatus.ERROR, error: e.toString());
    }
  }
}

/// ApiResponse has status, [NetworkStatus.Success] or [NetworkStatus.ERROR]. You can check status to decide wheteher to use [data] or [error] property.
class ApiResponse {
  final NetworkStatus status;
  final dynamic data;
  final String? error;
  ApiResponse({required this.status, this.data, this.error});
}
