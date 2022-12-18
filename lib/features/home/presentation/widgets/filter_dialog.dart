import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog({Key? key,required this.homeCubit}) : super(key: key);

  HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      shape: BeveledRectangleBorder(
          borderRadius:
          BorderRadius.circular(10)),
      title: Column(
        children: [
          InkWell(
            onTap: () {
              homeCubit
                  .changeToCoachRadioButton();
            },
            child: SizedBox(
              height: 5.h,
              child: Row(
                children: [
                  const myText(
                    title: AppString.coaches,
                    style: Style.extraSmall,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  Container(
                    height: 3.h,
                    width: 6.w,
                    decoration: BoxDecoration(
                        color: homeCubit
                            .coachRadioButton
                            ? const Color
                            .fromARGB(
                            255,
                            248,
                            96,
                            13)
                            : Colors
                            .transparent,
                        borderRadius:
                        BorderRadius
                            .circular(5),
                        border: Border.all(
                            color:
                            Colors.grey)),
                  )
                ],
              ),
            ),
          ),
          verticalSpace(1.h),
          Container(
            width: double.infinity,
            height: 0.1.h,
            color: Colors.grey.shade300,
          ),
          verticalSpace(1.h),
          InkWell(
            onTap: () {
              homeCubit
                  .changeToClientRadioButton();
            },
            child: SizedBox(
              height: 5.h,
              child: Row(
                children: [
                  const myText(
                    title: AppString.clients,
                    style: Style.extraSmall,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  Container(
                    height: 3.h,
                    width: 6.w,
                    decoration: BoxDecoration(
                        color: homeCubit
                            .clientRadioButton
                            ? const Color
                            .fromARGB(
                            255,
                            248,
                            96,
                            13)
                            : Colors
                            .transparent,
                        borderRadius:
                        BorderRadius
                            .circular(5),
                        border: Border.all(
                            color:
                            Colors.grey)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }
}
