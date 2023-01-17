import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/widgets/exercise_details.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/myText.dart';

Widget buildPlansTypeItems() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.h),
    child: Card(
      color: const Color.fromARGB(255, 247, 248, 248),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 10,
      child: Padding(
        padding: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
        child: Column(
          children: [
            // exerciseDetails(onPressed: (){}),
            verticalSpace(2.h),
          ],
        ),
      ),
    ),
  );
}