import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/plan_type.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plan_items.dart';
import 'add_plan.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: designApp,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultBackButton(
                    function: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                      child: Center(
                          child: myText(
                            title: AppString.plans,
                            style: Style.large,
                            fontFamily: 'poppins',
                          ))),
                  const Spacer(),
                  Container(
                    height: 5.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.rSp),
                      color: Colors.green,
                    ),
                    child: IconButton(
                        onPressed: () {
                          navigateTo(context, const AddPlan());
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        )),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    child: buildPlansItems(context),
                    onTap: () {
                      navigateTo(context, const PlanType());
                      debugPrintFullText('$index');
                    },
                  ),
                  itemCount: 10,
                  physics: const BouncingScrollPhysics(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
