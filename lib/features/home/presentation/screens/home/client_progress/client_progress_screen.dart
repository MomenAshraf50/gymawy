import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
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
              defaultAppBar(title: AppString.clientsProgress, context: context),
              verticalSpace(2.h),
              Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) => InkWell(
                  onTap: ()
                  {
                    navigateTo(context, const ProgressDetailsScreen());
                  },
                  child: buildClientProgressItem(
                    isProgress: true
                  ),
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
