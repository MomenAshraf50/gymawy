import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import '../../../../../core/util/resources/appString.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/myButton.dart';
import '../../../../../core/util/widgets/myElevatedButton.dart';
import '../../../../../core/util/widgets/myText.dart';
import '../../controller/register_cubit.dart';

class SelectFatScreen extends StatelessWidget {
   SelectFatScreen({Key? key,
     this.userPic,
     required this.country,
     required this.government,
     required this.gender,
     required this.userName,
     required this.firstName,
     required this.lastName,
     required this.fullName,
     required this.age,
     required this.email,
     required this.phone,
     required this.password,
     required this.confirmPassword,
   }) : super(key: key);

  String? gender;
  String? country;
  String? government;
  File? userPic;
  String? userName;
  String? firstName;
  String? lastName;
  String? fullName;
  String? age;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    RegisterCubit registerCubit = RegisterCubit.get(context);
    return BlocBuilder<RegisterCubit, RegisterStates>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            verticalSpace(5.h),
            Expanded(
              child: Column(
                children: const [
                  myText(title: AppString.select_fat, style: Style.large),
                  myText(
                    title: AppString.it_will_help,
                    style: Style.small,
                    align: TextAlign.center,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            verticalSpace(5.h),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 5.h,
                child: PageView.builder(
                  controller: registerCubit.pageFatController,
                  allowImplicitScrolling: true,
                  pageSnapping: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 50,
                      height: 200,
                      child: svgImage(
                        path: registerCubit.listFat[index],
                      ),
                    );
                  },
                  itemCount: registerCubit.listFat.length,
                  onPageChanged: (index) {
                    registerCubit.fatValue = double.parse(index.toString());
                  },
                ),
              ),
            ),
            verticalSpace(5.h),
            Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Slider(
                      value: registerCubit.fatValue,
                      activeColor: ColorsManager.mainColor,
                      min: 0.0,
                      max: 4.0,
                      divisions: 4,
                      onChanged: (double value) async {
                        registerCubit.fatValue = value;
                        await registerCubit.pageFatController.animateToPage(
                            value.round(),
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease);
                      },
                    ),
                    Center(
                        child: registerCubit
                            .getText(registerCubit.fatValue.round())),
                    Padding(
                      padding: designApp,
                      child: myButton(
                          elevation: 0.0,
                          color: ColorsManager.mainColor,
                          height: 3.h,
                          text: AppString.next,
                          onPressed: () {
                            int fat =
                                (registerCubit.fatValue.round()) * 10 + 10;
                            registerCubit.nextPage(true, context);
                          }),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
