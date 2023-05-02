import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';

class FilterDialog extends StatelessWidget {
  FilterDialog({
    Key? key,
    required this.firstFilterTitle,
    required this.secondFilterTitle,
    required this.onTapFirstChoice,
    required this.onTapSecondChoice
  }) : super(key: key);

  String firstFilterTitle;
  String secondFilterTitle;

  VoidCallback onTapFirstChoice;
  VoidCallback onTapSecondChoice;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Column(
        children: [
          InkWell(
            onTap: onTapFirstChoice,
            child: SizedBox(
              height: 5.h,
              child: Row(
                children: [
                  DefaultText(
                    title: firstFilterTitle,
                    style: Style.extraSmall,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  Container(
                    height: 3.h,
                    width: 6.w,
                    decoration: BoxDecoration(
                        color: homeCubit.coachRadioButton
                            ? const Color.fromARGB(255, 248, 96, 13)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
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
            onTap: onTapSecondChoice,
            child: SizedBox(
              height: 5.h,
              child: Row(
                children: [
                  DefaultText(
                    title: secondFilterTitle,
                    style: Style.extraSmall,
                    fontWeight: FontWeight.w600,
                  ),
                  const Spacer(),
                  Container(
                    height: 3.h,
                    width: 6.w,
                    decoration: BoxDecoration(
                        color: homeCubit.clientRadioButton
                            ? const Color.fromARGB(255, 248, 96, 13)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.grey)),
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
