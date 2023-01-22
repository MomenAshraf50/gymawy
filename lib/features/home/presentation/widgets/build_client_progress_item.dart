import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

Widget buildClientProgressItem(
{
  required bool isProgress,
  required ImageProvider image,
  required String name,
}
    ){
  return Card(
    elevation: 5,
    child: Padding(
      padding:  EdgeInsets.all(15.rSp),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25.rSp,
            backgroundImage:
              image,
            //const NetworkImage(AppString.networkImage),
          ),
          horizontalSpace(3.w),
          myText(
            title: name,
            //AppString.userNameProfile,
            style: Style.small,
            fontSize: 16.rSp,
          ),
          const Spacer(),
          isProgress? SizedBox(
            width: 13.w,
            height: 6.h,
            child: LiquidCircularProgressIndicator(
              value: 0.5,
              // Defaults to 0.5.
              valueColor:
              const AlwaysStoppedAnimation(ColorsManager.mainColor),
              // Defaults to the current Theme's accentColor.
              backgroundColor: Colors.white,
              // Defaults to the current Theme's backgroundColor.
              borderColor: ColorsManager.mainColor,
              borderWidth: 5.0,
              direction: Axis.vertical,
              // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
              center: myText(
                title: AppString.progressAmount,
                style: Style.extraSmall,
                fontSize: 12.rSp,
              ),
            ),
          ) :
          const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Color.fromARGB(255, 208, 208, 208),
          )

        ],
      ),
    ),
  );

}