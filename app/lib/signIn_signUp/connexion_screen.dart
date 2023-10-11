import 'package:app/screen/home/vehicle_screen_copy.dart';
import 'package:app/models/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../users_bloc/users_bloc.dart';

class ConnexionScreen extends StatelessWidget {
  static const String routeName = '/ConnexionScreen';

  static void navigateTo(BuildContext context) {
    Navigator.of(context).pushNamed(routeName);
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ConnexionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connexion',
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
                labelText: "Email",
              ),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Mot de passe",
              ),
            ),
            const Spacer(),
            BlocConsumer<UsersBloc, UsersState>(listener: (context, state) {
              if (state.status == UsersStatus.success) {
                _showSnackBar(
                    context, 'Vous êtes bien connecté', Colors.greenAccent);
                _navigateToRentScreen(context);
              } else if (state.status == UsersStatus.error) {
                _showSnackBar(context, state.error, Colors.orangeAccent);
              }
            }, builder: (context, state) {
              switch (state.status) {
                case UsersStatus.loading:
                  return const CircularProgressIndicator();
                default:
                  return Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      onPressed: () => _onLogin(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Se connecter',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  );
              }
            })
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

  void _onLogin(BuildContext context) {
    var bloc = BlocProvider.of<UsersBloc>(context);
    if (_emailController.text != "" && _passwordController.text != "") {
      final user = User(
        id: '',
        email: _emailController.text,
        password: _passwordController.text,
      );
      bloc.add(LoginUser(user: user));
    } else {
      _showSnackBar(context, "Vous devez saisir votre pseudo et mot de passe",
          Colors.redAccent);
    }
  }

  void _navigateToRentScreen(BuildContext context) async {
    VehicleScreen.navigateTo(context);
  }
}
