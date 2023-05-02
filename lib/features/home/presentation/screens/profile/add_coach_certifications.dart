import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/features/home/domain/entities/certificate_entity.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:mime/mime.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_button.dart';
import '../../../domain/usecase/get_certifications.dart';
import '../../controller/home_cubit.dart';

class AddCoachCertifications extends StatelessWidget {
  AddCoachCertifications(
      {Key? key, required this.userId, this.certificateEntity})
      : super(key: key);
  var formKey = GlobalKey<FormState>();
  int? userId;

  CertificateEntity? certificateEntity;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is CertificationSuccessState) {
          Navigator.pop(context);
          homeCubit.certificationPdf = null;
          homeCubit.certificateNameController.text = '';
          homeCubit.certificateDescriptionController.text = '';
          homeCubit.certificateDateController.text = '';
          homeCubit.certificateExpirationDateController.text = '';
          homeCubit.certificateSerialController.text = '';
          homeCubit.getCertificates(
              GetCertificateParams(
                ownerId: userId!,
                ownerName: '',
              ),
              context);
          designToastDialog(
              context: context,
              toast: TOAST.success,
              text: 'Certification Added Successfully');
        }
        if (state is UpdateCertificateSuccessState) {
          Navigator.pop(context);
          homeCubit.certificationPdf = null;
          homeCubit.certificateNameController.text = '';
          homeCubit.certificateDescriptionController.text = '';
          homeCubit.certificateDateController.text = '';
          homeCubit.certificateExpirationDateController.text = '';
          homeCubit.certificateSerialController.text = '';
          homeCubit.getCertificates(
              GetCertificateParams(
                ownerId: userId!,
                ownerName: '',
              ),
              context);
          designToastDialog(
              context: context,
              toast: TOAST.success,
              text: 'Certification Updated Successfully');
        }
        if(state is UpdateCertificateErrorState){
          designToastDialog(context: context, toast: TOAST.error,text: state.failure);
        }
        if(state is CertificationErrorState){
          designToastDialog(context: context, toast: TOAST.error,text: state.failure);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: HideKeyboardPage(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: designApp,
                child: BlocBuilder<HomeCubit, HomeStates>(
                  builder: (context, state) {
                    if (certificateEntity != null) {
                      homeCubit.certificateNameController.text =
                          certificateEntity!.certificateName;
                      homeCubit.certificateDescriptionController.text = certificateEntity!.certificateDescription;
                      homeCubit.certificateDateController.text = certificateEntity!.certificateDate;
                      homeCubit.certificateExpirationDateController.text = certificateEntity!.certificateExpirationDate;
                      homeCubit.certificateSerialController.text = certificateEntity!.certificateSerial;
                    }
                    return Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          defaultAppBar(
                              title: AppString.certifications,
                              context: context),
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
                                      color: const Color.fromARGB(
                                          255, 225, 214, 206),
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            verticalSpace(1.h),
                                            SvgPicture.asset(
                                                Assets.images.svg.upload),
                                            verticalSpace(2.h),
                                            DefaultButton(
                                                text: AppString.browseFile,
                                                fontSize: 14.rSp,
                                                width: 5.w,
                                                onPressed: () {
                                                  //homeCubit.selectCertificationImage(context);
                                                  homeCubit
                                                      .selectCertificationPdf();
                                                }),
                                            verticalSpace(1.h),
                                          ],
                                        ),
                                      )),
                                  verticalSpace(1.h),
                                  if (homeCubit.certificationPdf != null)
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          Assets.images.svg.certificate,
                                          width: 6.w,
                                          height: 6.h,
                                        ),
                                        horizontalSpace(5.w),
                                        DefaultText(
                                          title:
                                              '${homeCubit.certificationPdf!.files.first.size ~/ 1024} kB',
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
                          if (homeCubit.certificationPdf != null ||
                              certificateEntity != null)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultTextField(
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'isEmpty';
                                    }
                                    return null;
                                  },
                                  controller:
                                      homeCubit.certificateNameController,
                                  hint: AppString.certificateName,
                                ),
                                DefaultTextField(
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'isEmpty';
                                    }
                                    return null;
                                  },
                                  controller:
                                      homeCubit.certificateSerialController,
                                  hint: AppString.certificateSerial,
                                ),
                                DefaultTextField(
                                  onSubmit: () {},
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'isEmpty';
                                    }
                                    return null;
                                  },
                                  controller: homeCubit
                                      .certificateDescriptionController,
                                  hint: AppString.certificateDescription,
                                ),
                                DefaultTextField(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1990),
                                      lastDate: DateTime.now(),
                                      initialDate: DateTime.now(),
                                    ).then((value) {
                                      homeCubit.certificateDateController.text =
                                          value.toString().substring(0, 10);
                                    });
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'isEmpty';
                                    }
                                    return null;
                                  },
                                  controller:
                                      homeCubit.certificateDateController,
                                  hint: AppString.certificateDate,
                                ),
                                DefaultTextField(
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1990),
                                      lastDate: DateTime(2030),
                                      initialDate: DateTime.now(),
                                    ).then((value) {
                                      homeCubit
                                              .certificateExpirationDateController
                                              .text =
                                          value.toString().substring(0, 10);
                                    });
                                  },
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'isEmpty';
                                    }
                                    return null;
                                  },
                                  controller: homeCubit
                                      .certificateExpirationDateController,
                                  hint: AppString.certificateExpirationDate,
                                ),
                              ],
                            ),
                          verticalSpace(4.h),
                          DefaultButton(
                              text: certificateEntity != null
                                  ? AppString.update
                                  : AppString.finish,
                              fontSize: 14.rSp,
                              onPressed: () {
                                if (certificateEntity == null) {
                                  if (formKey.currentState!.validate() &&
                                      homeCubit.certificationPdf != null) {
                                    if (lookupMimeType(homeCubit
                                            .certificationPdf!
                                            .files
                                            .first
                                            .path!) ==
                                        'application/pdf') {
                                      homeCubit.certificate(
                                        id: userId.toString(),
                                        certificateName: homeCubit
                                            .certificateNameController.text,
                                        certificateFile:
                                            homeCubit.certificationPdf!,
                                        certificateDate: homeCubit
                                            .certificateDateController.text,
                                        certificateSerial: homeCubit
                                            .certificateSerialController.text,
                                        certificateExpirationDate: homeCubit
                                            .certificateExpirationDateController
                                            .text,
                                        certificateDescription: homeCubit
                                            .certificateDescriptionController
                                            .text,
                                      );
                                    } else {
                                      designToastDialog(
                                          context: context,
                                          toast: TOAST.warning,
                                          text: 'Please pick a pdf file.');
                                    }

                                    //loginCubit.logIn(email: emailController.text, password: passwordController.text);
                                  } else {
                                    designToastDialog(
                                        context: context,
                                        toast: TOAST.warning,
                                        text: 'please fill ur data');
                                  }
                                } else {
                                  if (homeCubit.certificationPdf != null) {
                                    if (lookupMimeType(homeCubit
                                            .certificationPdf!
                                            .files
                                            .first
                                            .path!) ==
                                        'application/pdf') {
                                      homeCubit.updateCertificate(
                                        UpdateCertificateParams(
                                          certificate:
                                              homeCubit.certificationPdf,
                                          isFile: true,
                                          certificateId:
                                              certificateEntity!.certificateId,
                                          certificateName: homeCubit
                                              .certificateNameController.text,
                                          certificateDate: homeCubit
                                              .certificateDateController.text,
                                          certificateSerial: homeCubit
                                              .certificateSerialController.text,
                                          certificateExpirationDate: homeCubit
                                              .certificateExpirationDateController
                                              .text,
                                          certificateDescription: homeCubit
                                              .certificateDescriptionController
                                              .text,
                                        ),
                                      );
                                    } else {
                                      designToastDialog(
                                          context: context,
                                          toast: TOAST.warning,
                                          text: 'Please pick a pdf file.');
                                    }
                                  } else {
                                    homeCubit.updateCertificate(
                                        UpdateCertificateParams(
                                      isFile: false,
                                      certificateId:
                                          certificateEntity!.certificateId,
                                      certificateName: homeCubit
                                          .certificateNameController.text,
                                      certificateDate: homeCubit
                                          .certificateDateController.text,
                                      certificateSerial: homeCubit
                                          .certificateSerialController.text,
                                      certificateExpirationDate: homeCubit
                                          .certificateExpirationDateController
                                          .text,
                                      certificateDescription: homeCubit
                                          .certificateDescriptionController
                                          .text,
                                    ));
                                  }
                                }
                                // Navigator.pop(context);
                              }),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
