import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';

import '/core/util/cubit/state.dart';
import '/core/util/resources/colors_manager.dart';
import '/core/util/resources/translation_manager.dart';
import '../../di/injection.dart';
import '../../network/local/cache_helper.dart';

class AppBloc extends Cubit<AppState> {

  AppBloc() : super(Empty());

  static AppBloc get(context) => BlocProvider.of(context);

  bool isArabic = false;

  bool isDark = false;

  late ThemeData lightTheme;

  late String family;

  void setThemes({
    required bool rtl,
  }) {
    isArabic = rtl;

    changeTheme();

    emit(ThemeLoaded());
  }

  void changeDarkMode() {
    isDark = !isDark;

    emit(ThemeChanged());
  }

  void changeTheme() {
    family = 'Sofia';

    lightTheme = ThemeData(
      //useMaterial3: true,
      scaffoldBackgroundColor: ColorsManager.white,
      timePickerTheme: TimePickerThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsManager.white,
        elevation: 0.0,
        titleSpacing: 0.0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
          size: 20.0,
        ),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: family,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.textPrimaryBlue,
        elevation: 50.0,
        selectedItemColor: ColorsManager.primary,
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(
          height: 1.5,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorsManager.mainColor
      ),
      //primarySwatch: MaterialColor(int.parse('0xff0075ff'), color),
      colorScheme: const ColorScheme(
        primary: ColorsManager.primary,
        onPrimary: ColorsManager.primary,
        primaryContainer: ColorsManager.orangePrimary,
        secondary: ColorsManager.textPrimaryBlue,
        onSecondary: ColorsManager.onSecondaryLight,
        secondaryContainer: ColorsManager.secondaryContainerLight,
        onSecondaryContainer: ColorsManager.textPrimaryBlue,
        tertiary: ColorsManager.textPrimaryBlue,
        onTertiary: ColorsManager.onTertiaryLight,
        surface: ColorsManager.surfaceLight,
        onSurface: ColorsManager.onSurfaceLight,
        background: ColorsManager.textPrimaryBlue,
        onBackground: ColorsManager.onSurfaceLight,
        error: ColorsManager.white,
        onError: ColorsManager.onSurfaceLight,
        brightness: Brightness.light,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 34.0,
          fontFamily: family,
          fontWeight: FontWeight.w700,
          color: ColorsManager.textPrimaryBlue,
        ),
        titleMedium: TextStyle(
          fontSize: 26.0,
          fontFamily: family,
          fontWeight: FontWeight.w500,
          color: ColorsManager.onSecondaryLight,
        ),
        titleSmall: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.textPrimaryBlue,
        ),
        labelLarge: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.textPrimaryBlue,
        ),
        displaySmall: TextStyle(
          fontSize: 20.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.onSecondaryLight,
        ),
        displayMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.onSecondaryLight,
        ),
        displayLarge: TextStyle(
          fontSize: 16.0,
          fontFamily: family,
          fontWeight: FontWeight.w400,
          color: ColorsManager.textPrimaryBlue,
        ),
        bodySmall: TextStyle(
          fontSize: 13.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.textPrimaryBlue,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          fontFamily: family,
          fontWeight: FontWeight.w500,
          color: ColorsManager.secondaryContainerLight,
        ),
        bodyLarge: TextStyle(
          fontSize: 19.0,
          fontFamily: family,
          fontWeight: FontWeight.w600,
          color: ColorsManager.textPrimaryBlue,
        ),
      ),
    );
  }

  void setTranslation({
    required String translation,
  }) {
    LanguageManager.translationModel =
        TranslationModel.fromJson(jsonDecode(translation));

    emit(LanguageLoaded());
  }

  String languageCode = 'en';
  void changeLanguage({
    required String code,
  }) async {
    debugPrint(code);

    if (code == 'ar') {
      isArabic = true;
    } else {
      isArabic = false;
    }

    sl<CacheHelper>().put('isRtl', isArabic);

    String translation = await rootBundle
        .loadString('assets/translations/${isArabic ? 'ar' : 'en'}.json');

    changeTheme();

    setTranslation(
      translation: translation,
    );

    emit(ChangeLanguage());
  }


  bool isAppConnected = true;

  void connectivityListener() async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        isAppConnected = true;
      } else {
        isAppConnected = false;
      }
      debugPrint('isAppConnected: $isAppConnected');
      emit(ConnectivityChanged());
    }).onError(
          (error) {
        log(error.toString());
        emit(ConnectivityChangedError());
      },
    );
  }



  IconData visibilityShowPassword = Icons.visibility_outlined;
  bool showPassword = true;

  void changePasswordVisibility(){
    showPassword = !showPassword;
    visibilityShowPassword = showPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  IconData visibilityShowConfirmPassword = Icons.visibility_outlined;
  bool showConfirmPassword = true;

  void changeConfirmPasswordVisibility(){
    showConfirmPassword = !showConfirmPassword;
    visibilityShowConfirmPassword = showConfirmPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeConfirmPasswordVisibilityState());
  }


}
