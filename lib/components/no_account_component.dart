import 'package:flutter/material.dart';
import 'package:projeto_igreja/size_config.dart';
import 'package:projeto_igreja/views/forgot_password/forgot_password_view.dart';

import '../constants.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Não possui uma conta? ',
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),

        ),
        GestureDetector(
          onTap: (){},
          child: Text(
            'Cadastrar',
            style: TextStyle(
              fontSize: getProportionateScreenWidth(16),
              color: kPrimaryColor,
            ),
            
          ),
        )
      ],
    );
  }
}