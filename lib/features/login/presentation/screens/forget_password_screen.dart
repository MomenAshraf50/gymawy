import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myElevatedButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/login/presentation/screens/recovery_password_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();

    return Scaffold(
      appBar: defaultAppBar(title: AppString.forget_password, context: context),
      body: Padding(
        padding: designApp,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              svgImage(path: Assets.images.svg.forgetPass),
              verticalSpace(10.h),
              const myText(
                title: AppString.enter_register,
                style: Style.large,
                align: TextAlign.center,
              ),
              verticalSpace(20.h),
              myTextFill(
                svgImg: Assets.images.svg.phone,
                type: TextInputType.number,
                controller: controller,
                hint: AppString.phone,
                onChanged: (val) {},
              ),
              const Spacer(),
              myElevatedButton(
                  text: AppString.send, onPressed: controller.text.isNotEmpty ? null : (){
                navigateTo(context, const RecoveryPasswordScreen());
              })
            ],
          ),
        ),
      ),
    );
  }
}
