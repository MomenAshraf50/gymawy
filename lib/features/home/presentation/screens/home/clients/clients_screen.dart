import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/domain/entities/subscription_request_entity.dart';
import 'package:gymawy/features/home/domain/usecase/get_subscriptions_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/clients/pending_screen.dart';
import 'package:gymawy/features/home/presentation/screens/search/search_screen.dart';
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
    homeCubit.getSubscriptionRequests(
        GetSubscriptionsRequestsParams(requestState: 'Accepted'));
    List<SubscriptionRequestEntity> subscriptionRequestEntity = [];
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is GetSubscriptionRequestSuccessState) {
            subscriptionRequestEntity = state.subscriptionRequestEntity;
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
                                          clientId: subscriptionRequestEntity[index].clientId,
                                        ));
                                  },
                                  child: buildClientProgressItem(
                                    isProgress: false,
                                    image: NetworkImage(subscriptionRequestEntity[index].clientPic),
                                    name: subscriptionRequestEntity[index].clientUsername,
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
