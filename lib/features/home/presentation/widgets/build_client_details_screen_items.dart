import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/constants_manager.dart';
import '../../../../core/util/widgets/myText.dart';

Widget buildClientDetailsScreenItems(
{
  required String icons,
  required String title,
  required String titleResult,

})
{
  return Card(
    color: const Color.fromARGB(255, 252, 251, 251),
    elevation: 5,
    margin: EdgeInsets.all(10.rSp),
    child: Padding(
      padding: EdgeInsets.all(15.rSp),
      child: Row(
        children: [
          SvgPicture.asset(
          icons,
          //Assets.images.svg.completed_tasks
          ),
          horizontalSpace(5.w),
          myText(
            title: title,
            //AppString.completed,
            style: Style.medium,
            fontSize: 14.rSp,
            fontWeight: FontWeight.w600,
          ),
          const Spacer(),
          myText(
            fontSize: 14.rSp,
            title: titleResult,
            style: Style.medium,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    ),
  );
}