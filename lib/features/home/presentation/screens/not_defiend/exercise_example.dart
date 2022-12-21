import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:video_player/video_player.dart';

class ExerciseExampleScreen extends StatelessWidget {
  const ExerciseExampleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultBackButton(
                function: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center(
                      //   child: homeCubit.videoPlayerController.value.isInitialized
                      //       ? AspectRatio(
                      //     aspectRatio: homeCubit
                      //         .videoPlayerController.value.aspectRatio,
                      //     child: VideoPlayer(homeCubit.videoPlayerController),
                      //   )
                      //       : Container(),
                      // ),
                      SvgPicture.asset(Assets.images.svg.jumpingJacks),
                      verticalSpace(2.h),
                      const myText(
                        title: AppString.jumpingJacks,
                        style: Style.small,
                      ),
                      verticalSpace(1.h),
                      Row(
                        children: [
                          const myText(
                            title: AppString.exerciseLevel,
                            style: Style.extraSmall,
                          ),
                          horizontalSpace(2.w),
                          Container(
                            height: 2.h,
                            width: 0.5.w,
                            color: Colors.grey,
                          ),
                          horizontalSpace(2.w),
                          const myText(
                            title: '390 ${AppString.caloriesBurn}',
                            style: Style.extraSmall,
                          )
                        ],
                      ),
                      verticalSpace(3.h),
                      const myText(
                        title: AppString.descriptions,
                        style: Style.small,
                      ),
                      verticalSpace(2.h),
                      const myText(
                        title:
                            'A jumping jack, also known as a star jump and called a side-straddle hop in the US military, is a physical jumping exercise performed by jumping to a position with the legs spread wide',
                        style: Style.extraSmall,
                        maxLines: 4,
                      ),
                      verticalSpace(3.h),
                      Stepper(
                        physics: const NeverScrollableScrollPhysics(),
                        steps: const [
                          Step(
                            isActive: true,
                            title: myText(
                              title: 'Spread Your Arms',
                              style: Style.small,
                            ),
                            content: myText(
                              title:
                                  'To make the gestures feel more relaxed, stretch your arms as you start this movement. No bending of hands.',
                              style: Style.extraSmall,
                              maxLines: 4,
                            ),
                          ),
                          Step(
                            isActive: true,
                            title: myText(
                              title: 'Rest at The Toe',
                              style: Style.small,
                            ),
                            content: myText(
                              title:
                                  'The basis of this movement is jumping. Now, what needs to be considered is that you have to use the tips of your feet',
                              style: Style.extraSmall,
                              maxLines: 4,

                            ),
                          ),
                          Step(
                            isActive: true,
                            title: myText(
                              title: 'Adjust Foot Movement',
                              style: Style.small,
                            ),
                            content: myText(
                              title:
                                  'Jumping Jack is not just an ordinary jump. But, you also have to pay close attention to leg movements.',
                              style: Style.extraSmall,
                              maxLines: 4,

                            ),
                          ),
                          Step(
                            isActive: true,
                            title: myText(
                              title: 'Clapping Both Hands',
                              style: Style.small,
                            ),
                            content: myText(
                              title:
                                  'This cannot be taken lightly. You see, without realizing it, the clapping of your hands helps you to keep your rhythm while doing the Jumping Jack',
                              style: Style.extraSmall,
                              maxLines: 4,
                            ),
                          ),
                        ],
                        onStepTapped: (index){

                        },
                      )
                    ],
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
