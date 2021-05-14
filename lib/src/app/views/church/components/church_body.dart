import 'dart:core';
import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';
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
    };
    var cover = null;
    var clocking = null;
    void setChurch(Map<String,dynamic> data) {
        setState(() {
            church = data;
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


    Widget Clocking(List<dynamic> clocking) {
        List<Widget> day_list = [];
        for (var i = 0; i < clocking.length; i++) {
            day_list.add(Padding(key: new Key("Clocking day ${i}"),
                    padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
                    child:Center(child:Column(children: [
                        Text(WEEK_DAY[clocking[i]["weekly_day"]-1]),
                        Text("Inicio: ${clocking[i]["begin"]}"),
                        Text("Fim:    ${clocking[i]["end"]}"),
                ]))));
        }

        return Row(key: new Key("Clocking"), children: day_list);

    }

  @override
  Widget build(BuildContext context) {
      if (church["name"] == null) {
          api.get("/celule/1").then((res) {
              var data = jsonDecode(res.data);

              setChurch(data["data"]);
          }).catchError((e) {
              try {
                  var data = jsonDecode(e.response.data);
                  addError(error: data["message"]);
              } catch (e) {
                  addError(error: "Sem conexão");
              }
          });
      }
      if (cover == null) {
          try {
              api.get("/celule/1/cover").then((res) {
                  setCover(res.data);
              }).catchError((e) {
              });
          } catch (e) {
          }
      }
      if (clocking == null) {
          // localhost:80/celule/1/events?periodic=true&l=7&p=1
          api.get("/celule/1/events",
                  queryParameters: {
                      'l': 7,
                      'p': 1,
                      'periodic': true,
                  }).then((res) {

              var data = jsonDecode(res.data);
              var form = new DateFormat("""yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS'Z'""");
              for (var i = 0; i < data["data"].length; i++) {
                  DateTime begin = form.parse(data["data"][i]["begin"]);
                  DateTime end = form.parse(data["data"][i]["end"]);
                  data["data"][i]["begin"] = "${begin.hour}:${begin.minute}";
                  data["data"][i]["end"] = "${end.hour}:${end.minute}";
              }

              setClocking(data["data"]);

          }).catchError((e) {
                      try {
                          var data = jsonDecode(e.response.data);
                          addError(error: data["message"]);
                      } catch (e) {
                          addError(error: "Sem conexão");
                      }
                  });
      }

    return SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Column(
                children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: SingleChildScrollView(
                            padding: EdgeInsets.all(50.0),
                            scrollDirection: Axis.vertical,
                                child: Column(children: [
                                    FormError(errors: errors),

                                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                                    DefaultOpenText(
                                        title: church["name"]!=null?church["name"]:"Carregando...",
                                        subtitle: ''),

                                    cover == null?Text(""):Cover(cover),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                                    DefaultOpenText(
                                        title: "Horarios dos cultos",
                                        subtitle: ''),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.04,),

                                    clocking == null?Text("Carregando..."):
                                    SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Clocking(clocking)
                                    ),

                                    SizedBox(height: getProportionateScreenHeight(40),),
                                    SizedBox(height: MediaQuery.of(context).size.height * 0.02)],
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
