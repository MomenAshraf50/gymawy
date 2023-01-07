import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/widgets/build_latest_client_activity.dart';
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
