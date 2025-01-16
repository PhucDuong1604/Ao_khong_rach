import 'package:flutter/material.dart';

class BuildTextFieldPassword extends StatefulWidget {
  final TextEditingController textEditingController;
  final String labelText;
  const BuildTextFieldPassword({
    super.key,
    required this.textEditingController,
    required this.labelText,
  });

  @override
  State<BuildTextFieldPassword> createState() => _BuildTextFieldPasswordState();
}

class _BuildTextFieldPasswordState extends State<BuildTextFieldPassword> {
  bool isLoading = true;

  bool checkIsLoading() {
    isLoading = !isLoading;
    return isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          obscureText: isLoading,
          controller: widget.textEditingController,
          decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black),
              filled: true,
              fillColor: Colors.white,
              border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      checkIsLoading();
                    });
                  },
                  icon: Icon(
                      isLoading ? Icons.visibility : Icons.visibility_off))),
        ));
  }
}
