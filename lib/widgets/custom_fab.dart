import 'package:flutter/material.dart';

class CustomFAB extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Icon icon;

  const CustomFAB(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(11, 0, 0, 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: onPressed,
            child: icon,
          ),
        ],
      ),
    );
  }
}
