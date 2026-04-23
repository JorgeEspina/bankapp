import 'package:fluter_test_luis1/core/environment/env.dart';
import 'package:fluter_test_luis1/main.dart';

void main(List<String> args) {
  Env.environment = Environment.production;
  runProject();
}