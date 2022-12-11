import 'package:flutter/material.dart';

RichText buildRichText(String title,context) {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: title,
          style: Theme.of(context).textTheme.displayMedium,
          // recognizer: TapGestureRecognizer()..onTap = () {
          //   // Single tapped.
          // },
        ),
        // TextSpan(
        //     text: title,
        //     style: Theme.of(context).textTheme.displayMedium!.copyWith(
        //       fontWeight: FontWeight.bold,
        //     ),
        //     // recognizer:  DoubleTapGestureRecognizer()..onDoubleTap = () {
        //     //   // Double tapped.
        //     // }
        // ),
        // TextSpan(
        //   text: ' Long press',
        //   style: TextStyle(color: Colors.blue[300]),
        //   // recognizer: LongPressGestureRecognizer()..onLongPress = () {
        //   //   // Long Pressed.
        //   // },
        // ),
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