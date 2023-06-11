import 'package:flutter/material.dart';

class CustomDropdownButtonFormField<T> extends StatelessWidget {

  final String? textLabel;
  final Function(T)? onChanged;
  final List<DropdownMenuItem<T>> items;
  final T selectedValue;

  
  const CustomDropdownButtonFormField({
    super.key, 
    this.textLabel, 
    required this.onChanged, 
    required this.items,
    required this.selectedValue,
  });


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 75,
      child: DropdownButtonFormField(
                decoration: InputDecoration(
                  label: Text(textLabel ?? ""),
                ),
                items: items,
                value: selectedValue,
                onChanged: (value) {   
                  if (value !=null)  onChanged!(value);               
                },),
    );
  }
}

