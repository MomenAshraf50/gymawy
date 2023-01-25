import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gymawy/core/util/resources/bloc_observer_manager.dart';
import 'package:gymawy/features/login/presentation/screens/splash_screen.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import '/core/di/injection.dart' as di;
import 'core/di/injection.dart';
import 'core/network/local/cache_helper.dart';
import 'core/util/cubit/cubit.dart';
import 'core/util/cubit/state.dart';
import 'core/util/resources/constants_manager.dart';
import 'core/util/resources/routes_manager.dart';
import 'features/home/presentation/controller/home_cubit.dart';
import 'features/login/presentation/controller/login_cubit.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  await Geolocator.requestPermission();
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  currentLat = position.latitude;
  currentLng = position.longitude;
  debugPrintFullText(currentLat.toString());
  debugPrintFullText(currentLng.toString());

  List<Placemark> placeMarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  debugPrintFullText(placeMarks.toString());
  Placemark placeMark = placeMarks[0];
  currentCountry = '${placeMark.country}';
  currentCity = '${placeMark.subAdministrativeArea}';
  currentGovernment = '${placeMark.administrativeArea}';

  await di.init();
   bool isRtl = false;
  token = await sl<CacheHelper>().get('token');
  userId = await sl<CacheHelper>().get('userId');
  isCoachLogin = await sl<CacheHelper>().get('isCoach');
  email = await sl<CacheHelper>().get('email');
  debugPrintFullText('My Current Token => $token');
  debugPrintFullText('My Current ID => $userId');
  debugPrintFullText('My Current type => $isCoachLogin');



  String translation = await rootBundle.loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    isRtl: isRtl,
    translation: translation,
    widget: const SplashScreen(),
    token: token,
    id: userId,
    isCoach: isCoachLogin,
    email:email,
  ));

}

class MyApp extends StatelessWidget {
  final bool isRtl;
  final String translation;
  final Widget widget;
  String? token;
  bool? isCoach;
  int? id;
  String? email;

   MyApp({
    Key? key,
    required this.isRtl,
    required this.translation,
    required this.widget,
    required this.token,
    required this.email,
    required this.isCoach,
    required this.id,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => sl<AppBloc>()
            ..setThemes(
              rtl: isRtl,
            )
            ..setTranslation(
              translation: translation,
            )
            ..connectivityListener(),
        ),
        BlocProvider(
          create: (context) => sl<LoginCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<RegisterCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<HomeCubit>(),
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Gymawy',
            debugShowCheckedModeBanner: false,
            themeMode:ThemeMode.light,
            theme: AppBloc.get(context).lightTheme,
            // initialRoute: Routes.splash,
            // routes: Routes.routes,
            home: widget,
          );
        },
      ),
    );
  }
}

