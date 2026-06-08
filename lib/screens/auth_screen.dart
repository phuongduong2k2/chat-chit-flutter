import 'dart:io';

import 'package:chat_chit_flutter/extensions/exception_extension.dart';
import 'package:chat_chit_flutter/services/auth_service.dart';
import 'package:chat_chit_flutter/utils/utils.dart';
import 'package:chat_chit_flutter/widgets/auth_form.dart';
import 'package:chat_chit_flutter/widgets/create_account_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService authService = AuthService();
  bool _isLoginForm = true;

  void _toggleForm() {
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  void _login(String email, String password) async {
    try {
      final result = await authService.login(email: email, password: password);
      if (!mounted) return;
      showSnackBar(context, "Welcome ${result.username}", .success);
    } on Exception catch (error) {
      if (!mounted) return;
      showSnackBar(context, error.cleanMessage, .error);
    }
  }

  void _createAccount(
    String email,
    String username,
    String password,
    File? image,
  ) async {
    try {
      final result = await authService.register(
        email: email,
        username: username,
        password: password,
      );
      if (!mounted) return;
      showSnackBar(context, result, .success);
      _toggleForm();
    } on Exception catch (error) {
      if (!mounted) return;
      showSnackBar(context, error.cleanMessage, .error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Icon(
                Icons.chat_bubble,
                color: Colors.white,
                size: 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(16),
                  child: _isLoginForm
                      ? AuthForm(
                          onCreatePressed: _toggleForm,
                          onSubmit: _login,
                        )
                      : CreateAccountForm(
                          onLoginPressed: _toggleForm,
                          onSubmit: _createAccount,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
