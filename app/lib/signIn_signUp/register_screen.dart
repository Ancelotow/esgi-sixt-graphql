import 'package:app/models/users.dart';
import 'package:app/users_bloc/users_bloc.dart';
import 'package:dbcrypt/dbcrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = '/RegisterScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Inscription',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Color(0xFFf9ffff),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Mon email",
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Mon mot de passe",
              ),
            ),
            const Spacer(),
            BlocConsumer<UsersBloc, UsersState>(
              listener: (context, state) {
                if (state.status == UsersStatus.editSuccess) {
                  _showSnackBar(
                      context, 'Inscription réussi', Colors.greenAccent);
                  Navigator.of(context).pop();
                } else if (state.status == UsersStatus.error) {
                  _showSnackBar(context, state.error, Colors.orangeAccent);
                }
              },
              builder: (context, state) {
                switch (state.status) {
                  case UsersStatus.loading:
                    return const CircularProgressIndicator();
                  default:
                    return Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () => _onAddUser(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'S`inscrire sur SixtGi',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String text, Color background) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: background,
      ),
    );
  }

  void _onAddUser(BuildContext context) {
    var bloc = BlocProvider.of<UsersBloc>(context);
    if (_emailController.text != "" && _passwordController.text != "") {
      final hashedPassword =
          DBCrypt().hashpw(_passwordController.text, DBCrypt().gensalt());
      final user = User(
        id: '',
        email: _emailController.text,
        password: hashedPassword,
      );
      bloc.add(AddUser(user: user));
    } else {
      _showSnackBar(
          context, "Vous devez remplir tous les champs", Colors.redAccent);
    }
  }
}
