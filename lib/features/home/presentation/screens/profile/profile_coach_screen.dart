import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/two_option_dialog.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/profile/add_coach_certifications.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import 'edit_coach_links_screen.dart';
import 'edit_profile.dart';

class ProfileCoachScreen extends StatelessWidget {
  const ProfileCoachScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    if (homeCubit.profileResults != null) {
      homeCubit.getCertificates(
          GetCertificateParams(
            ownerId: homeCubit.profileResults!.userInformation.userId,
            ownerName: '',
          ));
    }

    debugPrintFullText('sssssssssssssssssssss${homeCubit.certificateResult}');

    int selected = 0;
    return SafeArea(
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            homeCubit.getCertificates(
                GetCertificateParams(
                  ownerId: homeCubit.profileResults!.userInformation.userId,
                  ownerName: '',
                ));
          }
          if(state is DeleteCertificateSuccessState){
            Navigator.pop(context);
            homeCubit.getCertificates(GetCertificateParams(
              ownerId: homeCubit.profileResults!.userInformation.userId,
              ownerName: '',
            ));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: homeCubit.profileResults == null
                ? const LoadingPage()
                : SingleChildScrollView(
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
                                  backgroundImage: NetworkImage(
                                      homeCubit.profileResults!
                                          .userInformation.profilePicture),
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
                                      DefaultText(
                                        title:
                                        '${isCoachLogin == false
                                            ? AppString.client
                                            : AppString.coach}, ${homeCubit.profileResults!
                                            .userInformation
                                            .firstName} ${homeCubit
                                            .profileResults!.userInformation
                                            .lastName}',
                                        //AppString.userNameProfile,
                                        style: Style.small,
                                      ),
                                      // verticalSpace(1.h),
                                      // DefaultText(
                                      //   title: isCoachLogin == false
                                      //       ? AppString.client
                                      //       : AppString.coach,
                                      //   style: Style.small,
                                      // ),
                                      verticalSpace(2.h),
                                      DefaultText(
                                        title: homeCubit.profileResults!.userInformation.bio,
                                        //AppString.userNameProfile,
                                        style: Style.small,
                                      ),

                                    ],
                                  ),
                                ),
                                verticalSpace(2.h),
                                Row(
                                  children: [
                                    if (isCoachLogin)
                                      Expanded(
                                        child: DefaultButton(
                                            text: AppString.editLinksButton,
                                            height: 4.h,
                                            fontSize: 10.rSp,
                                            onPressed: () {
                                              navigateTo(context,
                                                  EditCoachLinksScreen(
                                                    facebookLink: homeCubit
                                                        .profileResults!
                                                        .facebookLink!,
                                                    tiktokLink: homeCubit
                                                        .profileResults!
                                                        .tiktokLink!,
                                                    instagramLink: homeCubit
                                                        .profileResults!
                                                        .instagramLink!,
                                                    youtubeLink: homeCubit
                                                        .profileResults!
                                                        .youtubeLink!,
                                                  ));
                                            }),
                                      ),
                                    horizontalSpace(1.w),
                                    Expanded(
                                      child: DefaultButton(
                                          text: AppString.editProfileButton,
                                          height: 4.h,
                                          fontSize: 10.rSp,
                                          onPressed: () {
                                            navigateTo(context,
                                                EditProfileScreen(
                                                  userName: homeCubit.profileResults!.userInformation.userName,
                                                  email: homeCubit.profileResults!.userInformation.email,
                                                  firstName: homeCubit.profileResults!.userInformation.firstName,
                                                  lastName: homeCubit.profileResults!.userInformation.lastName,
                                                  phone: homeCubit.profileResults!.userInformation.phoneNumber,
                                                  bio: homeCubit.profileResults!.userInformation.bio,
                                                  price: homeCubit.profileResults!.fixedPrice!,
                                                ));
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
                      DefaultText(
                        title: homeCubit.profileResults!.userInformation.governorate,
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
                              DefaultText(
                                title: AppString.rating,
                                style: Style.extraSmall,
                                fontSize: 16.rSp,
                              ),
                              DefaultText(
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
                              DefaultText(
                                title: AppString.followingNumber,
                                style: Style.extraSmall,
                                fontSize: 16.rSp,
                              ),
                              DefaultText(
                                title: AppString.clients,
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
                                  homeCubit.launch(Uri.parse(
                                      homeCubit.profileResults!.facebookLink!));
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon:
                                SvgPicture.asset(Assets.images.svg.tiktok),
                                onPressed: () {
                                  homeCubit.launch(Uri.parse(
                                      homeCubit.profileResults!.tiktokLink!));
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon: SvgPicture.asset(
                                    Assets.images.svg.instagram),
                                onPressed: () {
                                  homeCubit.launch(Uri.parse(
                                      homeCubit.profileResults!
                                          .instagramLink!));
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon:
                                SvgPicture.asset(Assets.images.svg.youtube),
                                onPressed: () {
                                  homeCubit.launch(Uri.parse(
                                      homeCubit.profileResults!.youtubeLink!));
                                })),
                      ],
                    ),
                  ),

                  if (homeCubit.certificateResult.isNotEmpty)
                    SizedBox(
                      height: 30.h,
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
                          if (homeCubit.certificateResultImg == null) {
                            homeCubit.convertCertificateToImg(index);
                          }
                          return homeCubit.certificateResultImg != null
                              ? InkWell(
                            onLongPress: () {

                              showDialog(context: context,
                                builder: (context) =>
                                    TwoOptionsDialog(message: 'Choose Action',
                                        popButtonText: AppString.update,
                                        pushButtonText: AppString.delete,
                                        pushButtonVoidCallback: (){
                                      homeCubit.deleteCertificate(certificateId: homeCubit.certificateResult[index].certificateId);
                                        },
                                        popButtonVoidCallback: (){
                                          navigateTo(
                                              context,
                                              AddCoachCertifications(
                                                userId: userId,
                                                certificateEntity: homeCubit
                                                    .certificateResult[index],
                                              ));
                                        }),);
                            },
                            child: Container(
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
                                child: index !=
                                    homeCubit
                                        .certificateResult.length
                                    ? InkWell(
                                  onTap: () {
                                    // navigateTo(
                                    //     context,
                                    //     ViewCertification(
                                    //       certification: homeCubit
                                    //           .certificateResult[
                                    //               index]
                                    //           .certificateFile,
                                    //       certificationName: homeCubit
                                    //           .certificateResult[
                                    //               index]
                                    //           .certificateName,
                                    //       certificationID: (homeCubit
                                    //               .certificateResult[
                                    //                   index]
                                    //               .certificateId)
                                    //           .toString(),
                                    //     ));
                                    homeCubit.launch(Uri.parse(
                                        homeCubit.certificateResult[index]
                                            .certificateFile));
                                  },
                                  child: Column(
                                    children: [
                                      homeCubit.certificateResultImg!,
                                      verticalSpace(3.h),
                                      DefaultText(
                                          title: homeCubit
                                              .certificateResult[index]
                                              .certificateName,
                                          style: Style.medium),
                                      DefaultText(title: homeCubit
                                          .certificateResult[index]
                                          .certificateDate,
                                          style: Style.medium),
                                    ],
                                  ),
                                )
                                    : TextButton(
                                  onPressed: () {
                                    navigateTo(
                                        context,
                                        AddCoachCertifications(
                                            userId: userId));
                                  },
                                  child: const DefaultText(
                                      title: 'add more',
                                      style: Style.medium),
                                ),
                              ),
                            ),
                          )
                              : const Center(
                              child: CircularProgressIndicator());
                        },
                        itemCount: homeCubit.certificateResult.length + 1,
                      ),
                    ),
                  if (homeCubit.certificateResult.isEmpty)
                    InkWell(
                      onTap: () {
                        navigateTo(
                            context, AddCoachCertifications(userId: userId));
                      },
                      child: Card(
                        margin: EdgeInsets.all(25.rSp),
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.all(20.0.rSp),
                          child: const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: DefaultText(
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

                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
