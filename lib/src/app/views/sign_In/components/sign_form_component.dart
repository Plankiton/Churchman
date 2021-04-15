import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:projeto_igreja/src/app/components/default_button_component.dart';
import 'package:projeto_igreja/src/app/components/form_error_component.dart';
import 'package:projeto_igreja/src/app/views/forgot_password/forgot_password_view.dart';
import 'package:projeto_igreja/src/app/views/home/home_view.dart';

import 'package:dio/dio.dart';
import 'package:projeto_igreja/src/shared/custom_dio/custom_dio.dart';
import 'package:projeto_igreja/src/shared/constants.dart';

import 'custom_svg_icon.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
    final api = ChurchAPI().client;
    final _formKey = GlobalKey<FormState>();
    String email;
    String password;
    bool remember = false;

    @override
    void initState() {
        super.initState();
    }

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

    void cleanErrors() {
        for (var i = 0; i < errors.length; i++) {
            removeError(error: errors[i]);
        };
    }

    @override
    Widget build(BuildContext context) {
        stSetKey("user_token", "");
        stSetKey("user_data", "");

        return Form(
                key: _formKey,
                child: Column(
                        children: [
                            buildEmailFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            buildPasswordFormField(),
                            SizedBox(height: getProportionateScreenHeight(30)),
                            Row(
                                    children: [
                                        Checkbox(
                                                value: remember,
                                                activeColor: kPrimaryColor,
                                                onChanged: (value) {
                                                    setState(() {
                                                        remember = value;
                                                    });
                                                },
                                        ),

                                        Text('Lembrar de mim'),
                                        Spacer(),
                                        GestureDetector(
                                                onTap: () =>
                                                Navigator.pushNamed(context, ForgotPasswordView.routeName),
                                                child: Text('Esqueci minha senha',
                                                        style: TextStyle(decoration: TextDecoration.underline)),
                                        ),
                                    ],
                                    ),
                                    FormError(errors: errors),
                                    SizedBox(height: getProportionateScreenHeight(20)),
                                    DefaultButton(
                                            text: 'Continue',
                                            press: () async {
                                                cleanErrors();
                                                if (_formKey.currentState.validate()) {
                                                    _formKey.currentState.save();

                                                    try {
                                                        var response = await api.post('/login', data: {
                                                            'email': email,
                                                            'pass': password,
                                                        });

                                                        var data = jsonDecode(response.data)["data"];
                                                        if (remember) {
                                                            stSetKey("user_token", data["token"]);
                                                            stSetKey("user_data", jsonEncode(data["user"]));
                                                        }
                                                        Navigator.pushReplacementNamed(context, '/home', arguments: [data["token"]]);
                                                    } on DioError catch (e) {
                                                        if (e.response != null) {
                                                            removeError(error: "Sem conexão");
                                                            try {
                                                                var data = jsonDecode(e.response.data);
                                                                addError(error: data["message"]);
                                                            } catch (e) {
                                                                addError(error: STATUS_MSG[e.response.statusCode]);
                                                            }
                                                        } else {
                                                            addError(error: "Sem conexão");
                                                        }
                                                    } catch (e) {
                                                        addError(error: "Sem conexão");
                                                    }
                                                }
                                            },
                                            ),
                                            ],
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
                    return null;
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
