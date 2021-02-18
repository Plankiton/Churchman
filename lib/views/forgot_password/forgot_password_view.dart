import 'package:flutter/material.dart';
import 'package:projeto_igreja/views/forgot_password/components/forgot_password_body.dart';

class ForgotPasswordView extends StatelessWidget {
  static String routeName = '/forgot_password';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Esqueci Minha Senha'),
        centerTitle: true,
      ),
      body: ForgotPasswordBody(),
    );
  }
}
