import 'dart:core';
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:projeto_igreja/src/shared/utils.dart';
import 'package:projeto_igreja/src/shared/constants.dart';
import 'package:projeto_igreja/src/app/constants.dart';
import 'package:projeto_igreja/src/app/size_config.dart';
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

class ProfileBody extends StatefulWidget {
    @override
    _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
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

    Map<String,dynamic> user = {
        "name": null,
    };
    var cover = null;
    var clocking = null;
    void setUser(Map<String,dynamic> data) {
        setState(() {
            user = data;
        });
    }
    void setClocking(List<dynamic> data) {
        setState(() {
            clocking = data;
        });
    }
    void setCover(String data) {
        setState(() {
            cover = data;
        });
    }
    Widget Cover(String uri) {
        final UriData data = Uri.parse(uri).data;
        var bytes = data.contentAsBytes();
        return Image.memory(bytes);
    }

    var token = null;

  @override
  Widget build(BuildContext context) {
      if (token == null) {
          try {
              getUserToken().then((res) {
                  setState(() {
                      token = res;
                  });
              });
          } catch(e) {
              Navigator.pushReplacementNamed(context, '/sign_in');
          }
      }

      if (user["name"] == null && token != null) {
          try {
              api.get("/user/1", options: Options(
                    headers: {
                        "Authorization": token,
                    })).then((res) {
                  var data = jsonDecode(res.data);

                  setUser(data["data"]);
              }).catchError((e) {
                  var data = jsonDecode(e.response.data);
                  addError(error: data["message"]);
              });
          } catch (e) {
              addError(error: "Não foi possível baixar dados da igreja");
          }
      }
      if (cover == null && token != null) {
          try {
              api.get("/user/1/profile", options: Options(
                    headers: {
                        "Authorization": token,
                    })).then((res) {
                  setCover(res.data);
              }).catchError((e) {
              });
          } catch (e) {
          }
      }

    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Column(
                children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SingleChildScrollView(
                            padding: EdgeInsets.all(30.0),
                            scrollDirection: Axis.vertical,
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                                child: Column(children: [
                                    FormError(errors: errors),

                                    SizedBox(height: SizeConfig.screenHeight * 0.04,),
                                    DefaultOpenText(
                                        title: user["name"]!=null?user["name"]:"Carregando...",
                                        subtitle: ''),

                                    cover == null?Text(""):Cover(cover),

                                    SizedBox(height: getProportionateScreenHeight(40),),
                                    SizedBox(height: SizeConfig.screenHeight * 0.02)],
                                ),
                            ),
                        )),

                    DefaultButton(
                        text: "Criar Evento, Culto ou Post",
                        press: () async {
                            setErrors([]);
                        },
                    )
                ]
            )
        )
    );
  }
}
