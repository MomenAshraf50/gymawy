import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../core/util/resources/appString.dart';
import '../../../controller/home_cubit.dart';

class ExerciseBasicData extends StatelessWidget {
  ExerciseBasicData({
    Key? key,
    required this.exerciseId,
    required this.coachAddedId,
    required this.exerciseName,
    required this.coachAddedName,
    required this.exerciseCategory,
    required this.exerciseVisibility,
    required this.exercisePic,
    required this.exerciseVideo,
  }) : super(key: key);

  int? exerciseId;
  int? coachAddedId;
  String? coachAddedName;
  String? exerciseName;
  String? exerciseCategory;
  String? exercisePic;
  String? exerciseVideo;
  String? exerciseVisibility;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.initializeVideoPlayerController(video: exerciseVideo!);


    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: designApp,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              defaultAppBar(
                title: exerciseName!,
                context: context,
              ),
              verticalSpace(5.h),
              SizedBox(
                height: 40.h,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    homeCubit.videoPlayerController.value.isInitialized ? AspectRatio(
                      aspectRatio: homeCubit
                          .videoPlayerController
                          .value
                          .aspectRatio,
                      child: VideoPlayer(homeCubit.videoPlayerController),
                    )
                        : Image.network(exercisePic!),
                    FloatingActionButton(
                      onPressed: () {
                        homeCubit.pauseAndPlayVideo();
                      },
                      backgroundColor: Colors.white,
                      child: Icon(
                        homeCubit
                            .videoPlayerController.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace(5.h),
               myText(
                  title: 'Exercise Category: $exerciseCategory',
                  style: Style.medium,
                  fontSize: 16.rSp,
              ),
              verticalSpace(3.h),
              myText(
                title: 'Exercise Added by coach: $coachAddedName',
                style: Style.medium,
                fontSize: 16.rSp,
              ),
              verticalSpace(3.h),
              myText(
                title: 'Visibility: $exerciseVisibility',
                style: Style.medium,
                fontSize: 16.rSp,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
