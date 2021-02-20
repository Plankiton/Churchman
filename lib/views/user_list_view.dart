import 'package:flutter/material.dart';
import 'package:projeto_igreja/components/user_tile_component.dart';
import 'package:projeto_igreja/provider/users_provider.dart';
import 'package:provider/provider.dart';

class UserListView extends StatelessWidget {
  static String routeName = '/Users_List';
  @override
  Widget build(BuildContext context) {
    final UsersProvider usersProvider = Provider.of(context);

    return Scaffold(
      //AppBar com Título e Botão de Adicionar
      appBar: AppBar(
        title: Text('Lista de Usuários'),
        actions: <Widget>[
          //ícone de adicionar usuário
        ],
      ),

      //Body com a lista de usuários
      body: ListView.builder(
        itemCount: usersProvider.count,
        itemBuilder: (ctx, i) => UserTile(
          user: usersProvider.byIndex(i),
        ),
      ),
    );
  }
}
