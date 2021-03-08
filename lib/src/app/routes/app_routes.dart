import 'package:flutter/widgets.dart';
import 'package:projeto_igreja/src/app/views/cellular_view/cellular_view.dart';
import 'package:projeto_igreja/src/app/views/church/church_view.dart';
import 'package:projeto_igreja/src/app/views/complete_profile/complete_profile_view.dart';
import 'package:projeto_igreja/src/app/views/event_register/event_register_view.dart';
import 'package:projeto_igreja/src/app/views/forgot_password/forgot_password_view.dart';
import 'package:projeto_igreja/src/app/views/home/home_view.dart';
import 'package:projeto_igreja/src/app/views/profile/profile_view.dart';
import 'package:projeto_igreja/src/app/views/sign_In/sing_in_view.dart';
import 'package:projeto_igreja/src/app/views/sign_up/sign_up_view.dart';

final Map<String, WidgetBuilder> routes = {
  SignInView.routeName: (context) => SignInView(),
  ForgotPasswordView.routeName: (context) => ForgotPasswordView(),
  SignUpView.routeName: (context) => SignUpView(),
  CompleteProfileView.routeName: (context) => CompleteProfileView(),
  HomeView.routeName: (context) => HomeView(),
  EventRegisterView.routeName: (context) => EventRegisterView(),
  ProfileView.routeName: (context) => ProfileView(),
  CellularView.routeName: (context) => CellularView(),
  ChurchView.routeName: (context) => ChurchView(),
};
