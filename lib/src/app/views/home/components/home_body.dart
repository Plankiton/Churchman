import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'page_view_widget.dart';

import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';
import 'package:projeto_igreja/src/shared/constants.dart';

final api = ChurchAPI().client;
class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
      var token = stGetKey("user_token");
      final List<Object> arguments = ModalRoute.of(context).settings.arguments;
      if (arguments != null) {
        token = arguments[0];
      }

      try {
          api.post("/verify", options: Options(headers: {
              'Authorization': token,
          })).then((res) {
              if (res.statusCode != 200) {
                  Navigator.pushReplacementNamed(context, '/sign_in');
              }
          });
      } catch (e) {
      }


    return ListView(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              Expanded(child: PageViewWidget()),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              Expanded(child: PageViewWidget()),
            ],
          ),
        ),
      ],
    );
  }
}
