import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';

Widget textField({
  required controller,
  required String label
}) {
  return Column(
    children: [
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            fontFamily: 'english',
            fontSize: 14.rSp,
            color: Colors.grey
          ),
        ),
      ),
      verticalSpace(1.h),
    ],
  );
}
