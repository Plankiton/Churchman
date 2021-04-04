import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'package:projeto_igreja/src/app/components/default_open_text.dart';
import 'package:projeto_igreja/src/app/components/no_account_component.dart';
import 'package:projeto_igreja/src/app/components/social_card_component.dart';
import 'package:projeto_igreja/src/app/views/home/home_view.dart';

import 'sign_form_component.dart';
import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';
import 'package:projeto_igreja/src/shared/constants.dart';

class SignInBody extends StatelessWidget {
    final api = ChurchAPI().client;

    @override
    Widget build(BuildContext context) {
        var token = stGetKey("token");
        try {
            api.post("/verify", options: Options(headers: {
                'Authorization': token,
            }));

            Navigator.pushReplacementNamed(context, HomeView.routeName, arguments: [token]);
        } catch (e) {
        }

        SizeConfig().init(context);
        return SafeArea(
                child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                                child: SingleChildScrollView(
                                        child: Column(
                                                children: [
                                                    SizedBox(height: SizeConfig.screenHeight * 0.04,),           
                                                    DefaultOpenText(
                                                            title: 'Seja Bem Vindo',
                                                            subtitle: 'Faça login com seu email e senha \nou continue com as redes sociais'),
                                                    SizedBox(height: SizeConfig.screenHeight * 0.07,),           
                                                    SignForm(),
                                                    SizedBox(height: getProportionateScreenHeight(40),),           
                                                    SizedBox(height: getProportionateScreenHeight(40),),
                                                    NoAccountText(),
                                                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                                                ],
                                        ),
                                ),
                        ),
                        ),
                        );
    }
}

