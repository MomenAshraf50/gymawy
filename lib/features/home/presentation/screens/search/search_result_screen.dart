import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_action_button.dart';
import '../../../../../core/util/widgets/loadingPage.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import '../../controller/home_cubit.dart';

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
        body:
            // homeCubit.searchResults!.userId != userId && homeCubit.searchResults == null?
            // const Center(
            //     child: LoadingPage()
            // )
            //     :
            SingleChildScrollView(
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
                    Row(
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
                                  WebView(
                                    initialUrl: facebookLink,
                                  );
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon: SvgPicture.asset(Assets.images.svg.tiktok),
                                onPressed: () {
                                  WebView(
                                    initialUrl: tiktokLink,
                                  );
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon: SvgPicture.asset(Assets.images.svg.instagram),
                                onPressed: () {
                                  WebView(
                                    initialUrl: instagramLink,
                                  );
                                })),
                        Expanded(
                            child: DefaultIconButton(
                                icon: SvgPicture.asset(Assets.images.svg.youtube),
                                onPressed: () {
                                  WebView(
                                    initialUrl: youtubeLink,
                                  );
                                })),
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
                              title: AppString.certifications,
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
        ),
      ),
    );
  }
}
