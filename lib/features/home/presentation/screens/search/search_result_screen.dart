import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/features/home/domain/usecase/get_subscriptions_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/subscription_request_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/network/local/cache_helper.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import '../../../domain/entities/subscription_request_entity.dart';
import '../../../domain/usecase/delete_subscriptionRequest_usecase.dart';
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
          ownerName: '',),
        context);


    List<SubscriptionRequestEntity>? subscriptionRequestResult;

    if(subscriptionID != 0) {
      homeCubit.getSubscriptionRequests(
          GetSubscriptionsRequestsParams(
            subscriptionRequestId: subscriptionID,
          )
      );
    }


    int selected = 0;

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is SubscriptionRequestSuccessState) {
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: AppString.subscribeRequest);
              sl<CacheHelper>().put('subscriptionID', state.subscriptionRequestEntity.subscriptionRequestId);

              homeCubit.getSubscriptionRequests(
                  GetSubscriptionsRequestsParams(
                    subscriptionRequestId: state.subscriptionRequestEntity.subscriptionRequestId,
                  )
              );
            }
            if(state is GetSubscriptionRequestSuccessState) {
              subscriptionRequestResult = state.subscriptionRequestEntity;
            }
            if(state is DeleteSubscriptionRequestSuccessState)
            {
              Navigator.pop(context);
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: 'Subscription canceled successfully');
            }
          },
          builder: (context, state) {
            return state is SubscriptionRequestLoadingState || subscriptionRequestResult == null
                ? const LoadingPage()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        defaultAppBar(
                          title: AppString.accountDetails,
                          context: context,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.rSp, vertical: 20.rSp),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 17.h,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: CircleAvatar(
                                    radius: 60.rSp,
                                    backgroundImage: NetworkImage(
                                        pic!),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 5.0.rSp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.rSp),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            myText(
                                              title:
                                              name!,
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
                                          ],
                                        ),
                                      ),
                                      verticalSpace(1.h),
                                      if (!isCoachLogin! && verification != null && subscriptionRequestResult!.isEmpty)
                                        myButton(
                                            text:AppString.subscribe,
                                            color:ColorsManager.mainColor,
                                            height: 4.h,
                                            fontSize: 10.rSp,
                                            onPressed: () {
                                                homeCubit.subscriptionRequest(
                                                    SubscriptionRequestParams(
                                                      coachId: userId!,
                                                      isUpdate: false,
                                                    ));
                                            }),



                                      if (!isCoachLogin! && verification != null && subscriptionRequestResult!.isNotEmpty && subscriptionRequestResult![0].requestState != 'Accepted')
                                        myButton(
                                            text: subscriptionRequestResult![0].requestState == 'Pending'?
                                            'Pending' : AppString.subscribe,
                                            color: subscriptionRequestResult![0].requestState == 'Pending'?
                                            ColorsManager.regularGrey : ColorsManager.mainColor,
                                            height: 4.h,
                                            fontSize: 10.rSp,
                                            onPressed: () {
                                              if(subscriptionRequestResult![0].requestState == 'Pending')
                                              {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return DefaultDialog(
                                                        message: 'Delete your request',
                                                        pushButtonText: 'Yes',
                                                        buttonColor: ColorsManager.redPrimary,
                                                        pushButtonVoidCallback: ()
                                                        {
                                                          homeCubit.deleteSubscriptionRequest(
                                                              DeleteSubscriptionRequestParams(
                                                                subscriptionRequestResult![0].subscriptionRequestId,
                                                              )
                                                          );
                                                        }
                                                    );
                                                  },
                                                );
                                              }
                                            }),













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
                                              navigateTo(
                                                  context,
                                                  SocialWebView(
                                                    socialUrl: facebookLink!,
                                                  ));
                                            })),
                                    Expanded(
                                        child: DefaultIconButton(
                                            icon: SvgPicture.asset(
                                                Assets.images.svg.tiktok),
                                            onPressed: () {
                                              navigateTo(
                                                  context,
                                                  SocialWebView(
                                                    socialUrl: tiktokLink!,
                                                  ));
                                            })),
                                    Expanded(
                                        child: DefaultIconButton(
                                            icon: SvgPicture.asset(
                                                Assets.images.svg.instagram),
                                            onPressed: () {
                                              navigateTo(
                                                  context,
                                                  SocialWebView(
                                                    socialUrl: instagramLink!,
                                                  ));
                                            })),
                                    Expanded(
                                        child: DefaultIconButton(
                                            icon: SvgPicture.asset(
                                                Assets.images.svg.youtube),
                                            onPressed: () {
                                              navigateTo(
                                                  context,
                                                  SocialWebView(
                                                    socialUrl: youtubeLink!,
                                                  ));
                                            })),
                                  ],
                                ),
                              ),
                              if (homeCubit.certificateResult != null)
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
                                      if (homeCubit.certificateResultImg ==
                                          null) {
                                        homeCubit
                                            .convertCertificateToImg(index);
                                      }
                                      return homeCubit.certificateResultImg !=
                                              null
                                          ? Container(
                                              margin: EdgeInsets.all(9.rSp),
                                              decoration: BoxDecoration(
                                                boxShadow: const [
                                                  // selected == index ?
                                                  BoxShadow(
                                                    color:
                                                        ColorsManager.mainColor,
                                                    spreadRadius: 0,
                                                    blurRadius: 4,
                                                  )
                                                  // : const BoxShadow(),
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(10),
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
                                                    navigateTo(
                                                        context,
                                                        ViewCertification(
                                                          certification: homeCubit
                                                              .certificateResult[
                                                                  index]
                                                              .certificateFile,
                                                          certificationName: homeCubit
                                                              .certificateResult[
                                                                  index]
                                                              .certificateName,
                                                          certificationID: (homeCubit
                                                                  .certificateResult[
                                                                      index]
                                                                  .certificateId)
                                                              .toString(),
                                                        ));
                                                  },
                                                  child: Column(
                                                    children: [
                                                      homeCubit
                                                          .certificateResultImg!,
                                                      verticalSpace(1.h),
                                                      myText(
                                                          title: homeCubit
                                                              .certificateResult[
                                                                  index]
                                                              .certificateName,
                                                          style: Style.medium),
                                                      verticalSpace(1.h),
                                                      myText(
                                                          title: homeCubit
                                                              .certificateResult[
                                                                  index]
                                                              .certificateDate,
                                                          style: Style.medium),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const Center(
                                              child:
                                                  CircularProgressIndicator());
                                    },
                                    itemCount:
                                        homeCubit.certificateResult.length,
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
