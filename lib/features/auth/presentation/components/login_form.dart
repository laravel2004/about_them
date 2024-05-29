import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/auth/domain/entities/user_register.dart';
import 'package:them/features/auth/domain/repositories/auth_repository.dart';
import 'package:them/features/auth/domain/usecases/login.dart';
import 'package:them/features/auth/presentation/components/already_have_account.dart';
import 'package:them/features/auth/presentation/pages/register_page.dart';
import 'package:them/injection.container.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _showAlertDialog(String title, String message, {bool success = false}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                if (success) {
                  Navigator.pushReplacementNamed(context, '/dashboard');
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: _emailController,
            cursorColor: const Color(0xFFFFBA00),
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              controller: _passwordController,
              cursorColor: const Color(0xFFFFBA00),
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              final UserLogin user = UserLogin(email: _emailController.text, password: _passwordController.text);
              final login = await Login(sl.get<AuthRepository>()).call(params: user);
              if (login is DataSuccess) {
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.setString('token', login.data!);
                await _showAlertDialog('Success', 'Login successful!', success: true);
              } else {
                await _showAlertDialog('Error', login.error.toString());
              }
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
