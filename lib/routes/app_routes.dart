import 'package:flutter/widgets.dart';
import 'package:projeto_igreja/views/forgot_password/forgot_password_view.dart';
import 'package:projeto_igreja/views/sign_In/sing_in_view.dart';
import 'package:projeto_igreja/views/sign_In/user_form_view.dart';
import 'package:projeto_igreja/views/user_list_view.dart';

final Map<String, WidgetBuilder> routes = {
  UserListView.routeName: (context) => UserListView(),
  UserFormView.routeName: (context) => UserFormView(),
  SignInView.routeName: (context) => SignInView(),
  ForgotPasswordView.routeName: (context) => ForgotPasswordView(),
};
