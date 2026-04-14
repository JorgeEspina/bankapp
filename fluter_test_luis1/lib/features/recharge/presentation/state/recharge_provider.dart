import 'package:flutter/material.dart';

class RechargeProvider extends ChangeNotifier {
  String phone = "";
  String network = "";
  String amount = "";

  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }

  void setNetwork(String value) {
    network = value;
    notifyListeners();
  }

  void setAmount(String value) {
    amount = value;
    notifyListeners();
  }
}