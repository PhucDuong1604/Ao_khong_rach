import 'package:flutter/material.dart';

class BuildTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String labelText;
  const BuildTextField({
    super.key,
    required this.textEditingController,
    required this.labelText,
  });

  @override
  State<BuildTextField> createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: widget.textEditingController,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
              color: Color.fromARGB(255, 8, 5, 30),
              fontWeight: FontWeight.bold),
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
