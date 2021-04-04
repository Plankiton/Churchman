import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';
import 'package:projeto_igreja/src/shared/constants.dart';

final api = ChurchAPI().client;

Future<Map<String,dynamic>> getUserData(String else_token) async {
    var token = stGetKey("user_token");
    if (token == "")
        token = else_token;

    try {
        var res = await api.post("/verify", options: Options(headers: {
            "Authorization": token,
        }));

        var user = jsonDecode(res.data)["data"];
        stSetKey("user_data", user);
        return user;

    } on DioError catch(e) {
        return jsonDecode(stGetKey("user_data"));
    }
}

