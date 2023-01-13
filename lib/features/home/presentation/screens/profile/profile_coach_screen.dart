import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/profile/add_coach_certifications.dart';
import 'package:gymawy/features/home/presentation/screens/profile/social_web_view.dart';
import 'package:gymawy/features/home/presentation/screens/profile/view_certification.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
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
    homeCubit.getCertificates(
      GetCertificateParams(
          ownerId: homeCubit.profileResults!.userId!,
          ownerName: '',
      ),
      context
    );

    int selected = 0;
    // List<TrainingImage> listTrainingImages = [
    //   TrainingImage(
    //     img: Assets.images.svg.client,
    //   ),
    //   TrainingImage(
    //     img: Assets.images.svg.coach,
    //   ),
    // ];
    //Widget? certificateResultImg;
    //var certificationImage;

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
                                onPressed: () {
                                  navigateTo(context, SocialWebView(
                                    socialUrl: homeCubit.profileResults!.facebookLink!,
                                  ));
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon:
                                SvgPicture.asset(Assets.images.svg.tiktok),
                                onPressed: () {
                                  navigateTo(context, SocialWebView(
                                    socialUrl: homeCubit.profileResults!.tiktokLink!,
                                  ));
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon: SvgPicture.asset(
                                    Assets.images.svg.instagram),
                                onPressed: () {
                                  navigateTo(context, SocialWebView(
                                    socialUrl: homeCubit.profileResults!.instagramLink!,
                                  ));
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon:
                                SvgPicture.asset(Assets.images.svg.youtube),
                                onPressed: () {
                                  navigateTo(context, SocialWebView(
                                    socialUrl: homeCubit.profileResults!.youtubeLink!,
                                  ));
                                })),
                      ],
                    ),
                  ),

                  if(homeCubit.certificateResult != null)
                    SizedBox(
                      height: 25.h,
                      child: PageView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        padEnds: false,
                        controller: PageController(
                          initialPage: selected,
                          viewportFraction: 0.4,
                          keepPage: true,
                        ),
                        allowImplicitScrolling: true,
                        pageSnapping: true,
                        itemBuilder: (context, index) {
                          if(homeCubit.certificateResultImg == null) {
                            homeCubit.convertCertificateToImg(index);
                          }
                          //certificateResultImg = FilePreview.getThumbnail(homeCubit.certificateResult![index].certificateFile );
                          //  certificationImage = FilePreview.getThumbnail(homeCubit.certificateResult![index].certificateFile);
                          return homeCubit.certificateResultImg != null?
                            Container(
                            margin: EdgeInsets.all(9.rSp),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                // selected == index ?
                                BoxShadow(
                                  color: ColorsManager.mainColor,
                                  spreadRadius: 0,
                                  blurRadius: 4,
                                )
                                // : const BoxShadow(),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              // border: Border.all(color: Colors.orange),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  ColorsManager.whiteColor,
                                  ColorsManager.whiteColor,
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.rSp),
                              child: index != homeCubit.certificateResult!.length?
                              InkWell(
                                onTap: () {
                                  navigateTo(context, ViewCertification(
                                      certification: homeCubit.certificateResult![index].certificateFile,
                                      certificationName: homeCubit.certificateResult![index].certificateName,
                                      certificationID: (homeCubit.certificateResult![index].certificateId).toString(),
                                  )
                                  );
                                },
                                child: Column(
                                  children: [
                                    homeCubit.certificateResultImg!,
                                    verticalSpace(1.h),
                                    myText(
                                        title: homeCubit.certificateResult![index].certificateName,
                                        style: Style.medium
                                    ),
                                    verticalSpace(1.h),
                                    myText(
                                        title: homeCubit.certificateResult![index].certificateDate,
                                        style: Style.medium
                                    ),
                                    //certificateResultImg!
                                    // Image.network(
                                    //   homeCubit.certificateResult![index].certificateFile,
                                    //   height: 25.h,
                                    // ),
                                    // SvgPicture.asset(
                                    //   listTrainingImages[index].img,
                                    //   height: 25.h,
                                    // ),
                                  ],
                                ),
                              )
                              :
                              TextButton(
                                onPressed: ()
                                {
                                  navigateTo(context, AddCoachCertifications(
                                      userId: userId
                                  )
                                  );
                                },
                                child: const myText(
                                    title: 'add more',
                                    style: Style.medium
                                ),
                              )
                              ,
                            ),
                          ) :
                            null;
                        },
                        itemCount: homeCubit.certificateResult!.length + 1,
                      ),
                    ),
                  if(homeCubit.certificateResult == null)
                    InkWell(
                      onTap: () {
                        navigateTo(context, AddCoachCertifications(
                            userId: userId
                        )
                        );
                      },
                      child: Card(
                        margin: EdgeInsets.all(25.rSp),
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(20.0.rSp),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: myText(
                                align: TextAlign.center,
                                title: AppString.getCertifications,
                                style: Style.medium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  // Container(
                  //   width: 40.w,
                  //   height: 10.h,
                  //   child: Card(
                  //     margin: EdgeInsets.all(25.rSp),
                  //     elevation: 5,
                  //     child: Padding(
                  //       padding: EdgeInsets.all(20.0.rSp),
                  //       child: Expanded(
                  //         child: ListView.builder(
                  //             itemBuilder: (context, index) {
                  //               return myText(title: 'title', style: Style.medium);
                  //             },
                  //           physics: const BouncingScrollPhysics(),
                  //           itemCount: homeCubit.certificateResult!.length,
                  //           shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),

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
