import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/profile/add_coach_certifications.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import 'edit_coach_links_screen.dart';
import 'edit_profile.dart';

class ProfileCoachScreen extends StatelessWidget {
  const ProfileCoachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context,state){},
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.rSp, vertical: 20.rSp),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 17.h,
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: homeCubit.profileImageFile != null
                                    ? CircleAvatar(
                                  radius: 60.rSp,
                                  backgroundImage: FileImage(
                                      homeCubit.profileImageFile!),
                                )
                                    : CircleAvatar(
                                  radius: 60.rSp,
                                  backgroundImage:
                                  NetworkImage(
                                    //  'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc='
                                    homeCubit.profileResults!.profilePicture
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  homeCubit.selectProfileImage(context);
                                },
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
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.rSp),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        title: homeCubit.profileResults!.fullName,
                                        //AppString.userNameProfile,
                                        style: Style.small,
                                      ),
                                      myText(
                                        title: isCoachLogin == false?
                                        AppString.client
                                        :AppString.coach,
                                        style: Style.small,
                                      ),
                                    ],
                                  ),
                                ),
                                verticalSpace(1.h),
                                Row(
                                  children: [
                                    if(isCoachLogin == true)
                                    Expanded(
                                      child: myButton(
                                          text: AppString.editLinksButton,
                                          height: 4.h,
                                          fontSize: 10.rSp,
                                          onPressed: () {
                                            navigateTo(context,
                                                const EditCoachLinksScreen());
                                          }),
                                    ),
                                    horizontalSpace(1.w),
                                    Expanded(
                                      child: myButton(
                                          text: AppString.editProfileButton,
                                          height: 4.h,
                                          fontSize: 10.rSp,
                                          onPressed: () {
                                            navigateTo(context,
                                                const EditProfileScreen());
                                          }),
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
                    children: [
                      const Icon(Icons.location_on_outlined),
                      myText(
                        title: homeCubit.profileResults!.governorate,
                        style: Style.small,
                        fontSize: 16.rSp,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0.rSp),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
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
                            children: [
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
                            children: [
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
                                icon:
                                SvgPicture.asset(Assets.images.svg.tiktok),
                                onPressed: () {})),
                        Expanded(
                            child: DefaultIconButton(
                                icon: SvgPicture.asset(
                                    Assets.images.svg.instagram),
                                onPressed: () {})),
                        Expanded(
                            child: DefaultIconButton(
                                icon:
                                SvgPicture.asset(Assets.images.svg.youtube),
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
                          children: [
                            const myText(
                              title: AppString.certifications,
                              style: Style.medium,
                              fontWeight: FontWeight.w600,
                            ),
                            verticalSpace(1.h),
                            homeCubit.certificationImageFile != null
                                ? Image(
                                image: FileImage(
                                    homeCubit.certificationImageFile!))
                                : InkWell(
                              onTap: () {
                                navigateTo(
                                    context, const AddCoachCertifications());
                              },
                              child: const myText(
                                  title: AppString.getCertifications,
                                  style: Style.medium),
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
                              title: AppString.personalTraining,
                              style: Style.medium,
                              fontWeight: FontWeight.w600,
                            ),
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
          );
        },
      ),
    );
  }
}
