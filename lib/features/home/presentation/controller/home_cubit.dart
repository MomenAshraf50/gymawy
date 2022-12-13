import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/settings/settings_screen.dart';
import 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  Object sl=GetIt.instance();

  List<Widget> widgets =
  [
    const HomeClientScreen(),
    const SearchScreen(),
    const SettingsScreen(),
    const ProfileScreen(),
  ];

  TextEditingController searchController = TextEditingController();
  int selected = 0;
  List<Suggestions> listSuggestions = [
    Suggestions(
      title: AppString.plans,
      img: Assets.images.svg.plans,
    ),
    Suggestions(
      title: AppString.exercise,
      img: Assets.images.svg.exercise,
    ),
    Suggestions(
      title: AppString.clients,
      img: Assets.images.svg.clients,
    ),
  ];



  bool isCompleted = false;
  void changeCompleted()
  {
    isCompleted = !isCompleted;

    emit(ChangeCompletedState());
  }

  int currentNavIndex = 0;

  bool coachRadioButton = false;
  bool clientRadioButton = false;
  void changeToCoachRadioButton()
  {
    coachRadioButton = !coachRadioButton;
    clientRadioButton = false;
    emit(ChangeCoachRadioButtonState());
  }

  void changeToClientRadioButton()
  {
    coachRadioButton = false;
    clientRadioButton = !clientRadioButton;
    emit(ChangeClientRadioButtonState());
  }

  bool? isVisibilityPlanIcon = false;
  void visibilityPlan()
  {
    isVisibilityPlanIcon = !isVisibilityPlanIcon!;
    emit(ChangeVisibilityPlanState());
  }


  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController instagramLinkController = TextEditingController();
  TextEditingController tiktokLinkController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();


  TextEditingController usernameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

}

class Suggestions extends Equatable {
  final String img;
  final String title;

  const Suggestions(
      {required this.img, required this.title});

  @override
  List<Object?> get props => [img, title];
}