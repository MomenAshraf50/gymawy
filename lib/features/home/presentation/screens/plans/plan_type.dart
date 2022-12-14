import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';

import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/back_button.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../widgets/build_plan_type.dart';

class PlanType extends StatelessWidget {
  const PlanType({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: designApp,
          child: Column(
            children: [
              Row(
                children: [
                  DefaultBackButton(
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                      child: Center(
                          child: myText(
                            title: AppString.planType,
                            style: Style.large,
                            fontFamily: 'poppins',
                          )
                      )
                  ),
                ],
              ),
              verticalSpace(2.h),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    child: buildPlansTypeItems(),
                    onTap: () {
                      //navigateTo(context, const ExerciseType());
                      debugPrintFullText('$index');
                    },
                  ),
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
              verticalSpace(4.h),
              myButton(
                text: AppString.delete,
                textOnly: true,
                color: const Color.fromARGB(255, 255, 0, 0),
                width: double.infinity,
                radius: 40.h,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
