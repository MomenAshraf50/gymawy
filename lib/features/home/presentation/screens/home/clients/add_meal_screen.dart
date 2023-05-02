import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';

import '../../../../../../core/util/resources/appString.dart';
import '../../../../../../core/util/resources/constants_manager.dart';

class AddClientMealScreen extends StatelessWidget {
  const AddClientMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: Column(
            children: [
              defaultAppBar(title: AppString.addMeal, context: context),
              verticalSpace(2.h),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          SizedBox(
                            height: 10.h,
                            width: 10.w,
                            child: svgImage(
                                path: Assets.images.svg.addMeal
                            ),
                          ),
                          horizontalSpace(5.w),
                          const DefaultText(
                              title: AppString.mealName, style: Style.medium
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: ()
                              {

                              },
                              icon: const Icon(Icons.add)
                          ),
                          IconButton(
                              onPressed: ()
                              {

                              },
                              icon: const Icon(Icons.remove)
                          ),
                        ],
                      );
                    },
                    itemCount: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
