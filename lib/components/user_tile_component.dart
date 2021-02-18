import 'package:flutter/material.dart';
import 'package:projeto_igreja/models/user.dart';
import 'package:projeto_igreja/provider/users_provider.dart';
import 'package:projeto_igreja/views/sign_In/user_form_view.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  final User user;

  const UserTile({this.user});

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Colors.orange,
              onPressed: () {
                Navigator.of(context).pushNamed(
                  UserFormView.routeName,
                  arguments: user,
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text('Excluir Usuário'),
                          content: Text('Tem Certeza?'),
                          actions: [
                            FlatButton(
                              child: Text('Não'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('Sim'),
                              onPressed: () {
                                Provider.of<UsersProvider>(context,
                                        listen: false)
                                    .remove(user);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
              },
            )
          ],
        ),
      ),
    );
  }
}
