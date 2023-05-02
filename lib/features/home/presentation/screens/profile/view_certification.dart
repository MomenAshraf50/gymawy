import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../domain/usecase/get_certifications.dart';
import '../../controller/home_cubit.dart';

class ViewCertification extends StatelessWidget {
  ViewCertification(
      {Key? key,
      required this.certification,
      required this.certificationName,
      required this.certificationID})
      : super(key: key);
  String? certification;
  String? certificationName;
  String? certificationID;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context, state) {
        if(state is DeleteCertificateSuccessState)
        {
          Navigator.pop(context);
          homeCubit.getCertificates(
              GetCertificateParams(
                ownerId: userId!,
                ownerName: '',
              ),
              context
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: designApp,
            child: Column(
              children: [
                defaultAppBar(
                    title: certificationName!,
                    context: context,
                    actions: [
                      IconButton(
                        onPressed: () {
                          homeCubit.deleteCertificate(
                              certificateId: certificationID!);
                        },
                        icon: const Icon(
                          Icons.delete_forever,
                          color: ColorsManager.redPrimary,
                        ),
                      ),
                    ]),
                verticalSpace(5.h),
                Expanded(
                  child: const PDF(
                    enableSwipe: true,
                    swipeHorizontal: true,
                    autoSpacing: false,
                    pageFling: false,
                  ).cachedFromUrl(
                    certification!,
                    placeholder: (double progress) =>
                        Center(child: Text('$progress %')),
                    errorWidget: (dynamic error) =>
                        Center(child: Text(error.toString())),
                  ),
                ),
                // myButton(
                //   text: 'delete',
                //   color: ColorsManager.redPrimary,
                //   onPressed: ()
                //   {
                //
                //   },
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
