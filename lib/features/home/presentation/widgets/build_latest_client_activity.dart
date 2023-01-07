import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

Widget buildLatestActivityItem(
    {required String img,
      required String notificationTitle,
      required String notificationTime,
      required String index,
    }) {
  return Card(
    elevation: 5.rSp,
    margin: EdgeInsets.all(10.rSp),
    child: Dismissible(
      onDismissed: (DismissDirection direction){},
      key: Key(index),
      direction: DismissDirection.horizontal,
      child: Padding(
        padding:  EdgeInsets.all(10.rSp),
        child: Row(
          children: [
            SvgPicture.asset(Assets.images.svg.icon_notification),
            horizontalSpace(4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myText(title: notificationTitle, style: Style.extraSmall,maxLines: 1,),
                  verticalSpace(0.5.h),
                  myText(title:notificationTime, style: Style.extraSmall,fontSize: 8.rSp,)
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
