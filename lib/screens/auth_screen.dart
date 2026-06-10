import 'dart:io';

import 'package:chat_chit_flutter/extensions/exception_extension.dart';
import 'package:chat_chit_flutter/providers/user_notifier.dart';
import 'package:chat_chit_flutter/screens/chat_screen.dart';
import 'package:chat_chit_flutter/services/auth_service.dart';
import 'package:chat_chit_flutter/utils/utils.dart';
import 'package:chat_chit_flutter/widgets/auth_form.dart';
import 'package:chat_chit_flutter/widgets/create_account_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _authService = AuthService();
  bool _isLoginForm = true;
  bool _isLoading = false;

  void _toggleForm() {
    setState(() => _isLoginForm = !_isLoginForm);
  }

  Future<void> _login(String email, String password) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      final user = await _authService.login(email: email, password: password);
      if (!mounted) return;
      ref.read(userProvider.notifier).setUser(user);
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const ChatScreen()),
      );
    } on Exception catch (error) {
      if (!mounted) return;
      showSnackBar(context, error.cleanMessage, SnackBarType.error);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _createAccount(
    String email,
    String username,
    String password,
    File? image,
  ) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      final message = await _authService.register(
        email: email,
        username: username,
        password: password,
        image: image,
      );
      if (!mounted) return;
      showSnackBar(context, message, SnackBarType.success);
      _toggleForm();
    } on Exception catch (error) {
      if (!mounted) return;
      showSnackBar(context, error.cleanMessage, SnackBarType.error);
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
              const Icon(Icons.chat_bubble, color: Colors.white, size: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: _isLoading
                      ? const SizedBox(
                          height: 80,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : _isLoginForm
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
