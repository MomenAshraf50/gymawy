import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/resources/setting_items.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../widgets/build_settings_item.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  List<SettingsItem> settingsItems = [
    SettingsItem(AppString.notifications, Assets.images.svg.notifications_icon),
    // SettingsItem(AppString.settingsLocation, Assets.images.svg.location_icon),
    SettingsItem(AppString.support, Assets.images.svg.support_icon),
    SettingsItem(AppString.share, Assets.images.svg.share_icon),
    SettingsItem(AppString.logOut, Assets.images.svg.logout_icon),
  ];

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) =>
                    BlocConsumer<HomeCubit, HomeStates>(
                  listener: (context, state) {
                    if (state is NotificationsSubscriptionSuccessState) {
                      homeCubit.signOut(context);
                    }
                    if (state is NotificationsSubscriptionLoadingState) {
                      showDialog(
                        barrierDismissible: false,
                          context: context,
                          builder: (context) => Dialog(
                                child: SizedBox(
                                  height: 10.h,
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                ),
                              ));
                    }

                    if (state is NotificationsSubscriptionErrorState) {
                      designToastDialog(
                          context: context,
                          toast: TOAST.error,
                          text: 'Something went wrong');
                    }
                  },
                  builder: (context, state) {
                    return buildSettingsItem(
                        text: settingsItems[index].title,
                        iconPath: settingsItems[index].icon,
                        context: context);
                  },
                ),
                itemCount: settingsItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
