// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:gymawy/core/util/resources/colors_manager.dart';
// import 'package:gymawy/core/util/resources/constants_manager.dart';
// import 'package:gymawy/core/util/resources/extensions_manager.dart';
// import 'package:gymawy/core/util/widgets/default_action_button.dart';
// import 'package:gymawy/core/util/widgets/default_text_field.dart';
// import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
// import 'package:gymawy/features/home/presentation/controller/home_states.dart';
//
// import '../../../../../core/network/remote/location_service.dart';
// import '../../../../../core/util/widgets/default dialog.dart';
// import '../../controller/register_cubit.dart';
// import '../../controller/register_states.dart';
//
// class SetYourLocation extends StatelessWidget {
//    const SetYourLocation({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     RegisterCubit registerCubit = RegisterCubit.get(context);
//     debugPrintFullText('ssssssssssssssssssssssssss = $currentLat');
//     debugPrintFullText('ssssssssssssssssssssssssss = $currentLng');
//     return BlocConsumer<RegisterCubit,RegisterStates>(
//       listener: (context, state) {
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: Column(
//             children: [
//               defaultAppBar(
//                   title: 'Pick your location',
//                   context: context,
//                   actions: [
//                     defaultActionButton(
//                         onPressed: ()
//                         {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return DefaultDialog(
//                                 message:
//                                 '$currentCountry- $currentGovernment  - $currentCity ',
//                                 pushButtonText: 'Okay',
//                                 height: 22.h,
//                                 pushButtonVoidCallback: (){
//                                   countryRegister = currentCountry;
//                                   governmentRegister = currentGovernment;
//                                   cityRegister = currentCity;
//                                   Navigator.pop(context);
//                                   Navigator.pop(context);
//                                   Navigator.pop(context);
//                                   countryRegister != null && governmentRegister != null && cityRegister != null?
//                                   registerCubit.nextPage(true, context) : null;
//                                 },
//                               );
//                             },
//                           );
//                         },
//                         icon: Icons.my_location,
//                         backgroundColor: ColorsManager.white,
//                         iconColor: ColorsManager.black
//                     ),
//                   ]
//               ),
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: 4.w,
//                   right: 4.w,
//                 ),
//                 child: DefaultTextField(
//                     controller: registerCubit.searchLocation,
//                     hint: 'pick your address',
//                     showSuffix: true,
//                     validate: (String? value) {
//                       if (value!.isEmpty) {
//                         return 'isEmpty';
//                       }
//                     },
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.search),
//                     onPressed: ()
//                   async  {
//                     var directions = await LocationService().getDirections(registerCubit.searchLocation.text);
//                     registerCubit.goToLocation(
//                         directions['start_location']['lat'],
//                         directions['start_location']['lng'],
//                         directions['bounds_ne'],
//                         directions['bounds_sw'],
//                         context,
//                       );
//                     registerCubit.getPlace(directions['start_location']['lat'],directions['start_location']['lng']);
//                     },
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: BlocBuilder<HomeCubit,HomeStates>(
//                   builder: (context, state) {
//                     return GoogleMap(
//                       initialCameraPosition: registerCubit.homePosition,
//                       mapType: MapType.terrain,
//                       onMapCreated: (GoogleMapController controller)
//                       {
//                         registerCubit.mapController.complete(controller);
//                       },
//                       //registerCubit.onMapCreated,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
