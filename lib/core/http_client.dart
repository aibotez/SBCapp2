import 'package:dio/dio.dart';

class HttpClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.10.102:8000/api",
        headers: {
          "Authorization": "Token ec8f71c374befa66207ff50f826f8169738d8d81"
        },
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );
}