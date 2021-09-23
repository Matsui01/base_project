import 'package:base_project/api/rest_client.dart';
import 'package:base_project/auth/authentication.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart' hide Headers;

class Example {
  // final logger = Logger();

  // Example() : restClient = RestClient(Dio(BaseOptions(headers: {"Authorization": Authentication().token})));

  void request1() {
    // restClient.getJokes().then((it) => logger.i(it));
  }
}
