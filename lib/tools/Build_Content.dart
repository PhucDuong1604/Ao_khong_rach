import 'package:flutter/material.dart';

class BuildContent extends StatefulWidget {
  final String title;
  final String content;
  BuildContent({super.key, required this.title, required this.content});

  @override
  State<BuildContent> createState() => _BuildContentState();
}

class _BuildContentState extends State<BuildContent> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 10),
        Text(
          widget.content,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }
}
