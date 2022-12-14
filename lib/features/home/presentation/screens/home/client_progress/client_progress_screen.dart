import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/back_button.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/screens/home/client_progress/progress_details.dart';
import 'package:gymawy/features/home/presentation/widgets/build_client_progress_item.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: Column(
            children: [
              Row(
                children: [
                  DefaultBackButton(function: () {
                    Navigator.pop(context);
                  }),
                  horizontalSpace(4.w),
                  myText(
                    title: AppString.clientsProgress,
                    style: Style.headMedium,
                    fontSize: 18.rSp,
                  )
                ],
              ),
              verticalSpace(4.h),
              Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                  onTap: ()
                  {
                    navigateTo(context, const ProgressDetailsScreen());
                  },
                  child: buildClientProgressItem(),
                ),
                itemCount: 10,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
