import 'package:flutter/material.dart';
import 'package:projeto_igreja/models/user.dart';
import 'package:projeto_igreja/provider/users_provider.dart';
import 'package:provider/provider.dart';

class UserFormView extends StatefulWidget {
  static String routeName = '/user-form';
  @override
  _UserFormViewState createState() => _UserFormViewState();
}

class _UserFormViewState extends State<UserFormView> {
  final _form = GlobalKey<FormState>();

  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final User user = ModalRoute.of(context).settings.arguments;
    _loadFormData(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Usuário'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState.validate();
              if (isValid) {
                _form.currentState.save();
                Provider.of<UsersProvider>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    name: _formData['name'],
                    email: _formData['email'],
                    avatarUrl: _formData['avatarUrl'],
                  ),
                );
                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
              initialValue: _formData['name'],
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Item Nome em branco';
                }

                if (value.trim().length < 3) {
                  return 'Nome muito pequeno. No mínimo 3 letras';
                }
                return null;
              },
              onSaved: (value) => _formData['name'] = value,
            ),
            TextFormField(
              initialValue: _formData['email'],
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Item Email em branco';
                }

                if (value.trim().length < 3) {
                  return 'Email invalido';
                }
                return null;
              },
              onSaved: (value) => _formData['email'] = value,
            ),
            TextFormField(
              initialValue: _formData['avatarUrl'],
              decoration: InputDecoration(labelText: 'URL do Avatar'),
              onSaved: (value) => _formData['avatarUrl'] = value,
            )
          ]),
        ),
      ),
    );
  }
}
