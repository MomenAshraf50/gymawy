import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_action_button.dart';
import '../../../../../core/util/widgets/loadingPage.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import '../../../domain/usecase/get_certifications.dart';
import '../../controller/home_cubit.dart';
import '../profile/social_web_view.dart';
import '../profile/view_certification.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen(
      {Key? key,
      required this.userId,
      required this.pic,
      required this.name,
      required this.location,
       this.tiktokLink,
       this.youtubeLink,
       this.instagramLink,
       this.facebookLink,
       this.fixedPrice,
       this.verification,
       this.bodyFat,
       this.currentTall,
       this.currentWeight,
       this.goal,
       this.bio,
       this.age})
      : super(key: key);
  int? userId;
  String? pic;
  String? name;
  String? location;
  String? facebookLink;
  String? instagramLink;
  String? youtubeLink;
  String? tiktokLink;
  String? bio;
  double? fixedPrice;
  bool? verification;
  int? age;
  int? bodyFat;
  int? currentTall;
  double? currentWeight;
  String? goal;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getCertificates(
        GetCertificateParams(
          ownerId: userId!,
          ownerName: '',
        ),
        context
    );
    int selected = 0;
    debugPrintFullText(' user id issssssssssssssssssssssss $userId');
    debugPrintFullText(' user pic issssssssssssssssssssssss $pic');
    debugPrintFullText(' user name issssssssssssssssssssssss $name');
    debugPrintFullText(' user location issssssssssssssssssssssss $location');
    debugPrintFullText(' user facebookLink issssssssssssssssssssssss $facebookLink');
    debugPrintFullText(' user instagramLink issssssssssssssssssssssss $instagramLink');
    debugPrintFullText(' user youtubeLink issssssssssssssssssssssss $youtubeLink');
    debugPrintFullText(' user tiktokLink issssssssssssssssssssssss $tiktokLink');
    debugPrintFullText(' user bio issssssssssssssssssssssss $bio');
    debugPrintFullText(' user fixedPrice issssssssssssssssssssssss $fixedPrice');
    debugPrintFullText(' user verification issssssssssssssssssssssss $verification');
    debugPrintFullText(' user age issssssssssssssssssssssss $age');
    debugPrintFullText(' user bodyFat issssssssssssssssssssssss $bodyFat');
    debugPrintFullText(' user currentTall issssssssssssssssssssssss $currentTall');
    debugPrintFullText(' user currentWeight issssssssssssssssssssssss $currentWeight');
    debugPrintFullText(' user goal issssssssssssssssssssssss $goal');
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HomeCubit,HomeStates>(
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  defaultAppBar(
                    title: AppString.accountDetails,
                    context: context,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.rSp, vertical: 20.rSp),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 17.h,
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              radius: 60.rSp,
                              backgroundImage: NetworkImage(
                                // 'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc='
                                //homeCubit.searchResults!.profilePicture,
                                  pic!),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: 5.0.rSp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.rSp),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      myText(
                                        title:
                                        //homeCubit.searchResults!.fullName,
                                        name!,
                                        //AppString.userNameProfile,
                                        style: Style.small,
                                      ),
                                      if (verification == null)
                                        const myText(
                                          title: AppString.client,
                                          style: Style.small,
                                        ),
                                      if (verification != null)
                                        const myText(
                                          title: AppString.coach,
                                          style: Style.small,
                                        ),
                                      // const myText(
                                      //   title: AppString.coach,
                                      //   style: Style.small,
                                      // ),
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
                                          onPressed: () {}),
                                    ),
                                    horizontalSpace(1.w),
                                    Expanded(
                                      child: myButton(
                                          text: AppString.contact,
                                          height: 4.h,
                                          fontSize: 10.rSp,
                                          onPressed: () {}),
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
                        title: location!,
                        //homeCubit.searchResults!.governorate,
                        //AppString.location,
                        style: Style.small,
                        fontSize: 16.rSp,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0.rSp),
                    child: Row(
                      children: [
                        if (verification != null)
                          Expanded(
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
                              ],
                            ),
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
                  if (verification != null)
                    Column(
                      children: [
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
                                          socialUrl: facebookLink!,
                                        ));
                                      })),
                              Expanded(
                                  child: DefaultIconButton(
                                      icon: SvgPicture.asset(Assets.images.svg.tiktok),
                                      onPressed: () {
                                        navigateTo(context, SocialWebView(
                                          socialUrl: tiktokLink!,
                                        ));
                                      })),
                              Expanded(
                                  child: DefaultIconButton(
                                      icon: SvgPicture.asset(Assets.images.svg.instagram),
                                      onPressed: () {
                                        navigateTo(context, SocialWebView(
                                          socialUrl: instagramLink!,
                                        ));
                                      })),
                              Expanded(
                                  child: DefaultIconButton(
                                      icon: SvgPicture.asset(Assets.images.svg.youtube),
                                      onPressed: () {
                                        navigateTo(context, SocialWebView(
                                          socialUrl: youtubeLink!,
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
                                    child: InkWell(
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
                                    ),
                                  ),
                                ) :
                                null;
                              },
                              itemCount: homeCubit.certificateResult!.length,
                            ),
                          ),
                        // Card(
                        //   margin: EdgeInsets.all(25.rSp),
                        //   elevation: 5,
                        //   child: Padding(
                        //     padding: EdgeInsets.all(20.0.rSp),
                        //     child: SizedBox(
                        //       width: double.infinity,
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: const [
                        //           myText(
                        //             title: AppString.certifications,
                        //             style: Style.medium,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ],
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
                                  myText(title: AppString.strict, style: Style.medium),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
