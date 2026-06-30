import '../../domain/entities/account_entity.dart';

class AccountModel {
  final String name;
  final String number;
  final double balance;

  const AccountModel({
    required this.name,
    required this.number,
    required this.balance,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      name: json['name'] as String,
      number: json['number'] as String,
      balance: (json['balance'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'number': number,
        'balance': balance,
      };

  AccountEntity toEntity() {
    return AccountEntity(
      name: name,
      number: number,
      balance: balance,
    );
  }

  factory AccountModel.fromEntity(AccountEntity entity) {
    return AccountModel(
      name: entity.name,
      number: entity.number,
      balance: entity.balance,
    );
  }
}
