import 'dart:io';

import 'package:chat_chit_flutter/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountForm extends StatefulWidget {
  const CreateAccountForm({
    super.key,
    required this.onSubmit,
    required this.onLoginPressed,
  });

  final void Function(
    String email,
    String username,
    String password,
    File? profileImage,
  ) onSubmit;
  final VoidCallback onLoginPressed;

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  File? _profileImage;

  Future<void> _selectProfileImage() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      setState(() => _profileImage = File(xFile.path));
    }
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(
        _emailController.text,
        _usernameController.text,
        _passwordController.text,
        _profileImage,
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
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
          ProfileImage(image: _profileImage, onTap: _selectProfileImage),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Email address is required' : null,
            decoration: const InputDecoration(label: Text('Email Address')),
          ),
          TextFormField(
            controller: _usernameController,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Username is required' : null,
            decoration: const InputDecoration(label: Text('Username')),
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUnfocus,
            validator: (value) =>
                (value == null || value.isEmpty) ? 'Password is required' : null,
            decoration: const InputDecoration(label: Text('Password')),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: widget.onLoginPressed,
            child: const Text('I already have an account'),
          ),
        ],
      ),
    );
  }
}
