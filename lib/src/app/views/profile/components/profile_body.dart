import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';
import 'package:projeto_igreja/src/shared/constants.dart';
import 'package:projeto_igreja/src/shared/utils.dart';


class ProfileBody extends StatefulWidget {
    @override
    _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
    @override
    Widget build(BuildContext context) {
        Map<String,dynamic> user = {};
        try {
            getUserData("").then((u) {
                user = u;
            });
        } catch(e) {}

        return Container(

        );
    }
}
