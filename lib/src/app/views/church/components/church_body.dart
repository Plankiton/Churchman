import 'dart:core';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:projeto_igreja/src/app/components/default_open_text.dart';
import 'package:projeto_igreja/src/app/components/no_account_component.dart';
import 'package:projeto_igreja/src/app/components/social_card_component.dart';

import 'package:projeto_igreja/src/app/components/default_button_component.dart';
import 'package:projeto_igreja/src/app/components/form_error_component.dart';
import 'package:projeto_igreja/src/app/views/sign_In/components/custom_svg_icon.dart';

import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';
import 'package:projeto_igreja/src/shared/constants.dart';

final api = ChurchAPI().client;

class ChurchBody extends StatefulWidget {
  @override
  _ChurchBodyState createState() => _ChurchBodyState();
}

class _ChurchBodyState extends State<ChurchBody> {
    final List<String> errors = [];
    void addError({String error}) {
        if (!errors.contains(error)) {
            setState(() {
                errors.add(error);
            });
        }
    }

    void removeError({String error}) {
        if (errors.contains(error)) {
            setState(() {
                errors.remove(error);
            });
        }
    }

    void setErrors(List<String> e) {
        errors?.map((err) {
            removeError(error: err);
        });

        e?.map((err) {
            addError(error: err);
        });
    }

    Map<String,dynamic> church = {
        "name": null,
        "clocking": null,
    };
    void setChurch(Map<String,dynamic> data) {
        setState(() {
            church = data;
        });
    }

  @override
  Widget build(BuildContext context) {
      if (church["name"] == null) {
          try {
              var token = stGetKey("user_token").then((r) {
                  api.get("/celule/1", options: Options(headers: {
                      'Authorization': r,
                  })).then((res) {
                      var data = jsonDecode(res.data);

                      print("\n\n\n\n");
                      print(data["data"]);
                      print("\n\n\n\n");

                      setChurch(data["data"]);
                  }).catchError((e) {
                      var data = jsonDecode(e.response.data);
                      addError(error: data["message"]);
                  });
              });
          } catch (e) {
              addError(error: "Não foi possível baixar dados da igreja");
          }
      }

    return SafeArea(
                child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                                child: Column(children: [FormError(errors: errors),
                                        SizedBox(height: SizeConfig.screenHeight * 0.04,),
                                        DefaultOpenText(
                                                title: church["name"]!=null?church["name"]:"Carregando...",
                                                subtitle: ''),

                                        SingleChildScrollView(
                                            child: Column(
                                                    children: [
                                                        // SizedBox(height: SizeConfig.screenHeight * 0.07,),
                                                        // SizedBox(height: getProportionateScreenHeight(40),),

                                                        // SizedBox(height: getProportionateScreenHeight(40),),
                                                        // SizedBox(height: SizeConfig.screenHeight * 0.02),

                                                        DefaultButton(
                                                                text: "Criar Evento, Culto ou Post",
                                                                press: () async {
                                                                    setErrors([]);
                                                                },
                                                                ),
                                                                ],
                                                                ),
                                                                )]),
                        ),
                        ),
                        );
  }
}
