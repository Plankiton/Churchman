import 'package:flutter/material.dart';
import 'package:projeto_igreja/views/sign_In/components/sign_in_body.dart';

class SignInView extends StatelessWidget {
  static String routeName = '/sign_in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
      ),
      body: SignInBody(),
    );
  }
}
