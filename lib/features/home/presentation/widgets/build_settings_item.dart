import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

import '../../../../core/util/resources/colors_manager.dart';

Widget buildSettingsItem(String text, String iconPath, BuildContext context) {
  return InkWell(
    onTap: () {
      if (text == 'Notifications') {
      } else if (text == 'Location') {
      } else if (text == 'Support') {
      } else if (text == 'Share') {
      } else {}
    },
    child: Padding(
      padding: EdgeInsets.all(25.0.rSp),
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          horizontalSpace(10.w),
          text == 'Log Out'
              ?  myText(
            title: AppString.logOut ,
            style: Style.small,
            fontWeight: FontWeight.w400,
            color: Colors.red,
            fontSize: 20.rSp,
          )
              :  myText(
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