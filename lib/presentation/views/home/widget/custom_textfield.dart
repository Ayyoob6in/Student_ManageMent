import 'package:flutter/material.dart';

class CustomTextFielsWidget extends StatelessWidget {
  final String hint;
  final IconData fieldIcon;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final double size;
  final double radius;
  final bool readOnly;
  final ValueChanged<String>? onchange;  
  final List<BoxShadow>?shadow;

   // ignore: use_key_in_widget_constructors
   const CustomTextFielsWidget({
    Key? key,
    required this.hint,
    required this.fieldIcon,
    required this.controller,
    this.validator,
    this.size = 60,
    this.radius = 8.0,
    this.readOnly = false,
    this.onchange, 
    this.shadow 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(radius),
        boxShadow: shadow,
      ),
      child: Center(
        child: TextFormField(
          onChanged: onchange, 
          readOnly: readOnly,
          controller: controller,
          validator: validator,
          style: const TextStyle(fontSize: 16.0, color: Colors.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
            icon: Icon(fieldIcon, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
