import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../controller/home_cubit.dart';

class AddCoachCertifications extends StatelessWidget {
  AddCoachCertifications({Key? key , required this.userId}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  int? userId;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {
        if (state is CertificationSuccessState)
        {
          Navigator.pop(context);
          homeCubit.year = null;
          homeCubit.month = null;
          homeCubit.day = null;
          homeCubit.certificationPdf = null;
          homeCubit.certificateNameController.text = '';
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: designApp,
              child: BlocBuilder<HomeCubit,HomeStates>(
                builder: (context, state) {
                  return Form(
                    key: formKey,
                    child: Column(
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
                                                //homeCubit.selectCertificationImage(context);
                                                homeCubit.selectCertificationPdf();
                                              }
                                          ),
                                          verticalSpace(1.h),
                                        ],
                                      ),
                                    )
                                ),
                                verticalSpace(1.h),
                                if(homeCubit.certificationPdf != null)
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Assets.images.svg.certificate,
                                        width: 6.w,
                                        height: 6.h,
                                      ),
                                      horizontalSpace(5.w),
                                      myText(
                                        title: '${homeCubit.certificationPdf!.files.first.size ~/ 1024} kB',
                                        //AppString.certificationSize,
                                        style: Style.extraSmall,
                                        fontSize: 12.rSp,
                                        color: Colors.blue,
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
                        verticalSpace(4.h),
                        if(homeCubit.certificationPdf != null)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              myTextFill(
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'isEmpty';
                                  }
                                },
                                controller: homeCubit.certificateNameController,
                                hint: AppString.certificateName,
                              ),
                              verticalSpace(2.h),
                              const myText(
                                title: AppString.certificateDate,
                                style: Style.small,
                                fontWeight: FontWeight.w600,
                                color: ColorsManager.darkGrey,
                              ),
                              verticalSpace(2.h),
                              CalendarTimeline(
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime.now(),
                                onDateSelected: (value)
                                {
                                  homeCubit.year = value.year.toString();
                                  homeCubit.month = value.month.toString();
                                  homeCubit.day = value.day.toString();
                                  debugPrintFullText(homeCubit.year!);
                                  debugPrintFullText(homeCubit.month!);
                                  debugPrintFullText(homeCubit.day!);
                                },
                                leftMargin: 20,
                                shrink: true,
                                monthColor: Colors.grey,
                                dayColor: Colors.grey,
                                activeDayColor: Colors.white,
                                activeBackgroundDayColor: ColorsManager.mainColor,
                                dotsColor: Colors.white,
                                locale: 'en',
                              ),
                            ],
                          ),
                        verticalSpace(4.h),
                        myButton(
                            text: AppString.finish,
                            fontSize: 14.rSp,
                            onPressed: ()
                            {
                              if(formKey.currentState!.validate() &&  homeCubit.month != null && homeCubit.certificationPdf != null)
                              {
                                homeCubit.certificate(
                                  id: userId.toString(),
                                  certificateName: homeCubit.certificateNameController.text,
                                  certificateFile: homeCubit.certificationPdf!,
                                  certificateDate: '${homeCubit.year}-${homeCubit.month}-${homeCubit.day}',
                                );
                                //loginCubit.logIn(email: emailController.text, password: passwordController.text);
                              }
                              else
                              {
                                designToastDialog(
                                    context: context,
                                    toast: TOAST.warning,
                                    text: 'please fill ur data');
                              }
                              // Navigator.pop(context);
                            }
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
