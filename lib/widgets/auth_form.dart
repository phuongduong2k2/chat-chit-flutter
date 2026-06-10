import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.onSubmit,
    required this.onCreatePressed,
  });

  final void Function(String email, String password) onSubmit;
  final VoidCallback onCreatePressed;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(_emailController.text, _passwordController.text);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 8,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Email address is required' : null,
            decoration: const InputDecoration(label: Text('Email Address')),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Password is required' : null,
            decoration: const InputDecoration(label: Text('Password')),
          ),
          ElevatedButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: widget.onCreatePressed,
            child: const Text('Create an account'),
          ),
        ],
      ),
    );
  }
}
