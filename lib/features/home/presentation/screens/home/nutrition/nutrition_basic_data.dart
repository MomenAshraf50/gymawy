import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

class NutritionBasicData extends StatelessWidget {
  NutritionBasicData({
    Key? key,
    this.nutritionName,
    this.component,
    this.howToPrepare,
    this.nutritionId,
    this.fat,
    this.userId,
    this.userName,
    this.visibility,
    this.calories,
    this.carb,
    this.category,
    this.pic,
    this.protein
  }) : super(key: key);
  String? fat;
  String? carb;
  String? protein;
  String? calories;
  String? visibility;
  String? howToPrepare;
  Map? component;
  String? pic;
  String? category;
  String? nutritionName;
  int? nutritionId;
  int? userId;
  String? userName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  end: AlignmentDirectional.bottomEnd,
                  begin: AlignmentDirectional.topStart,
                  colors: [
                    Color.fromARGB(255, 255, 192, 147),
                    ColorsManager.mainColor,
                    ColorsManager.mainColor,
                  ],
                )),
                child: Column(
                  children: [
                    defaultAppBar(
                        title: nutritionName!,
                        context: context,
                        actions: [
                          Padding(
                            padding: EdgeInsets.only(right: 3.w),
                            child: defaultActionButton(
                                onPressed: ()
                                {

                                },
                                icon: Icons.edit,
                                backgroundColor: Colors.transparent,
                                iconColor: ColorsManager.darkGrey
                            ),
                          ),
                        ]
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20.rSp, 70.rSp, 20.rSp, 20.rSp),
                        child: Center(child: Image.network(pic!)),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorsManager.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.rSp),
                            topRight: Radius.circular(40.rSp),
                          ),
                        ),
                        child: Padding(
                          padding: designApp,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                verticalSpace(2.h),
                                myText(
                                  title: category!,
                                  style: Style.small,
                                  fontWeight: FontWeight.w600,
                                ),
                                verticalSpace(0.5.h),
                                myText(
                                  title: 'by $userName',
                                  style: Style.extraSmall,
                                ),
                                verticalSpace(2.h),
                                const myText(
                                  title: 'Nutrition',
                                  style: Style.small,
                                  fontWeight: FontWeight.w600,
                                ),
                                verticalSpace(3.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(Assets.images.svg.calories),
                                          horizontalSpace(0.5.w),
                                          myText(
                                            title: '$calories k Cal',
                                            style: Style.extraSmall,
                                            fontSize: 10.rSp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(Assets.images.svg.fat),
                                          horizontalSpace(0.5.w),
                                          myText(
                                            title: '$fat g fats',
                                            style: Style.extraSmall,
                                            fontSize: 10.rSp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(Assets.images.svg.protein),
                                          horizontalSpace(0.5.w),
                                          myText(
                                            title: '$protein g proteins',
                                            style: Style.extraSmall,
                                            fontSize: 10.rSp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child:
                                        Row(
                                          children: [
                                            SvgPicture.asset(Assets.images.svg.rice),
                                            horizontalSpace(0.5.w),
                                            myText(
                                              title: '$carb g carb',
                                              style: Style.extraSmall,
                                              fontSize: 10.rSp,
                                            ),
                                          ],
                                        )
                                    ),
                                  ],
                                ),
                                verticalSpace(3.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Expanded(
                                      child: myText(
                                        title: 'Components',
                                        style: Style.medium,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    horizontalSpace(2.w),
                                    const Expanded(
                                      child: myText(
                                        title: 'Item',
                                        style: Style.medium,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const Expanded(
                                      child: myText(
                                        title: 'Quantity',
                                        style: Style.medium,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),


                                  ],
                                ),
                                ExpansionTile(
                                  title: const myText(
                                    title: '',
                                    style: Style.small,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(vertical: 1.h),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: myText(
                                                      title: '${index + 1}',
                                                      style: Style.small
                                                  )),
                                              horizontalSpace(2.w),
                                              Expanded(
                                                  child: myText(
                                                  title: component!.keys.toList()[index],
                                                  style: Style.small
                                              )),
                                              Expanded(
                                                  child: myText(
                                                  title: component!.values.toList()[index],
                                                  style: Style.small
                                              )),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: component!.values.toList().length,
                                    )
                                  ],
                                ),


                                if(howToPrepare != null)
                                const myText(
                                  title: 'How to prepare',
                                  style: Style.small,
                                  fontWeight: FontWeight.w600,
                                ),
                                if(howToPrepare != null)
                                verticalSpace(2.h),
                                if(howToPrepare != null)
                                myText(
                                  title: howToPrepare!,
                                  style: Style.extraSmall,
                                ),

                                verticalSpace(4.h),
                                myButton(
                                    text: 'delete',
                                    onPressed: ()
                                    {

                                    },
                                    color: ColorsManager.redPrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
