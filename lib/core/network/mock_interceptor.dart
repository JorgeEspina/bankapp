import 'package:dio/dio.dart';

class MockInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    // Simulación de endpoint
    if (options.path == "/accounts") {

      final mockResponse = [
        {
          "id": 1,
          "name": "Cuenta Ahorro",
          "balance": 2500.75
        },
        {
          "id": 2,
          "name": "Cuenta Monetaria",
          "balance": 780.50
        }
      ];

      handler.resolve(
        Response(
          requestOptions: options,
          statusCode: 200,
          data: mockResponse,
        ),
      );

      return;
    }

    handler.next(options);
  }
}