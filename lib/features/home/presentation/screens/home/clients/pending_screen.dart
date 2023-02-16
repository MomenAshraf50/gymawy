import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../domain/entities/subscription_request_entity.dart';
import '../../../../domain/usecase/get_subscriptions_usecase.dart';
import '../../../../domain/usecase/subscription_request_usecase.dart';
import '../../../widgets/build_client_progress_item.dart';
import 'clients_details_screen.dart';

class PendingScreen extends StatelessWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    HomeCubit homeCubit = HomeCubit.get(context);

    homeCubit.getSubscriptionRequests(GetSubscriptionsRequestsParams(requestState: 'Pending'));

    List<SubscriptionRequestEntity> subscriptionRequestEntity = [];


    return Scaffold(
      body: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {
          if (state is GetSubscriptionRequestSuccessState) {
            subscriptionRequestEntity = state.subscriptionRequestEntity;
          }
          if(state is SubscriptionRequestSuccessState)
          {
            Navigator.pop(context);
            homeCubit.getSubscriptionRequests(GetSubscriptionsRequestsParams(requestState: 'Accepted'));
            designToastDialog(
                context: context,
                toast: TOAST.success,
                text: 'Request done'
            );
          }
        },
        builder: (context, state) {
          return state is GetSubscriptionRequestLoadingState? const LoadingPage() :
            SafeArea(
              child: Padding(
                padding: designApp,
                child: Column(
                  children: [
                    defaultAppBar(
                        title: 'Pending',
                        context: context,
                        onPressed: ()
                        {
                          Navigator.pop(context);
                          homeCubit.getSubscriptionRequests(GetSubscriptionsRequestsParams(requestState: 'Accepted'));
                        }
                    ),
                    Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => InkWell(
                            onTap: ()
                            {
                              navigateTo(
                                  context,
                                  ClientDetailsScreen(
                                    clientId: subscriptionRequestEntity[index].clientId,
                                  ));
                            },
                            child: buildClientProgressItem(
                              isProgress: false,
                              isPending: true,
                              onPressedAccept: ()
                              {
                                homeCubit.subscriptionRequest(
                                    SubscriptionRequestParams(
                                      status: 'Accepted',
                                      isUpdate: true,
                                      subscriptionRequest: subscriptionRequestEntity[index].subscriptionRequestId,
                                    ));
                              },
                              onPressedDecline: ()
                              {
                                homeCubit.subscriptionRequest(
                                    SubscriptionRequestParams(
                                      status: 'Declined',
                                      isUpdate: true,
                                      subscriptionRequest: subscriptionRequestEntity[index].subscriptionRequestId,
                                    ));
                              },
                              image: NetworkImage(subscriptionRequestEntity[index].clientPic),
                              name: subscriptionRequestEntity[index].clientUsername,
                            ),
                          ),
                          itemCount: subscriptionRequestEntity.length,
                        ))
                  ],
                ),
              )
          );
        },
      ),
    );
  }
}
