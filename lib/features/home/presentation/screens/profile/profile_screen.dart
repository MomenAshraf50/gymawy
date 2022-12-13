import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';

import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myElevatedButton.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import '../../controller/home_cubit.dart';
import 'edit_links_screen.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.only(top: 30.h,start: 20.w,end: 20.w),
              child: Row(
                children: [
                  SizedBox(
                    height: 110.h,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: CircleAvatar(
                            radius: 55.rSp,
                            backgroundImage: const NetworkImage('https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc='),
                          ),
                        ),
                        IconButton(onPressed: (){}, icon: SvgPicture.asset(Assets.images.svg.camera,height: 30.h,width: 30.w,),)
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.0.rSp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const myText(title: AppString.userNameProfile,style: Style.medium,),
                          const myText(title: AppString.accountType,style: Style.small,),
                          verticalSpace(10.h),
                          Row(
                            children: [
                              myElevatedButton(
                                  text: AppString.editLinksButton,
                                  fontSize: 10.rSp,
                                  height: 30.h,
                                  width: 80.w,
                                  onPressed: (){
                                navigateTo(context, const EditLinksScreen()
                                );
                              }),
                              horizontalSpace(20.w),
                              myElevatedButton(
                                  text: AppString.editProfileButton,
                                  fontSize: 10.rSp,
                                  height: 30.h,
                                  width: 80.w,
                                  onPressed: (){
                                navigateTo(context, const EditProfileScreen());
                              })
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
              children: const[
                Icon(Icons.location_on_outlined),
                myText(title: AppString.location, style: Style.small),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.0.rSp),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppString.rating,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          AppString.ratingLabel,
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 1.w,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppString.followingNumber,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          AppString.following,
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 40.h,
                    width: 1.w,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          AppString.followersNumber,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          AppString.followers,
                          style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.h),
              child: Row(
                children: [
                  Expanded(child: DefaultIconButton(icon: SvgPicture.asset(Assets.images.svg.facebook_icon,), onPressed: (){})),
                  Expanded(child: DefaultIconButton(icon: SvgPicture.asset(Assets.images.svg.tiktok), onPressed: (){})),
                  Expanded(child: DefaultIconButton(icon: SvgPicture.asset(Assets.images.svg.instagram), onPressed: (){})),
                  Expanded(child: DefaultIconButton(icon: SvgPicture.asset(Assets.images.svg.youtube), onPressed: (){})),
                ],
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.all(20.0.rSp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    const myText(title: AppString.certifications, style: Style.medium),
                    Text(AppString.getCertifications,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.normal),),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
