import 'package:dio/dio.dart';
import '../../../../core/network/http_client.dart';

class AccountsService {

  final HttpClient _httpClient = HttpClient();

  Future<List<dynamic>> getAccounts() async {

    Response response = await _httpClient.get("/accounts");

    return response.data;
  }

}