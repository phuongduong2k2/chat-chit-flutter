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

  final Function(
    String email,
    String username,
    String password,
    File? profileImage,
  )
  onSubmit;
  final Function() onLoginPressed;

  @override
  State<CreateAccountForm> createState() => _CreateAccountFormState();
}

class _CreateAccountFormState extends State<CreateAccountForm> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final TextEditingController _emailController = TextEditingController(
    text: "",
  );
  final TextEditingController _usernameController = TextEditingController(
    text: "",
  );
  final TextEditingController _passwordController = TextEditingController(
    text: "",
  );

  void _selectProfileImage() async {
    final picker = ImagePicker();
    final xFile = await picker.pickImage(source: .gallery);
    if (xFile != null) {
      setState(() {
        _profileImage = File(xFile.path);
      });
    }
  }

  void _submit() {
    bool validate =
        _formKey.currentState != null && _formKey.currentState!.validate();
    if (validate) {
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
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 8,
        children: [
          ProfileImage(
            image: _profileImage,
            onTap: _selectProfileImage,
          ),
          TextFormField(
            controller: _emailController,
            autovalidateMode: .onUnfocus,
            validator: (value) =>
                value!.isEmpty ? "Email address is required" : null,
            decoration: InputDecoration(
              label: const Text("Email Address"),
            ),
          ),
          TextFormField(
            controller: _usernameController,
            autovalidateMode: .onUnfocus,
            validator: (value) =>
                value!.isEmpty ? "Username is required" : null,
            decoration: InputDecoration(
              label: const Text("Username"),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            autovalidateMode: .onUnfocus,
            validator: (value) =>
                value!.isEmpty ? "Password is required" : null,
            decoration: InputDecoration(
              label: const Text("Password"),
            ),
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: widget.onLoginPressed,
            child: const Text("I already have an account"),
          ),
        ],
      ),
    );
  }
}
