import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/widgets/build_client_progress_item.dart';

import 'clients_details_screen.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: designApp,
          child: Column(
            children: [
              defaultAppBar(
                  title: AppString.clients,
                  context: context
              ),
              verticalSpace(4.h),
              Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: ()
                      {
                        navigateTo(context, ClientDetailsScreen());
                      },
                      child: buildClientProgressItem(
                        isProgress: false
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
