import 'package:flutter/material.dart';
import 'package:projeto_igreja/components/no_account_component.dart';
import 'package:projeto_igreja/components/social_card_component.dart';
import 'package:projeto_igreja/size_config.dart';
import 'package:projeto_igreja/views/sign_In/components/sign_form_component.dart';

class SignInBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                Text("Seja Bem Vindo",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                    )),
                Text(
                  'Faça login com seu email e senha \nou continue com as redes sociais',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08,),           
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08,),           
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: 'assets/icons/google-icon.svg',
                      press: (){},
                    ),
                    SocialCard(
                      icon: 'assets/icons/facebook-2.svg',
                      press: (){},
                    ),
                    SocialCard(
                      icon: 'assets/icons/twitter.svg',
                      press: (){},
                    ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20),),
                NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

