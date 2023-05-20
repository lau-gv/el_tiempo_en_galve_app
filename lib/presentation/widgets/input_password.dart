import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  final String textLabel;
  const InputPassword({required this.textLabel});
  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<InputPassword> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: widget.textLabel,
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
    );
  }
}