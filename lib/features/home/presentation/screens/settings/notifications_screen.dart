import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/domain/entities/notifications_entity.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/widgets/build_notifications_item.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getNotifications();

    List<NotificationsEntity> notificationsList = [];
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is GetNotificationsSuccessState){
          notificationsList = state.notificationsEntity;
        }
        if(state is MarkAsReadSuccessState){
          homeCubit.getNotifications();
        }
      },
      builder: (context, state) {
        return  Scaffold(
          body: SafeArea(
            child: state is GetNotificationsLoadingState?const LoadingPage() :Padding(
              padding: EdgeInsets.all(20.rSp),
              child: Column(
                children: [
                  defaultAppBar(
                      title: AppString.notifications, context: context),
                  verticalSpace(2.h),
                  Expanded(
                    child: ListView.builder(itemBuilder: (context, index) =>
                        buildNotificationsItem(
                          context: context,
                          notificationId: notificationsList[index].id,
                          read: notificationsList[index].read,
                            index: '$index',
                            notificationTitle: notificationsList[index].message,
                            notificationTime: notificationsList[index].time
                        ),
                      itemCount: notificationsList.length,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
