import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_igreja/provider/users_provider.dart';
import 'package:projeto_igreja/routes/app_routes.dart';
import 'package:projeto_igreja/views/sign_In/sing_in_view.dart';
import 'package:provider/provider.dart';

import 'components/theme_data.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Aqui podem ser adicionados vários Providers;
    //têm-se o para controle de usuários e o para controle de eventos;
    return MultiProvider(
      providers: [
        //Provider de Usuários,
        ChangeNotifierProvider(
          create: (BuildContext context) => UsersProvider(),
        ),
      ],

      //MaterialApp
      child: MaterialApp(
        title: 'Projeto Igreja',
        theme: theme(),
        initialRoute: SignInView.routeName,
        routes: routes,
      ),
    );
  }
}

