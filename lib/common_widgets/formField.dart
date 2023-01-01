import 'package:flutter/material.dart';

class getTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintname;
  IconData icon;
  bool isObscureText;
   final FormFieldValidator<String>? validator;
  TextInputType inputType;

  String? validate(String value) {
    if (value.isEmpty) {
      return 'Please enter a value';
    }
    return null;
  }

  getTextFormField({
    required this.controller,
    required this.hintname,
    required this.icon,
    this.isObscureText = false,
    this.validator,
    this.inputType = TextInputType.text,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscureText,
        keyboardType: inputType,
        validator: validator,    
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.blue),
          ),
          prefixIcon: Icon(icon),
          hintText: hintname,
          fillColor: Colors.grey[200],
          filled: true,
        ),
      ),
    );
  }
}
