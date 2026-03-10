import 'package:dio/dio.dart';
import 'mock_interceptor.dart';

class HttpClient {

  late Dio dio;

  HttpClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.fakebankprueba.com",
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
      ),
    );

    // Interceptor para simular respuestas
    dio.interceptors.add(MockInterceptor());
  }

  Future<Response> get(String path) async {
    return await dio.get(path);
  }

  Future<Response> post(String path, dynamic data) async {
    return await dio.post(path, data: data);
  }

}