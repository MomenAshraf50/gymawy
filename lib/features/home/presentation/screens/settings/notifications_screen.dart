import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/widgets/build_notifications_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.rSp),
          child: Column(
            children: [
              Row(
                children: [
                  DefaultBackButton(function: () {
                    Navigator.pop(context);
                  }),
                   horizontalSpace(3.w),
                   myText(
                    title: AppString.notifications,
                    style: Style.headMedium,
                    fontSize: 24.rSp,
                  ),
                ],
              ),
              verticalSpace(5.h),
              Expanded(
                child: ListView.builder(itemBuilder: (context,index) => buildNotificationsItem(
                  index: '$index',
                  img: Assets.images.svg.icon_notification,
                  notificationTitle: AppString.notificationTitle,
                  notificationTime: AppString.notificationTime
                ),
                  itemCount: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
