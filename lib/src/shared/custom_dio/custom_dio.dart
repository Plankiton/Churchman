import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/shared/custom_dio/interceptors.dart';
import '../constants.dart';

class ChurchAPI {
    final client = Dio();
    ChurchAPI() {
        client.interceptors.add(CustomInterceptors());
        client.options.baseUrl = BASE_URL;
        client.options.connectTimeout = 5000;
    }

}
