import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:gymawy/features/register/presentation/screens/register_layout.dart';
import 'package:gymawy/features/register/presentation/widgets/build_card_widget.dart';

import '../../../../../core/util/resources/constants_manager.dart';

class ChooseYourTypeScreen extends StatelessWidget {
  const ChooseYourTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(title: AppString.register, context: context),
      body: Padding(
        padding: designApp,
        child: Center(
          child: BlocBuilder<RegisterCubit, RegisterStates>(
            buildWhen: (previous, current) =>
                current is RegisterChangeTypeState ||
                current is RegisterChangeModeState,
            builder: (context, state) {
              RegisterCubit registerCubit = RegisterCubit.get(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const myText(
                      title: AppString.select_type,
                      align: TextAlign.center,
                      fontWeight: FontWeight.w800,
                      style: Style.large),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                          child: GestureDetector(
                              onTap: () => registerCubit
                                  .selectType(isCoach: true)
                                  .then((value) => navigateTo(
                                      context, const RegisterLayout())),
                              child: buildCard(
                                  image: Assets.images.svg.coach,
                                  title: AppString.coach,
                                  context: context))),
                      horizontalSpace(20.w),
                      Expanded(
                          child: GestureDetector(
                              onTap: () => registerCubit
                                      .selectType(isCoach: false)
                                      .then((value) {
                                    registerCubit.changePage(0, context);
                                    navigateTo(context, const RegisterLayout());
                                  }),
                              child: buildCard(
                                  image: Assets.images.svg.client,
                                  title: AppString.clint,
                                  context: context))),
                    ],
                  ),
                  const Spacer(flex: 2),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
