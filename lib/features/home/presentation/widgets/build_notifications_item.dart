import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/domain/usecase/mark_as_read_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';

Widget buildNotificationsItem({
  required String notificationTitle,
  required String notificationTime,
  required String index,
  required bool read,
  required context,
  required int notificationId,
}) {
  String time = notificationTime.substring(11, 16);
  String date = notificationTime.substring(0, 10);
  HomeCubit homeCubit = HomeCubit.get(context);
  return Padding(
    padding: EdgeInsets.all(5.rSp),
    child: Card(
      color: read? ColorsManager.white:ColorsManager.lightGrey,
      elevation: 5.rSp,
      child: Padding(
        padding: EdgeInsets.all(10.rSp),
        child: Row(
          children: [
            SvgPicture.asset(Assets.images.svg.notifications),
            horizontalSpace(4.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myText(
                    title: notificationTitle,
                    style: Style.extraSmall,
                    fontSize: 14.rSp,
                    maxLines: 2,
                    fontWeight: read? FontWeight.normal:FontWeight.bold,
                  ),
                  verticalSpace(0.5.h),
                  Row(
                    children: [
                      myText(
                        title: date,
                        style: Style.extraSmall,
                        fontSize: 12.rSp,
                      ),
                      horizontalSpace(0.5.w),
                      myText(
                        title: time,
                        style: Style.extraSmall,
                        fontSize: 12.rSp,
                      ),
                      const Spacer(),
                      if (!read)
                        OutlinedButton(
                          child: const myText(
                            title: AppString.markAsRead,
                            style: Style.extraSmall,
                            color: ColorsManager.green,
                          ),
                          onPressed: () {
                            homeCubit.markAsRead(MarkAsReadParams(notificationId: notificationId));
                          },
                        )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
