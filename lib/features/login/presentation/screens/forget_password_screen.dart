import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/login/presentation/screens/recovery_password_screen.dart';

import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/widgets/myButton.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();

    return Scaffold(
      body: HideKeyboardPage(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: designApp,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  verticalSpace(5.h),
                  Row(
                    children: [
                    InkWell(
                      child: SvgPicture.asset(
                        Assets.images.svg.arrow_back,
                      ),
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },
                    ),
                      horizontalSpace(5.h),
                      const Expanded(
                        child: myText(
                          title: AppString.forget_password_title,
                          style: Style.large,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w700,
                          align: TextAlign.center,
                        ),
                      ),

                    ],
                  ),
                  verticalSpace(5.h),
                  svgImage(path: Assets.images.svg.forgetPass),
                  verticalSpace(5.h),
                  const myText(
                    title: AppString.enter_register,
                    style: Style.large,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w700,
                    align: TextAlign.center,
                  ),
                  verticalSpace(10.h),
                  myTextFill(
                    svgImg: Assets.images.svg.phone,
                    type: TextInputType.number,
                    controller: controller,
                    hint: AppString.phone,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontFamily: 'poppins',
                    ),
                    onChanged: (val) {},
                  ),
                  verticalSpace(10.h),
                  myButton(
                      elevation: 0.0,
                      textOnly: true,
                      color: ColorsManager.mainColor,
                      height: 3.h,
                      text: AppString.send,
                      onPressed: controller.text.isNotEmpty ? null : () {
                        navigateTo(context, const RecoveryPasswordScreen());
                      }),
                  // myElevatedButton(
                  //     text: AppString.send,
                  //     onPressed: controller.text.isNotEmpty ? null : (){
                  //   navigateTo(context, const RecoveryPasswordScreen());
                  // })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
