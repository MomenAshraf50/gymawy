import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

Widget buildClientProgressItem(
{
  required bool isProgress,
  required ImageProvider image,
  required String name,
  bool? isPending,
  Function()? onPressedAccept,
  Function()? onPressedDecline,
}
    ){
  return Card(
    elevation: 5,
    child: Padding(
      padding:  EdgeInsets.all(15.rSp),
      child: Column(
        children: [
          Row(
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
          if(isPending == true)
          verticalSpace(2.h),
          if(isPending == true)
          Row(
            children: [
              Expanded(
                child: myButton(
                  text: 'Decline',
                  onPressed: onPressedDecline,
                  color: ColorsManager.error,
                  height: 2.h,
                  fontSize: 14.rSp,
                ),
              ),
              horizontalSpace(5.w),
              Expanded(
                child: myButton(
                    text: 'Accept',
                    onPressed: onPressedAccept,
                    color: ColorsManager.green,
                    height: 2.h,
                    fontSize: 14.rSp,
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );

}