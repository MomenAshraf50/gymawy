import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressDetailsScreen extends StatelessWidget {
  const ProgressDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: Column(
            children: [
              Row(
                children: [
                  DefaultBackButton(
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                  horizontalSpace(4.w),
                  myText(
                    title: AppString.clientsProgress,
                    style: Style.headMedium,
                    fontSize: 18.rSp,
                  )
                ],
              ),
              verticalSpace(4.h),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.mainColor,
                            borderRadius: BorderRadius.circular(10.rSp),
                          ),
                        ),
                        const myText(title: 'Sat', style: Style.extraSmall)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.mainColor,
                            borderRadius: BorderRadius.circular(10.rSp),
                          ),
                        ),
                        const myText(title: 'Sat', style: Style.extraSmall)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.mainColor,
                            borderRadius: BorderRadius.circular(10.rSp),
                          ),
                        ),
                        const myText(title: 'Sat', style: Style.extraSmall)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.mainColor,
                            borderRadius: BorderRadius.circular(10.rSp),
                          ),
                        ),
                        const myText(title: 'Sat', style: Style.extraSmall)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.mainColor,
                            borderRadius: BorderRadius.circular(10.rSp),
                          ),
                        ),
                        const myText(title: 'Sat', style: Style.extraSmall)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          height: 10.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.mainColor,
                            borderRadius: BorderRadius.circular(10.rSp),
                          ),
                        ),
                        const myText(title: 'Sat', style: Style.extraSmall)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 7.h,
                          width: 6.w,
                          decoration: BoxDecoration(
                            color: ColorsManager.mainColor,
                            borderRadius: BorderRadius.circular(10.rSp),
                          ),
                        ),
                        const myText(title: 'Sat', style: Style.extraSmall)
                      ],
                    ),
                  ),
                ],
              )
            ],
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
