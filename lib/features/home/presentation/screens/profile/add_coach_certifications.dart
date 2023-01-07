import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../controller/home_cubit.dart';

class AddCoachCertifications extends StatelessWidget {
  const AddCoachCertifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return Scaffold(
      body: Padding(
        padding: designApp,
        child: BlocBuilder<HomeCubit,HomeStates>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                defaultAppBar(
                    title: AppString.certifications,
                    context: context
                ),
                verticalSpace(5.h),
                SvgPicture.asset(Assets.images.svg.certificate),
                verticalSpace(5.h),
                Card(
                  elevation: 10.rSp,
                  color: const Color.fromARGB(255, 250, 247, 245),
                  child: Padding(
                    padding: EdgeInsets.all(10.rSp),
                    child: Column(
                      children: [
                        DottedBorder(
                            dashPattern: const [8, 4],
                            strokeWidth: 2,
                            color: const Color.fromARGB(255, 225, 214, 206),
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  verticalSpace(1.h),
                                  SvgPicture.asset(Assets.images.svg.upload),
                                  verticalSpace(2.h),
                                  myButton(
                                      text: AppString.browseFile,
                                      fontSize: 14.rSp,
                                      width: 5.w,
                                      onPressed: ()
                                      {
                                        homeCubit.selectCertificationImage(context);
                                      }
                                  ),
                                  verticalSpace(1.h),
                                ],
                              ),
                            )
                        ),
                        verticalSpace(1.h),
                        if(homeCubit.certificationImageFile != null)
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.images.svg.certificate,
                              width: 6.w,
                              height: 6.h,
                            ),
                            horizontalSpace(3.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const myText(
                                  title: AppString.certifications,
                                  style: Style.extraSmall,
                                  color: Colors.blue,
                                ),
                                verticalSpace(1.h),
                                myText(
                                  title: AppString.certificationSize,
                                  style: Style.extraSmall,
                                  fontSize: 10.rSp,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.check_circle_rounded,
                              color: ColorsManager.mainColor,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                myButton(
                    text: AppString.finish,
                    fontSize: 14.rSp,
                    onPressed: ()
                    {
                      Navigator.pop(context);
                    }
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
