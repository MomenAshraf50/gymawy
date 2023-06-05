import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gymawy/core/util/resources/bloc_observer_manager.dart';
import 'package:gymawy/features/login/presentation/screens/splash_screen.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import '/core/di/injection.dart' as di;
import 'core/di/injection.dart';
import 'core/network/local/cache_helper.dart';
import 'core/util/cubit/cubit.dart';
import 'core/util/cubit/state.dart';
import 'core/util/resources/constants_manager.dart';
import 'features/home/presentation/controller/home_cubit.dart';
import 'features/login/presentation/controller/login_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';



void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  await firebaseMessaging.getToken().then((value){
    deviceToken = value;
    debugPrintFullText(value!);
  });





  await di.init();
  bool isRtl = false;
  token = await sl<CacheHelper>().get('token');
  userId = await sl<CacheHelper>().get('userId');
  userName = await sl<CacheHelper>().get('userName');
  isCoachLogin = await sl<CacheHelper>().get('isCoach') ?? false;
  email = await sl<CacheHelper>().get('email');
  subscriptionID = await sl<CacheHelper>().get('subscriptionID');
  debugPrintFullText('My Current Token => $token');
  debugPrintFullText('My Current ID => $userId');
  debugPrintFullText('My Current type => $isCoachLogin');
  debugPrintFullText('My Current type => $userName');



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
          create: (context) => sl<RegisterCubit>()..readJson(context),
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

