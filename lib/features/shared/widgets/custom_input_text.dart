import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {

  final String textLabel;
  final String? errorMessage;
  final Function(String)? onChanged;
  TextInputType? keyboardType;

  
  CustomInputText({
    super.key, 
    required this.textLabel, 
    this.errorMessage, 
    this.onChanged, 
    this.keyboardType
  });


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 75,
      child: TextFormField(
        keyboardType: keyboardType,
        //No es buena práctica poner watch en eventos
        onChanged: onChanged,
        decoration:
            InputDecoration(
              labelText: textLabel,
              errorText: errorMessage,
            ),                        
      ),
    );
  }
}

