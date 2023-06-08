import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/domain/entities/coach_subscriptions_entity.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/pending_screen.dart';
import 'package:gymawy/features/home/presentation/widgets/build_client_progress_item.dart';
import '../../../controller/home_cubit.dart';
import 'clients_details_screen.dart';

class ClientsScreen extends StatelessWidget {
  ClientsScreen({Key? key, required this.clientVariable}) : super(key: key);
  String? clientVariable;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    constClientVariable = clientVariable;
    homeCubit.getCoachSubscriptions();
    List<CoachSubscriptionsEntity> subscriptionRequestEntity = [];
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is GetCoachSubscriptionsSuccessState) {
            subscriptionRequestEntity = state.subscriptionsEntity;
          }
        },
        builder: (context, state) {
          return state is GetSubscriptionRequestLoadingState
              ? const LoadingPage()
              : WillPopScope(
                  onWillPop: () async {
                    Navigator.pop(context);
                    clientVariable = null;
                    constClientVariable = null;
                    debugPrintFullText(
                        'is ===========================$constClientVariable');
                    return false;
                  },
                  child: SafeArea(
                    child: Padding(
                        padding: designApp,
                        child: Column(
                          children: [
                            defaultAppBar(
                                title: AppString.clients,
                                context: context,
                                onPressed: () {
                                  Navigator.pop(context);
                                  clientVariable = null;
                                  constClientVariable = null;
                                  debugPrintFullText(
                                      'is ===========================$constClientVariable');
                                },
                                actions: [
                                  IconButton(
                                      onPressed: () {
                                        // navigateTo(
                                        //     context,
                                        //     SearchScreen(
                                        //       clientsScreen: true,
                                        //     ));
                                        navigateTo(context, const PendingScreen());
                                      },
                                      // icon: const Icon(Icons.search)
                                    icon: const Icon(Icons.pending_outlined),
                                  )
                                ]),
                            verticalSpace(4.h),
                            if (subscriptionRequestEntity.isNotEmpty)
                              Expanded(
                                  child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context,
                                        ClientDetailsScreen(
                                          clientId: subscriptionRequestEntity[index].clientInformation.userId,
                                          index: index,
                                          result: subscriptionRequestEntity,
                                        ));
                                  },
                                  child: buildClientProgressItem(
                                    isProgress: false,
                                    image: NetworkImage(subscriptionRequestEntity[index].clientInformation.profilePicture),
                                    name: subscriptionRequestEntity[index].clientInformation.userName,
                                  ),
                                ),
                                itemCount: subscriptionRequestEntity.length,
                              ))
                          ],
                        )),
                  ),
                );
        },
      ),
    );
  }
}
