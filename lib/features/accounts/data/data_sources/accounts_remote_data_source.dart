import '../models/account.dart';

class AccountsRemoteDataSource {
  // final HttpClient _httpClient = HttpClient();

  Future<List<AccountModel>> getAccounts() async {
    // TODO: Descomentar cuando el API esté disponible
    // Response response = await _httpClient.get("/accounts");
    // return (response.data as List)
    //     .map((e) => AccountModel.fromJson(e as Map<String, dynamic>))
    //     .toList();

    // Mock data
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      const AccountModel(name: 'Corriente', number: '1234', balance: 1500.50),
      const AccountModel(name: 'Ahorros', number: '5678', balance: 4200.00),
      const AccountModel(
          name: 'Tarjeta Crédito', number: '9012', balance: 2250.75),
    ];
  }
}
