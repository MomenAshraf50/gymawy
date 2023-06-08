import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
// import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

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
              DefaultText(
                title: name,
                //AppString.userNameProfile,
                style: Style.small,
                fontSize: 16.rSp,
              ),
              const Spacer(),
              isProgress? SizedBox(
                width: 13.w,
                height: 6.h,
                child: CircularStepProgressIndicator (
                  totalSteps: 100,
                  currentStep: 50,
                  selectedColor: ColorsManager.mainColor,
                  arcSize: 5.rSp,
                  child: Center(
                    child: DefaultText(
                      title: AppString.progressAmount,
                      style: Style.extraSmall,
                      fontSize: 12.rSp,
                    ),
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
                child: DefaultButton(
                  text: 'Reject',
                  onPressed: onPressedDecline,
                  color: ColorsManager.error,
                  height: 2.h,
                  fontSize: 14.rSp,
                ),
              ),
              horizontalSpace(5.w),
              Expanded(
                child: DefaultButton(
                    text: 'Approve',
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