// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:them/core/resource/data_state.dart';
import 'package:them/features/auth/domain/entities/user_register.dart';
import 'package:them/features/auth/domain/repositories/auth_repository.dart';
import 'package:them/features/auth/domain/usecases/register.dart';
import 'package:them/features/auth/presentation/components/already_have_account.dart';
import 'package:them/features/auth/presentation/pages/login_page.dart';
import 'package:them/injection.container.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  String? _selectedRole;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _selectedRole = "guru"; // default role
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _showAlertDialog(String title, String message) async {
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
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: _nameController,
            cursorColor: const Color(0xFFFFBA00),
            onSaved: (name) {},
            decoration: const InputDecoration(
              hintText: "Your name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.person),
              ),
            ),
          ),
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
                child: Icon(Icons.email),
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
          DropdownButtonFormField<String>(
            value: _selectedRole,
            items: const [
              DropdownMenuItem(value: "guru", child: Text("Guru")),
              DropdownMenuItem(value: "ortu", child: Text("Ortu")),
            ],
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
            decoration: const InputDecoration(
              hintText: "Select Role",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(Icons.person_outline),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState?.validate() ?? false) {
                final newUser = UserRegister(
                  email: _emailController.text,
                  name: _nameController.text,
                  password: _passwordController.text,
                  role: _selectedRole ?? "guru",
                );
                final result = await Register(sl.get<AuthRepository>()).call(params: newUser);
                if (result is DataSuccess) {
                  await _showAlertDialog('Success', 'Registration successful!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const LoginScreen();
                      },
                    ),
                  );
                } else {
                  await _showAlertDialog('Error', "Register Anda Gagal");
                }
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: 16.0),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
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
