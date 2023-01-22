import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/widgets/build_client_progress_item.dart';
import '../../../controller/home_cubit.dart';
import 'clients_details_screen.dart';

class ClientsScreen extends StatelessWidget {
  ClientsScreen({Key? key , required this.clientVariable}) : super(key: key);
  String? clientVariable;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    constClientVariable = clientVariable;
    homeCubit.search(search: 'search');
    debugPrintFullText( 'is ===========================$constClientVariable');
    return Scaffold(
      body: BlocBuilder<HomeCubit,HomeStates>(
        builder: (context, state) {
          return WillPopScope(
            onWillPop: ()
            async {
              Navigator.pop(context);
              clientVariable = null;
              constClientVariable = null;
              debugPrintFullText( 'is ===========================$constClientVariable');
              return false;
            },
            child: SafeArea(
              child: Padding(
                padding: designApp,
                child: homeCubit.results != null ?
                Column(
                  children: [
                    defaultAppBar(
                      title: AppString.clients,
                      context: context,
                      onPressed: ()
                      {
                        Navigator.pop(context);
                        clientVariable = null;
                        constClientVariable = null;
                        debugPrintFullText( 'is ===========================$constClientVariable');
                      },
                    ),
                    verticalSpace(4.h),
                    Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) => InkWell(
                            onTap: ()
                            {
                              navigateTo(context, ClientDetailsScreen(
                                name: homeCubit.results![index].userName!,
                                address: homeCubit.results![index].location,
                                age: '${homeCubit.results![index].age!}',
                                bodyFat: '${homeCubit.results![index].bodyFat!}',
                                goal: homeCubit.results![index].goal,
                                img: homeCubit.results![index].profilePicture!,
                                tall: '${homeCubit.results![index].currentTall!}',
                                weight: '${homeCubit.results![index].currentWeight!}',
                              ));
                            },
                            child: buildClientProgressItem(
                                isProgress: false,
                                image: NetworkImage(homeCubit.results![index].profilePicture!),
                                name: homeCubit.results![index].userName!,
                            ),
                          ),
                          itemCount: homeCubit.results!.length,
                        ))
                  ],
                ) :
                Container(),
              ),
            ),
          );
        },
      ),
    );
  }
}
