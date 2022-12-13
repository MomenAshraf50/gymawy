import 'package:flutter/material.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../widgets/widgets.dart';

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
              'Notifications', Assets.images.svg.notifications_icon, context),
          buildSettingsItem(
              'Location', Assets.images.svg.location_icon, context),
          buildSettingsItem('Support', Assets.images.svg.support_icon, context),
          buildSettingsItem('Share', Assets.images.svg.share_icon, context),
          buildSettingsItem('Log Out', Assets.images.svg.logout_icon, context),
        ],
      ),
    );
  }

}
