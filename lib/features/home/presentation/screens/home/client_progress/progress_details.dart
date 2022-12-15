import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/widgets/build_latest_client_activity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../widgets/build_day_progress.dart';

class ProgressDetailsScreen extends StatelessWidget {
  const ProgressDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                defaultAppBar(title: AppString.clientProgress, context: context),
                verticalSpace(2.h),
                CircleAvatar(
                  radius: 50.rSp,
                  backgroundImage: const NetworkImage(AppString.networkImage),
                ),
                verticalSpace(1.h),
                myText(
                  title: AppString.userNameProfile,
                  style: Style.medium,
                  fontSize: 20.rSp,
                ),
                verticalSpace(3.h),
                Card(
                  elevation: 5,
                  child: SizedBox(
                    height: 18.h,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildDayProgressItems();
                        },
                         itemCount: 7,

                    ),
                  ),
                ),
                verticalSpace(3.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: myText(
                    title: AppString.userNameProfile,
                    style: Style.medium,
                    fontSize: 20.rSp,
                  ),
                ),
                verticalSpace(3.h),
                ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildLatestActivityItem(
                          index: '$index',
                          img: Assets.images.svg.icon_notification,
                          notificationTitle: AppString.benchPress,
                          notificationTime: AppString.notificationTime
                      );
                    },
                     itemCount: 10,
                ),


                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Expanded(
                //       child: Column(
                //         children: [
                //           Container(
                //             height: 10.h,
                //             width: 6.w,
                //             decoration: BoxDecoration(
                //               gradient: const LinearGradient(
                //                  end: Alignment.bottomCenter,
                //                   begin: Alignment.topCenter,
                //                   colors:
                //                   [
                //                   Color.fromARGB(255, 255, 185, 145)  ,
                //                   ColorsManager.mainColor
                //                   ]
                //               ),
                //               borderRadius: BorderRadius.circular(10.rSp),
                //             ),
                //           ),
                //           const myText(title: 'Sat', style: Style.extraSmall)
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Column(
                //         children: [
                //           Container(
                //             height: 10.h,
                //             width: 6.w,
                //             decoration: BoxDecoration(
                //               color: ColorsManager.mainColor,
                //               borderRadius: BorderRadius.circular(10.rSp),
                //             ),
                //           ),
                //           const myText(title: 'Sat', style: Style.extraSmall)
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Column(
                //         children: [
                //           Container(
                //             height: 10.h,
                //             width: 6.w,
                //             decoration: BoxDecoration(
                //               color: ColorsManager.mainColor,
                //               borderRadius: BorderRadius.circular(10.rSp),
                //             ),
                //           ),
                //           const myText(title: 'Sat', style: Style.extraSmall)
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Column(
                //         children: [
                //           Container(
                //             height: 10.h,
                //             width: 6.w,
                //             decoration: BoxDecoration(
                //               color: ColorsManager.mainColor,
                //               borderRadius: BorderRadius.circular(10.rSp),
                //             ),
                //           ),
                //           const myText(title: 'Sat', style: Style.extraSmall)
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Column(
                //         children: [
                //           Container(
                //             height: 10.h,
                //             width: 6.w,
                //             decoration: BoxDecoration(
                //               color: ColorsManager.mainColor,
                //               borderRadius: BorderRadius.circular(10.rSp),
                //             ),
                //           ),
                //           const myText(title: 'Sat', style: Style.extraSmall)
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Column(
                //         children: [
                //           Container(
                //             height: 10.h,
                //             width: 6.w,
                //             decoration: BoxDecoration(
                //               color: ColorsManager.mainColor,
                //               borderRadius: BorderRadius.circular(10.rSp),
                //             ),
                //           ),
                //           const myText(title: 'Sat', style: Style.extraSmall)
                //         ],
                //       ),
                //     ),
                //     Expanded(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Container(
                //             height: 7.h,
                //             width: 6.w,
                //             decoration: BoxDecoration(
                //               color: ColorsManager.mainColor,
                //               borderRadius: BorderRadius.circular(10.rSp),
                //             ),
                //           ),
                //           const myText(title: 'Sat', style: Style.extraSmall)
                //         ],
                //       ),
                //     ),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
