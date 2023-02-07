import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:video_player/video_player.dart';
import '../../../controller/home_cubit.dart';

class ExerciseType extends StatelessWidget {
  ExerciseType({
    Key? key ,
    required this.video,
    required this.pic,
    required this.makerName,
    required this.cat,
    required this.rest,
    required this.sets,
    required this.reps,
    required this.name,
    required this.id,
  }) : super(key: key);

  String video;
  String pic;
  String makerName;
  String name;
  String cat;
  int rest;
  int sets;
  int reps;
  int id;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.initializeVideoPlayerController(video: video);
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<HomeCubit,HomeStates>(
          listener:(context, state) {
            if(state is DeleteExercisePlanDetailsSuccessState){
              Navigator.pop(context);
              Navigator.pop(context);
              homeCubit.getExercisePlanDetails(id);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: designApp,
              child: Column(
                children: [
                  defaultAppBar(
                      title: name,
                      context: context,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          verticalSpace(2.h),
                          SizedBox(
                            height: 30.h,
                            width: double.infinity,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                homeCubit.videoPlayerController.value.isInitialized ? AspectRatio(
                                  aspectRatio: homeCubit
                                      .videoPlayerController
                                      .value
                                      .aspectRatio,
                                  child: VideoPlayer(
                                    homeCubit.videoPlayerController,
                                  ),
                                ) : Image.network(pic),
                                if (homeCubit.videoPlayerController.value.isInitialized == true)
                                  FloatingActionButton(
                                    onPressed: () {
                                      homeCubit.pauseAndPlayVideo();
                                    },
                                    backgroundColor: homeCubit.videoPlayerController.value.isPlaying == false ?
                                    Colors.white : Colors.transparent,
                                    child: homeCubit.videoPlayerController.value.isPlaying == false ?
                                    const Icon( Icons.play_arrow,) : null,
                                  )
                              ],
                            ),
                          ),
                          verticalSpace(2.h),
                          myText(
                            title: 'Exercise Category: $cat',
                            style: Style.medium,
                            fontSize: 16.rSp,
                          ),
                          verticalSpace(3.h),
                          myText(
                            title: 'Exercise Added by coach: $makerName',
                            style: Style.medium,
                            fontSize: 16.rSp,
                          ),
                          verticalSpace(5.h),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const myText(
                                      title: AppString.sets,
                                      style: Style.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    verticalSpace(2.h),
                                    const myText(
                                      title: AppString.reps,
                                      style: Style.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    verticalSpace(2.h),
                                    const myText(
                                      title: AppString.rest,
                                      style: Style.medium,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ],
                                ),
                              ),
                              horizontalSpace(5.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    myText(
                                      title: '$sets',
                                      style: Style.extraSmall,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    verticalSpace(2.h),
                                    myText(
                                      title: '$reps',
                                      style: Style.extraSmall,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    verticalSpace(2.h),
                                    myText(
                                      title: '$rest Sec',
                                      style: Style.extraSmall,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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

