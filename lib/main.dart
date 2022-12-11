import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'features/login/presentation/controller/login_cubit.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
   bool isRtl = false;
  // await sl<CacheHelper>().get('isRtl').then((value) {
  //   debugPrint('rtl ------------- $value');
  //   if (value != null) {
  //     isRtl = value;
  //   }
  //
  //   isArabic = isRtl;
  // });
   String translation = await rootBundle.loadString('assets/translations/${isRtl ? 'ar' : 'en'}.json');
  Bloc.observer = MyBlocObserver();

  runApp(MyApp(
    isRtl: isRtl,
    translation: translation,
    widget: const SplashScreen(),
  ));

}

class MyApp extends StatelessWidget {
  final bool isRtl;
  final String translation;
  final Widget widget;

  const MyApp({
    Key? key,
    required this.isRtl,
    required this.translation,
    required this.widget,

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
      ],
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Gymawy',
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
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

