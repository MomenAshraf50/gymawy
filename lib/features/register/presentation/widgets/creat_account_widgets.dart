import 'package:flutter/material.dart';

RichText buildRichText(String title,context) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: title,
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ],
    ),
  );
}
Widget validationRow({required bool condition, required String message}) => Padding(
  padding: const EdgeInsets.all(10.0),
  child: Row(
    children: [
      Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: condition ? Colors.green[300] : Colors.red[300],
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            condition ? Icons.check : Icons.clear,
            color: Colors.white,
            size: 15,
          ),
        ),
      ),
      const SizedBox(width: 10,),
      Text(message)
    ],
  ),
);