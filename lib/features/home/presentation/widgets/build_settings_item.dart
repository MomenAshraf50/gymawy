import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/domain/usecase/notifications_subscription_usecase.dart';
import 'package:gymawy/features/home/presentation/screens/settings/notifications_screen.dart';
import 'package:gymawy/features/home/presentation/screens/settings/support_screen.dart';

import '../../../../core/util/resources/colors_manager.dart';
import '../controller/home_cubit.dart';

Widget buildSettingsItem({required String text,required String iconPath,required BuildContext context}) {
  HomeCubit homeCubit = HomeCubit.get(context);
  return InkWell(
    onTap: () {
      if (text == 'Notifications') {
        navigateTo(context, const NotificationsScreen());
      } else if (text == 'Support') {
        navigateTo(context, const SupportScreen());
      } else if (text == 'Share') {
        homeCubit.share();
      } else {
        homeCubit.notificationsSubscription(NotificationsSubscriptionParams(
            deviceToken: deviceToken!,
            userLoggedIn: false
        ));
      }
    },
    child: Padding(
      padding: EdgeInsets.all(25.0.rSp),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          horizontalSpace(10.w),
          text == 'Log Out'
              ?  DefaultText(
            title: AppString.logOut ,
            style: Style.small,
            fontWeight: FontWeight.w400,
            color: Colors.red,
            fontSize: 20.rSp,
          )
              :  DefaultText(
            title: text ,
            style: Style.small,
            fontWeight: FontWeight.w400,
            fontSize: 20.rSp,
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: ColorsManager.mainColor,
          )
        ],
      ),
    ),
  );
}