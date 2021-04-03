import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:projeto_igreja/src/app/components/default_button_component.dart';
import 'package:projeto_igreja/src/app/components/form_error_component.dart';
import 'package:projeto_igreja/src/app/views/complete_profile/complete_profile_view.dart';
import 'package:projeto_igreja/src/app/views/sign_In/components/custom_svg_icon.dart';

import 'package:projeto_igreja/src/shared/constants.dart';
import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
    final api = ChurchAPI().client;

    final _formKey = GlobalKey<FormState>();

    String email;
    String password;
    String confirmPassword;
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
        e?.map((err) {
            addError(error: err);
        });
    }

    @override
    Widget build(BuildContext context) {
        final List<String> arguments = ModalRoute.of(context).settings.arguments;
        setErrors(ModalRoute.of(context).settings.arguments);

        return Form(
                key: _formKey,
                child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                        child: Column(
                                children: [
                                    buildEmailFormField(),
                                    SizedBox(height: getProportionateScreenHeight(30)),
                                    buildPasswordFormField(),
                                    SizedBox(height: getProportionateScreenHeight(30)),
                                    buildConfirmPasswordFormField(),
                                    FormError(errors: errors),
                                    SizedBox(height: getProportionateScreenHeight(40)),
                                    DefaultButton(
                                            text: "Continue",
                                            press: () async {
                                                if (_formKey.currentState.validate()) {
                                                    //Vá para a página de completar o perfil
                                                    _formKey.currentState.save();

                                                    try {
                                                        var response = await api.post('/user', data: {
                                                            'email': email,
                                                            'pass': password,
                                                        });

                                                        Navigator.pushReplacementNamed(
                                                                context, CompleteProfileView.routeName,
                                                                arguments: [email, password]);

                                                    } on DioError catch (e) {
                                                        try {
                                                            print(e.response.data);
                                                            print(e.response.headers);
                                                            print(e.response.request);
                                                            final Map data = e.response.data;
                                                            if (data["message"]) {
                                                                addError(error: data["message"]);
                                                            } else {
                                                                addError(error: STATUS_MSG[e.response.statusCode]);
                                                            }
                                                        } catch (e){
                                                            addError(error: 'Verifique sua conexão com a internet');
                                                        }

                                                    }

                                                }
                                            },
                                    ),
                                ],
                                ),
                                ),
                                );
    }

    TextFormField buildConfirmPasswordFormField() {
        return TextFormField(
                obscureText: true,
                onSaved: (newValue) => confirmPassword = newValue,
                onChanged: (value) {
                    if (value.isNotEmpty) {
                        removeError(error: kPassNullError);
                    } else if (value.isNotEmpty && password == confirmPassword) {
                        removeError(error: kMatchPassError);
                    }
                    confirmPassword = value;
                },
                validator: (value) {
                    if (value.isEmpty) {
                        addError(error: kPassNullError);
                        return "";
                    } else if ((password != value)) {
                        addError(error: kMatchPassError);
                        return "";
                    }
                    return null;
                },
        decoration: InputDecoration(
                            labelText: 'Confirmar Senha',
                            hintText: 'Reescreva sua Senha',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSuffixIcon(
                                    svgIcon: 'assets/icons/Lock.svg',
                            ),
                    ),
        );
    }

    TextFormField buildPasswordFormField() {
        return TextFormField(
                obscureText: true,
                onSaved: (newValue) => password = newValue,
                onChanged: (value) {
                    if (value.isNotEmpty) {
                        removeError(error: kPassNullError);
                    } else if (value.length >= 8) {
                        removeError(error: kShortPassError);
                    }
                    password = value;
                },
                validator: (value) {
                    if (value.isEmpty) {
                        addError(error: kPassNullError);
                        return "";
                    } else if (value.length < 8) {
                        addError(error: kShortPassError);
                        return "";
                    }
                    return null;
                },
        decoration: InputDecoration(
                            labelText: 'Senha',
                            hintText: 'Digite sua Senha',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSuffixIcon(
                                    svgIcon: 'assets/icons/Lock.svg',
                            ),
                    ),
        );
    }

    TextFormField buildEmailFormField() {
        return TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (newValue) => email = newValue,
                onChanged: (value) {
                    if (value.isNotEmpty) {
                        removeError(error: kEmailNullError);
                    } else if (emailValidatorRegExp.hasMatch(value)) {
                        removeError(error: kInvalidEmailError);
                    }
                    return null;
                },
                validator: (value) {
                    if (value.isEmpty) {
                        addError(error: kEmailNullError);
                        return "";
                    } else if (!emailValidatorRegExp.hasMatch(value)) {
                        addError(error: kInvalidEmailError);
                        return "";
                    }
                    return null;
                },
        decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Digite o seu Email',
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: CustomSuffixIcon(
                                    svgIcon: 'assets/icons/Mail.svg',
                            ),
                    ),
        );
    }
}
