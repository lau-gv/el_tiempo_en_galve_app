import 'package:flutter/material.dart';

class CustomInputText extends StatelessWidget {

  final String textLabel;
  final String? errorMessage;
  final String? initialValue;
  final Function(String)? onChanged;
  TextInputType? keyboardType;
  final bool? isOnlyRead;

  
  CustomInputText({
    super.key, 
    required this.textLabel, 
    this.errorMessage, 
    this.onChanged, 
    this.keyboardType,
    this.initialValue,
    this.isOnlyRead,
  });


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 75,
      child: TextFormField(
        keyboardType: keyboardType,
        initialValue: initialValue,
        readOnly: isOnlyRead ?? false,
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

