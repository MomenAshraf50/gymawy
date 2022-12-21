import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_action_button.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //HomeCubit homeCubit = HomeCubit.get(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              defaultAppBar(
                  title: '',
                  context: context,
              ),
              Padding(
                padding:EdgeInsets.symmetric(horizontal: 10.rSp,vertical: 20.rSp),
                child: Row(
                  children: [
                    SizedBox(
                      height: 17.h,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              radius: 60.rSp,
                              backgroundImage: const NetworkImage(
                                  'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc='),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              Assets.images.svg.camera,
                              height: 4.h,
                              width: 4.w,
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 5.0.rSp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 10.rSp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  myText(
                                    title: AppString.userNameProfile,
                                    style: Style.small,
                                  ),
                                  myText(
                                    title: AppString.accountType,
                                    style: Style.small,
                                  ),
                                ],
                              ),
                            ),

                            verticalSpace(1.h),
                            Row(
                              children: [
                                Expanded(
                                  child: myButton(
                                      text: AppString.follow,
                                      height: 4.h,
                                      fontSize: 10.rSp,
                                      onPressed: ()
                                      {

                                      }
                                  ),
                                ),
                                horizontalSpace(1.w),
                                Expanded(
                                  child: myButton(
                                      text: AppString.contact,
                                      height: 4.h,
                                      fontSize: 10.rSp,
                                      onPressed: ()
                                      {

                                      }
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Icon(Icons.location_on_outlined),
                  myText(title: AppString.location, style: Style.small,fontSize: 16.rSp,),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20.0.rSp),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children:  [
                          myText(
                            title: AppString.rating,
                            style: Style.extraSmall,
                            fontSize: 16.rSp,
                          ),
                          myText(
                            title: AppString.ratingLabel,
                            style: Style.extraSmall,
                            fontSize: 16.rSp,

                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 4.h,
                      width: 0.5.w,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        children:  [
                          myText(
                            title: AppString.followingNumber,
                            style: Style.extraSmall,
                            fontSize: 16.rSp,

                          ),
                          myText(
                            title: AppString.following,
                            style: Style.extraSmall,
                            fontSize: 16.rSp,

                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 4.h,
                      width: 0.5.w,
                      color: Colors.grey,
                    ),
                    Expanded(
                      child: Column(
                        children:  [
                          myText(
                            title: AppString.followersNumber,
                            style: Style.extraSmall,
                            fontSize: 16.rSp,

                          ),
                          myText(
                            title: AppString.followers,
                            style: Style.extraSmall,
                            fontSize: 16.rSp,

                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.h),
                child: Row(
                  children: [
                    Expanded(
                        child: DefaultIconButton(
                            icon: SvgPicture.asset(
                              Assets.images.svg.facebook_icon,
                            ),
                            onPressed: () {})),
                    Expanded(
                        child: DefaultIconButton(
                            icon: SvgPicture.asset(Assets.images.svg.tiktok),
                            onPressed: () {})),
                    Expanded(
                        child: DefaultIconButton(
                            icon: SvgPicture.asset(Assets.images.svg.instagram),
                            onPressed: () {})),
                    Expanded(
                        child: DefaultIconButton(
                            icon: SvgPicture.asset(Assets.images.svg.youtube),
                            onPressed: () {})),
                  ],
                ),
              ),
              Card(
                margin: EdgeInsets.all(25.rSp),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20.0.rSp),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        myText(
                          title: AppString.certifications, style: Style.medium,fontWeight: FontWeight.w600,),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(25.rSp),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20.0.rSp),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        myText(
                          title: AppString.cv,
                          style: Style.medium,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.all(25.rSp),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20.0.rSp),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        myText(
                          title: AppString.personalTraining, style: Style.medium,fontWeight: FontWeight.w600,),
                        myText(
                            title: AppString.strict, style: Style.medium),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}