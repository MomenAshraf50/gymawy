import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../widgets/build_settings_item.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
            child: Text('Settings',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(fontWeight: FontWeight.bold))),
      ),
      body: Column(
        children: [
          buildSettingsItem(
              AppString.notifications, Assets.images.svg.notifications_icon, context),
          buildSettingsItem(
              AppString.settingsLocation, Assets.images.svg.location_icon, context),
          buildSettingsItem(AppString.support, Assets.images.svg.support_icon, context),
          buildSettingsItem(AppString.share, Assets.images.svg.share_icon, context),
          buildSettingsItem(AppString.logOut, Assets.images.svg.logout_icon, context),
        ],
      ),
    );
  }

}
