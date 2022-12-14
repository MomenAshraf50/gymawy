import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';

import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/back_button.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../widgets/build_exercise_item.dart';
import '../home_layout.dart';
import 'exercise_type.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({Key? key}) : super(key: key);

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
                      navigateAndFinish(context, const MainScreen());
                    },
                  ),
                  const Expanded(
                      child: Center(
                          child: myText(
                            title: AppString.exercises,
                            style: Style.large,
                            fontFamily: 'poppins',
                          ))),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) => InkWell(
                    child: buildExercisesItems(),
                    onTap: () {
                      navigateTo(context, const ExerciseType());
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
