import 'package:flutter/widgets.dart';
import 'package:projeto_igreja/views/complete_profile/complete_profile_view.dart';
import 'package:projeto_igreja/views/forgot_password/forgot_password_view.dart';
import 'package:projeto_igreja/views/sign_In/sing_in_view.dart';
import 'package:projeto_igreja/views/sign_up/sign_up_view.dart';
import 'package:projeto_igreja/views/user_list_view.dart';

final Map<String, WidgetBuilder> routes = {
  UserListView.routeName: (context) => UserListView(),
  SignInView.routeName: (context) => SignInView(),
  ForgotPasswordView.routeName: (context) => ForgotPasswordView(),
  SignUpView.routeName: (context) => SignUpView(),
  CompleteProfileView.routeName: (context) => CompleteProfileView(),
};
