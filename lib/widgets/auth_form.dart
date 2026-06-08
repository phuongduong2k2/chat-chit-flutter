import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
    required this.onSubmit,
    required this.onCreatePressed,
  });

  final Function(String email, String password) onSubmit;

  final Function() onCreatePressed;

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(
    text: "",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "",
  );

  void _login() async {
    bool validate =
        _formKey.currentState != null && _formKey.currentState!.validate();
    if (validate) {
      widget.onSubmit(_emailController.text, _passwordController.text);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
            validator: (value) =>
                value!.isEmpty ? "Email Address is required" : null,
            decoration: InputDecoration(
              label: const Text("Email Address"),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            validator: (value) =>
                value!.isEmpty ? "Password is required" : null,
            decoration: InputDecoration(
              label: const Text("Password"),
            ),
          ),
          ElevatedButton(
            onPressed: _login,
            child: const Text("Login"),
          ),
          TextButton(
            onPressed: widget.onCreatePressed,
            child: const Text("Create an account"),
          ),
        ],
      ),
    );
  }
}
