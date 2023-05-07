import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/domain/entities/exercise_details_entity.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_details.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_nutrition_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_user_plan_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_coach_subscriptions_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_notifications_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_subscriptions_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_user-plan_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/mark_as_read_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/notifications_subscription_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/subscription_request_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_subscription_status_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/user_plan_usecase.dart';
import 'package:gymawy/features/home/presentation/screens/qr_code/qr_code_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../login/presentation/screens/login_screen.dart';
import '../../domain/entities/add_exercise_entity.dart';
import '../../domain/entities/add_exercise_plan_entity.dart';
import '../../domain/entities/add_nutrition_details_entity.dart';
import '../../domain/entities/add_nutrition_entity.dart';
import '../../domain/entities/certificate_entity.dart';
import '../../domain/entities/search_entity.dart';
import '../../domain/usecase/add_nutrition_details_usecase.dart';
import '../../domain/usecase/add_nutrition_usecase.dart';
import '../../domain/usecase/add_plan_usecase.dart';
import '../../domain/usecase/certification_usecase.dart';
import '../../domain/usecase/delete_certification_usecase.dart';
import '../../domain/usecase/delete_exercise_details_usecase.dart';
import '../../domain/usecase/delete_exersice_plan_usecase.dart';
import '../../domain/usecase/delete_subscriptionRequest_usecase.dart';
import '../../domain/usecase/get_exercise_plan_details.dart';
import '../../domain/usecase/get_nutrition_details.dart';
import '../../domain/usecase/get_nutrition_usecase.dart';
import '../../domain/usecase/get_plan_usecase.dart';
import '../../domain/usecase/get_exercise_usecase.dart';
import '../../domain/usecase/profile_usecase.dart';
import '../../domain/usecase/search_usecase.dart';
import '../../domain/usecase/update_exercise_plan_usecase.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_client_screen.dart';
import '../screens/profile/profile_coach_screen.dart';
import '../screens/search/search_screen.dart';
import '../screens/settings/settings_screen.dart';
import 'home_states.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';

class HomeCubit extends Cubit<HomeStates> {
  final UpdateProfilePicture _updateProfilePicture;
  final UpdateProfile _updateProfile;
  final UpdateCoachSocialLinks _updateCoachSocialLinks;
  final SearchUseCase _searchUseCase;
  final ProfileUseCase _profileUseCase;
  final CertificateUseCase _certificateUseCase;
  final GetCertificateUseCase _getCertificateUseCase;
  final DeleteCertificateUseCase _deleteCertificateUseCase;
  final UpdateCertificateUseCase _updateCertificateUseCase;
  final AddExerciseUseCase _addExerciseUseCase;
  final GetExerciseUseCase _getExerciseUseCase;
  final UpdateExerciseUseCase _updateExerciseUseCase;
  final DeleteExerciseUseCase _deleteExerciseUseCase;
  final AddExercisePlanUseCase _addExercisePlanUseCase;
  final GetPlanUseCase _getExercisePlanUseCase;
  final UpdateExercisePlanUseCase _updateExercisePlanUseCase;
  final DeleteExercisePlanUseCase _deleteExercisePlanUseCase;
  final AddExerciseDetailsUseCase _addExerciseDetailsUseCase;
  final GetExercisePlanDetailsUseCase _getExercisePlanDetailsUseCase;
  final DeleteExercisePlanDetailsUseCase _deleteExercisePlanDetailsUseCase;
  final AddNutritionUseCase _addNutritionUseCase;
  final GetNutritionUseCase _getNutritionUseCase;
  final DeleteNutritionUseCase _deleteNutritionUseCase;
  final AddNutritionDetailsUseCase _addNutritionDetailsUseCase;
  final GetNutritionPlanDetailsUseCase _getNutritionPlanDetailsUseCase;
  final SubscriptionRequestUseCase _subscriptionRequestUseCase;
  final GetSubscriptionUseCase _getSubscriptionUseCase;
  final DeleteSubscriptionRequestUseCase _deleteSubscriptionRequestUseCase;
  final GetNotificationsUseCase _getNotificationsUseCase;
  final MarkAsReadUseCase _markAsReadUseCase;
  final GetCoachSubscriptionsUseCase _getCoachSubscriptionsUseCase;
  final UpdateSubscriptionStatusUseCase _updateSubscriptionStatusUseCase;
  final NotificationsSubscriptionUseCase _notificationsSubscriptionUseCase;
  final BodyMeasurementsUseCase _bodyMeasurementsUseCase;
  final GetBodyMeasurementsUseCase _getBodyMeasurementsUseCase;
  final DeleteBodyMeasurementsUseCase _deleteBodyMeasurementsUseCase;
  final UserPlanUseCase _userPlanUseCase;
  final GetUserPlanUseCase _getUserPlanUseCase;
  final DeleteUserPlanUseCase _deleteUserPlanUseCase;

  HomeCubit({
    required UpdateProfilePicture updateProfilePicture,
    required UpdateProfile updateProfile,
    required UpdateCoachSocialLinks updateCoachSocialLinks,
    required SearchUseCase searchUseCase,
    required ProfileUseCase profileUseCase,
    required CertificateUseCase certificateUseCase,
    required GetCertificateUseCase getCertificateUseCase,
    required DeleteCertificateUseCase deleteCertificateUseCase,
    required UpdateCertificateUseCase updateCertificateUseCase,
    required AddExerciseUseCase addExerciseUseCase,
    required GetExerciseUseCase getExerciseUseCase,
    required UpdateExerciseUseCase updateExerciseUseCase,
    required DeleteExerciseUseCase deleteExerciseUseCase,
    required AddExercisePlanUseCase addExercisePlanUseCase,
    required GetPlanUseCase getExercisePlanUseCase,
    required UpdateExercisePlanUseCase updateExercisePlanUseCase,
    required DeleteExercisePlanUseCase deleteExercisePlanUseCase,
    required AddExerciseDetailsUseCase addExerciseDetailsUseCase,
    required GetExercisePlanDetailsUseCase getExercisePlanDetailsUseCase,
    required DeleteExercisePlanDetailsUseCase deleteExercisePlanDetailsUseCase,
    required AddNutritionUseCase addNutritionUseCase,
    required GetNutritionUseCase getNutritionUseCase,
    required DeleteNutritionUseCase deleteNutritionUseCase,
    required AddNutritionDetailsUseCase addNutritionDetailsUseCase,
    required GetNutritionPlanDetailsUseCase getNutritionPlanDetailsUseCase,
    required SubscriptionRequestUseCase subscriptionRequestUseCase,
    required GetSubscriptionUseCase getSubscriptionUseCase,
    required DeleteSubscriptionRequestUseCase deleteSubscriptionRequestUseCase,
    required GetNotificationsUseCase getNotificationsUseCase,
    required MarkAsReadUseCase markAsReadUseCase,
    required GetCoachSubscriptionsUseCase getCoachSubscriptionsUseCase,
    required UpdateSubscriptionStatusUseCase updateSubscriptionStatusUseCase,
    required NotificationsSubscriptionUseCase notificationsSubscriptionUseCase,
    required BodyMeasurementsUseCase bodyMeasurementsUseCase,
    required GetBodyMeasurementsUseCase getBodyMeasurementsUseCase,
    required DeleteBodyMeasurementsUseCase deleteBodyMeasurementsUseCase,
    required UserPlanUseCase userPlanUseCase,
    required GetUserPlanUseCase getUserPlanUseCase,
    required DeleteUserPlanUseCase deleteUserPlanUseCase,
  })  : _updateProfilePicture = updateProfilePicture,
        _updateProfile = updateProfile,
        _updateCoachSocialLinks = updateCoachSocialLinks,
        _searchUseCase = searchUseCase,
        _profileUseCase = profileUseCase,
        _certificateUseCase = certificateUseCase,
        _getCertificateUseCase = getCertificateUseCase,
        _deleteCertificateUseCase = deleteCertificateUseCase,
        _updateCertificateUseCase = updateCertificateUseCase,
        _addExerciseUseCase = addExerciseUseCase,
        _getExerciseUseCase = getExerciseUseCase,
        _updateExerciseUseCase = updateExerciseUseCase,
        _deleteExerciseUseCase = deleteExerciseUseCase,
        _addExercisePlanUseCase = addExercisePlanUseCase,
        _getExercisePlanUseCase = getExercisePlanUseCase,
        _updateExercisePlanUseCase = updateExercisePlanUseCase,
        _deleteExercisePlanUseCase = deleteExercisePlanUseCase,
        _addExerciseDetailsUseCase = addExerciseDetailsUseCase,
        _getExercisePlanDetailsUseCase = getExercisePlanDetailsUseCase,
        _deleteExercisePlanDetailsUseCase = deleteExercisePlanDetailsUseCase,
        _addNutritionUseCase = addNutritionUseCase,
        _getNutritionUseCase = getNutritionUseCase,
        _deleteNutritionUseCase = deleteNutritionUseCase,
        _addNutritionDetailsUseCase = addNutritionDetailsUseCase,
        _getNutritionPlanDetailsUseCase = getNutritionPlanDetailsUseCase,
        _subscriptionRequestUseCase = subscriptionRequestUseCase,
        _getSubscriptionUseCase = getSubscriptionUseCase,
        _deleteSubscriptionRequestUseCase = deleteSubscriptionRequestUseCase,
        _getNotificationsUseCase = getNotificationsUseCase,
        _markAsReadUseCase = markAsReadUseCase,
        _getCoachSubscriptionsUseCase = getCoachSubscriptionsUseCase,
        _updateSubscriptionStatusUseCase = updateSubscriptionStatusUseCase,
        _notificationsSubscriptionUseCase = notificationsSubscriptionUseCase,
        _bodyMeasurementsUseCase = bodyMeasurementsUseCase,
        _getBodyMeasurementsUseCase = getBodyMeasurementsUseCase,
        _deleteBodyMeasurementsUseCase = deleteBodyMeasurementsUseCase,
        _userPlanUseCase = userPlanUseCase,
        _getUserPlanUseCase = getUserPlanUseCase,
        _deleteUserPlanUseCase = deleteUserPlanUseCase,
        super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> clientWidgets = [
    const HomeClientScreen(),
    SearchScreen(),
    const QRCodescreen(),
    SettingsScreen(),
    ClientProfileScreen(),
  ];

  List<Widget> coachWidgets = [
    const HomeClientScreen(),
    SearchScreen(),
    SettingsScreen(),
    const ProfileCoachScreen(),
  ];

  int initialTabIndex = 0;

  //
  // List<Widget> widgets =
  //     isCoachLogin == false ?  [
  //     const HomeClientScreen(),
  //     const SearchScreen(),
  //     const QRCodescreen(),
  //     SettingsScreen(),
  //     ClientProfileScreen(),
  //     ] :
  //     [
  //       const HomeClientScreen(),
  //       const SearchScreen(),
  //       SettingsScreen(),
  //       const ProfileCoachScreen(),
  //     ];

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
      title: AppString.nutrition,
      img: Assets.images.svg.meal,
    ),
    if (isCoachLogin == true)
      Suggestions(
        title: AppString.clients,
        img: Assets.images.svg.clients,
      ),
    if (isCoachLogin == true)
      Suggestions(
        title: AppString.clientProgress,
        img: Assets.images.svg.clients,
      ),
    if (isCoachLogin == false)
      Suggestions(
        title: AppString.workoutTracker,
        img: Assets.images.svg.clients,
      )
  ];

  bool isCompleted = false;

  void changeCompleted() {
    isCompleted = !isCompleted;

    emit(ChangeCompletedState());
  }

  int currentNavIndex = 0;

  void changeNavBottomScreens(int index) {
    currentNavIndex = index;
    emit(HomeChangeNavBottomScreensState());
  }

  bool coachRadioButton = false;
  bool clientRadioButton = false;

  void changeToFirstChoiceRadioButton() {
    coachRadioButton = !coachRadioButton;
    clientRadioButton = false;
    isCoachFilter = coachRadioButton;
    emit(ChangeFirstChoiceRadioButtonState());
  }

  void changeToSecondChoiceRadioButton() {
    coachRadioButton = false;
    clientRadioButton = !clientRadioButton;
    isCoachFilter = false;
    emit(ChangeSecondChoiceRadioButtonState());
  }

  // bool? isVisibilityPlanIcon = false;
  //
  // // void visibilityPlan() {
  // //   isVisibilityPlanIcon = !isVisibilityPlanIcon!;
  // //   emit(ChangeVisibilityPlanState());
  // // }

  TextEditingController facebookLinkController = TextEditingController();
  TextEditingController instagramLinkController = TextEditingController();
  TextEditingController tiktokLinkController = TextEditingController();
  TextEditingController youtubeLinkController = TextEditingController();

  TextEditingController usernameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fixedPriceController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController nameOfPlanController = TextEditingController();

  TextEditingController certificateNameController = TextEditingController();
  TextEditingController certificateSerialController = TextEditingController();
  TextEditingController certificateDescriptionController =
      TextEditingController();
  TextEditingController certificateDateController = TextEditingController();
  TextEditingController certificateExpirationDateController =
      TextEditingController();

  TextEditingController supportTextController = TextEditingController();

  String? year;
  String? month;
  String? day;
  String? certificateDate;

  File? exerciseImageFile;
  File? mealImageFile;
  File? profileImageFile;
  File? certificationImageFile;

  bool isPasswordEightCharacters = false;
  bool isPasswordHasSpecialCharacter = false;
  bool isPasswordHasUpperAndLower = false;
  bool isPasswordMatch = false;

  matchPassword() {
    if (passwordController.text == confirmPasswordController.text) {
      isPasswordMatch = true;
    } else {
      isPasswordMatch = false;
    }
    emit(EditProfileMatchPasswordState());
  }

  onPasswordChanged(String password) {
    final upperLower = RegExp(r"(?=.*[a-z])(?=.*[A-Z])\w+");
    final specialCharacter = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    isPasswordEightCharacters = false;
    if (password.length >= 8) isPasswordEightCharacters = true;

    isPasswordHasUpperAndLower = false;
    if (upperLower.hasMatch(password)) isPasswordHasUpperAndLower = true;

    isPasswordHasSpecialCharacter = false;
    if (specialCharacter.hasMatch(password)) {
      isPasswordHasSpecialCharacter = true;
    }
    emit(EditProfilePasswordChangedState());
  }

  bool isPasswordValid() {
    return isPasswordEightCharacters &&
        isPasswordHasSpecialCharacter &&
        isPasswordHasUpperAndLower;
  }

  bool isPasswordMach() {
    return passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        isPasswordMatch;
  }

  Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
        emit(HomeExerciseImagePickedSuccessState());
      }
    } catch (e) {
      designToastDialog(context: context, toast: TOAST.error);
      emit(HomeExerciseImagePickedErrorState());
    }
    return image;
  }

  void selectExerciseImage(context) async {
    exerciseImageFile = await pickImageFromGallery(context);
    emit(HomePlansImageSelectedState());
  }

  void selectMealImage(context) async {
    mealImageFile = await pickImageFromGallery(context);
    emit(HomePlansImageSelectedState());
  }

  void selectProfileImage(context) async {
    profileImageFile = await pickImageFromGallery(context);
    updateProfilePicture(image: profileImageFile!);
    emit(HomePlansImageSelectedState());
  }

  void selectCertificationImage(context) async {
    certificationImageFile = await pickImageFromGallery(context);
    emit(HomePlansImageSelectedState());
  }

  late VideoPlayerController videoPlayerController;

  void initializeVideoPlayerController({
    required String video,
  }) async {
    videoPlayerController = VideoPlayerController.network(
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
      video,
      //videoPlayerOptions: VideoPlayerOptions(mixWithOthers: false,allowBackgroundPlayback: true),
    );
    await videoPlayerController.initialize().then((value) {
      emit(HomeExerciseExampleVideoPlayerInitialized());
    });
  }

  void pauseAndPlayVideo() {
    videoPlayerController.value.isPlaying
        ? videoPlayerController.pause()
        : videoPlayerController.play();
    emit(ExerciseExamplePauseAndPlayVideoState());
  }

  int currentStep = 0;

  void changeStep(int index) {
    currentStep = index;
    emit(ChangeCurrentStepState());
  }

  void signOut(context) {
    sl<CacheHelper>().clear('isCoach');
    sl<CacheHelper>().clear('token').then((value) {
      if (value) {
        token = null;
        profileResults = null;
        navigateAndFinish(
          context,
          LoginScreen(),
        );
        emit(SignOutState());
        //Restart.restartApp();
      }
    });
  }

  void updateProfile({
    required String userName,
    required String email,
    String? password,
    required String phone,
    required String firstName,
    required String lastName,
    required double fixedPrice,
    required String bio,
  }) async {
    emit(UpdateLoadingState());
    final result = await _updateProfile(UpdateProfileParams(
      lastName: lastName,
      email: email,
      userName: userName,
      password: password,
      phone: phone,
      firstName: firstName,
      bio: bio,
      fixedPrice: fixedPrice,
    ));

    result.fold((failure) {
      debugPrintFullText(
          '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      emit(UpdateErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateSuccessState(data));
    });
  }

  void updateProfilePicture({required File image}) async {
    emit(UpdateLoadingState());
    final result =
        await _updateProfilePicture(UpdateProfilePictureParams(image: image));
    result.fold((failure) {
      emit(UpdateErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateSuccessState(data));
    });
  }

  void updateCoachSocialLinks({
    required facebookLink,
    required instagramLink,
    required tiktokLink,
    required youtubeLink,
  }) async {
    emit(UpdateLoadingState());
    final result = await _updateCoachSocialLinks(UpdateCoachSocialLinksParams(
      facebookLink: facebookLink,
      instagramLink: instagramLink,
      tiktokLink: tiktokLink,
      youtubeLink: youtubeLink,
    ));

    result.fold((failure) {
      emit(UpdateErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateSuccessState(data));
    });
  }

  // SearchEntity? name;
  List<SearchEntity>? results;

  void search({
    required search,
  }) async {
    emit(SearchLoadingState());
    final result = await _searchUseCase(SearchParams(
      search: search,
    ));

    result.fold((failure) {
      emit(SearchErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(SearchSuccessState(
        data,
      ));
      results = data;
    });
  }

  ProfileEntity? profileResults;

  void profile({required int id, bool? isCoach, context}) async {
    emit(ProfileLoadingState());

    final result =
        await _profileUseCase(ProfileParams(id: id, isCoach: isCoach));

    result.fold((failure) {
      emit(ProfileErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(ProfileSuccessState(data));
      profileResults = data;
    });
  }

  FilePickerResult? certificationPdf;
  Widget? certificationImage;

  void selectCertificationPdf() async {
    certificationPdf = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
      ],
    );
    //certificationImage = await FilePreview.getThumbnail(certificationPdf!.files.first.path!);
    final file = certificationPdf!.files.first;
    debugPrintFullText('NAme: ${file.name}');
    debugPrintFullText('NAme: ${file.size}');
    debugPrintFullText('NAme: ${file.bytes}');
    debugPrintFullText('NAme: ${file.extension}');
    debugPrintFullText('NAme: ${file.path}');
    emit(PickCertificationPdf());
  }

  void certificate(
      {required String id,
      required String certificateName,
      required FilePickerResult certificateFile,
      required String certificateDate,
      required String certificateSerial,
      required String certificateDescription,
      required String certificateExpirationDate,
      context}) async {
    emit(CertificationLoadingState());
    final result = await _certificateUseCase(CertificateParams(
      id: id,
      certificateName: certificateName,
      certificateFile: certificateFile,
      certificateDate: certificateDate,
      certificateSerial: certificateSerial,
      certificateDescription: certificateDescription,
      certificateExpirationDate: certificateExpirationDate,
    ));
    result.fold((failure) {
      emit(CertificationErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(CertificationSuccessState(data));
    });
  }

  List<CertificateEntity> certificateResult = [];
  Widget? certificateResultImg;

  void getCertificates(GetCertificateParams params) async {
    certificateResult = [];
    emit(GetCertificateLoadingState());
    final result = await _getCertificateUseCase(params);
    result.fold((failure) {
      emit(GetCertificateErrorState(mapFailureToMessage(failure)));
    }, (data) async {
      emit(GetCertificateSuccessState(data));
      certificateResult = data;
    });
  }

  void convertCertificateToImg(index) async {
    certificateResultImg = await FilePreview.getThumbnail(
        certificateResult[index].certificateFile);
    emit(ConvertCertificateToImgState());
  }

  void deleteCertificate({required int certificateId, context}) async {
    emit(DeleteCertificateLoadingState());
    final result = await _deleteCertificateUseCase(
        DeleteCertificateParams(certificateId: certificateId));
    result.fold((failure) {
      emit(DeleteCertificateErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(DeleteCertificateSuccessState());
    });
  }

  void updateCertificate(UpdateCertificateParams params) async {
    emit(UpdateCertificateLoadingState());

    final result = await _updateCertificateUseCase(params);

    result.fold((failure) {
      emit(UpdateCertificateErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateCertificateSuccessState(data));
    });
  }

  bool? isVisibilityExerciseIcon = false;
  String visibilityExerciseValue = 'private';

  void visibilityExercise() {
    isVisibilityExerciseIcon = !isVisibilityExerciseIcon!;
    isVisibilityExerciseIcon == true
        ? visibilityExerciseValue = 'public'
        : visibilityExerciseValue = 'private';
    debugPrintFullText('isVisibilityExerciseIcon is $isVisibilityExerciseIcon');
    debugPrintFullText('visibilityExerciseValue is $visibilityExerciseValue');
    emit(ChangeVisibilityExerciseState());
  }

  List<DropdownMenuItem<String>> get exerciseItems {
    List<DropdownMenuItem<String>> menuItems = const [
      DropdownMenuItem(
          value: "Abs",
          child: DefaultText(title: "Abs", style: Style.extraSmall)),
      DropdownMenuItem(
          value: "core",
          child: DefaultText(title: "core", style: Style.extraSmall)),
      DropdownMenuItem(
          value: "Chest",
          child: DefaultText(title: "Chest", style: Style.extraSmall)),
      DropdownMenuItem(
          value: "back",
          child: DefaultText(title: "back", style: Style.extraSmall)),
      DropdownMenuItem(
          value: "Shoulder",
          child: DefaultText(title: "Shoulder", style: Style.extraSmall)),
      DropdownMenuItem(
          value: "Arms",
          child: DefaultText(title: "Arms", style: Style.extraSmall)),
      DropdownMenuItem(
          value: "Legs",
          child: DefaultText(title: "Legs", style: Style.extraSmall)),
    ];
    emit(ExerciseItemsState());
    return menuItems;
  }

  List<DropdownMenuItem<String>>? exerciseValue = const [
    DropdownMenuItem(
        value: "Abs",
        child: DefaultText(title: "Abs", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "core",
        child: DefaultText(title: "core", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Chest",
        child: DefaultText(title: "Chest", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "back",
        child: DefaultText(title: "back", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Shoulder",
        child: DefaultText(title: "Shoulder", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Arms",
        child: DefaultText(title: "Arms", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Legs",
        child: DefaultText(title: "Legs", style: Style.extraSmall)),
  ];

  void pickExercise() {
    exerciseValue;
    emit(ExerciseItemsState());
  }

  String selectedValue = 'Abs';

  String selectedDay = 'D1';

  List<DropdownMenuItem<String>>? daysValue = const [
    DropdownMenuItem(
        value: "D1",
        child: DefaultText(title: "Day 1", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "D2",
        child: DefaultText(title: "Day 2", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "D3",
        child: DefaultText(title: "Day 3", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "D4",
        child: DefaultText(title: "Day 4", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "D5",
        child: DefaultText(title: "Day 5", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "D6",
        child: DefaultText(title: "Day 6", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "D7",
        child: DefaultText(title: "Day 7", style: Style.extraSmall)),
  ];

  String selectedNutritionValue = 'Carbohydrates';

  List<DropdownMenuItem<String>>? selectedNutritionCat = const [
    DropdownMenuItem(
        value: "Carbohydrates",
        child: DefaultText(title: "Carbohydrates", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Proteins",
        child: DefaultText(title: "Proteins", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Fats",
        child: DefaultText(title: "Fats", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Minerals",
        child: DefaultText(title: "Minerals", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Dietary fibre",
        child: DefaultText(title: "Dietary fibre", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Fruit",
        child: DefaultText(title: "Fruit", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Salad vegetables",
        child: DefaultText(title: "Salad vegetables", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Cooked vegetables",
        child:
            DefaultText(title: "Cooked vegetables", style: Style.extraSmall)),
  ];

  String selectedMealValue = 'Breakfast';

  List<DropdownMenuItem<String>>? selectedMeal = const [
    DropdownMenuItem(
        value: "Breakfast",
        child: DefaultText(title: "Breakfast", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Snack",
        child: DefaultText(title: "Snack", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Lunch",
        child: DefaultText(title: "Lunch", style: Style.extraSmall)),
    DropdownMenuItem(
        value: "Dinner",
        child: DefaultText(title: "Dinner", style: Style.extraSmall)),
  ];

  void changeDropDownSelectedValue(String value) {
    selectedValue = value;
    emit(ChangeDropDownSelectedValueState());
  }

  void changeDropDownSelectedMeal(String value) {
    selectedMealValue = value;
    emit(ChangeDropDownSelectedValueState());
  }

  void changeDropDownSelectedDay(String value) {
    selectedDay = value;
    emit(ChangeDropDownSelectedValueState());
  }

  void changeDropDownSelectedNutritionCValue(String value) {
    selectedNutritionValue = value;
    emit(ChangeDropDownSelectedValueState());
  }

  FilePickerResult? exerciseVideo;
  Widget? exercisePreVideo;

  void selectExerciseVideo() async {
    exerciseVideo = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: [
        'mkv',
        'webm',
        'flv',
        'vob',
        'ogv',
        'ogg',
        'ogg',
        'avi',
        'M2TS',
        'TS',
        'mov',
        'qt',
        'wmv',
        'yuv',
        'rm',
        'rmvb',
        'viv',
        'asf',
        'amv',
        'mp4',
        'm4p',
        'mpg',
        'mp2',
        'mpeg',
        'mpv',
        'mpg',
        'm2v',
        'm4v',
        'svi',
        '3gp',
        '3g2',
        'mxf',
        'roq',
        'nsv',
        'f4v',
        'f4p',
        'f4a',
        'f4b',
      ],
    );
    final file = exerciseVideo!.files.first;
    debugPrintFullText('NAme: ${file.name}');
    debugPrintFullText('NAme: ${file.size}');
    debugPrintFullText('NAme: ${file.bytes}');
    debugPrintFullText('NAme: ${file.extension}');
    debugPrintFullText('NAme: ${file.path}');
    emit(PickExerciseVideoState());
  }

  void addExercise({
    required String exerciseName,
    required String exerciseCategory,
    required String exerciseVisibility,
    required File exercisePic,
    required FilePickerResult exerciseVideo,
    required BuildContext context,
  }) async {
    emit(AddExerciseLoadingState());

    final result = await _addExerciseUseCase(AddExerciseParams(
        exerciseName: exerciseName,
        exerciseCategory: exerciseCategory,
        exerciseVisibility: exerciseVisibility,
        exercisePic: exercisePic,
        exerciseVideo: exerciseVideo,
        context: context));

    result.fold((failure) {
      emit(AddExerciseErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(AddExerciseSuccessState(data));
    });
  }

  int countProgressValue = 0;
  int totalProgressValue = 0;
  late StreamController<double> progressController = StreamController<double>();
  late Stream<double> progressStream = progressController.stream;

  void changeProgressValue({required progressValue, required totalValue}) {
    countProgressValue = progressValue;
    totalProgressValue = totalValue;
    progressController.add(((countProgressValue / totalProgressValue) * 100));
  }

  void getProgressValue() {}

  List<AddExerciseEntity>? exerciseResult;

  void getExercise({String? searchExercise}) async {
    emit(GetExerciseLoadingState());

    final result = await _getExerciseUseCase(
        GetExerciseParams(searchExercise: searchExercise));

    result.fold((failure) {
      emit(GetExerciseErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetExerciseSuccessState(data));
      exerciseResult = data;
    });
  }

  void updateExercise(AddExerciseParams params) async {
    emit(UpdateExerciseLoadingState());

    final result = await _updateExerciseUseCase(params);

    result.fold((failure) {
      emit(UpdateExerciseErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateExerciseSuccessState(data));
    });
  }

  void deleteExercise(DeleteExerciseParams params) async {
    emit(DeleteExerciseLoadingState());

    final result = await _deleteExerciseUseCase(params);

    result.fold((failure) {
      emit(DeleteExerciseErrorState(mapFailureToMessage(failure)));
    }, (r) {
      emit(DeleteExerciseSuccessState());
    });
  }

  void addPlan({
    required bool isNutrition,
    required String planName,
    required String planVisibility,
  }) async {
    emit(AddPlanLoadingState());

    final result = await _addExercisePlanUseCase(AddPlanParams(
      isNutrition: isNutrition,
      planName: planName,
      planVisibility: planVisibility,
    ));

    result.fold((failure) {
      emit(AddPlanErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(AddPlanSuccessState(data));
    });
  }

  List<AddPlanEntity>? planResult;

  void getPlan({
    String? searchPlan,
    required bool isNutrition,
  }) async {
    planResult = null;
    emit(GetExercisePlanLoadingState());

    final result = await _getExercisePlanUseCase(GetPlanParams(
      searchPlan: searchPlan,
      isNutrition: isNutrition,
    ));

    result.fold((failure) {
      emit(GetExercisePlanErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetExercisePlanSuccessState(data));
      planResult = data;
    });
  }

  void updatePlan(
      {required String planName,
      required String planVisibility,
      required int planId,
      required bool isNutrition}) async {
    emit(UpdatePlanLoadingState());

    final result = await _updateExercisePlanUseCase(AddPlanParams(
      isNutrition: isNutrition,
      planName: planName,
      planVisibility: planVisibility,
      exercisePlanId: planId,
    ));

    result.fold((failure) {
      emit(UpdatePlanErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdatePlanSuccessState(data));
    });
  }

  void deletePlan(DeletePlanParams params) async {
    emit(DeleteExercisePlanLoadingState());

    final result = await _deleteExercisePlanUseCase(params);

    result.fold((failure) {
      emit(DeleteExercisePlanErrorState(mapFailureToMessage(failure)));
    }, (r) {
      emit(DeleteExercisePlanSuccessState());
    });
  }

  ExerciseDetailsEntity? exerciseDetailsEntity;

  void addExerciseDetails(ExerciseDetailsParams params) async {
    emit(AddExerciseDetailsLoadingState());

    final result = await _addExerciseDetailsUseCase(params);

    result.fold((failure) {
      emit(AddExerciseDetailsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      exerciseDetailsEntity = data;
      emit(AddExerciseDetailsSuccessState());
    });
  }

  List<ExerciseDetailsEntity>? exerciseDetailsResult;

  void getExercisePlanDetails(int exercisePlanId) async {
    emit(GetExerciseDetailsLoadingState());
    exerciseDetailsResult = [];

    final result = await _getExercisePlanDetailsUseCase(
        GetExercisePlanDetailsParams(exercisePlanId));

    result.fold((failure) {
      emit(GetExerciseDetailsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetExerciseDetailsSuccessState(data));
      exerciseDetailsResult = data;
    });
  }

  void deleteExercisePlanDetails(DeleteExercisePlanDetailsParams params) async {
    emit(DeleteExercisePlanDetailsLoadingState());

    final result = await _deleteExercisePlanDetailsUseCase(params);

    result.fold((failure) {
      emit(DeleteExercisePlanDetailsErrorState(mapFailureToMessage(failure)));
    }, (r) {
      emit(DeleteExercisePlanDetailsSuccessState());
    });
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Share Gymmawy',
        text: 'Share Gymmawy',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Share link via');
  }

  List? component;
  List? quantity;

  void components(Map componentNutrition) {
    component = componentNutrition.keys.toList();
    quantity = componentNutrition.values.toList();
    emit(ComponentsStates());
  }

  void addNutrition({
    int? nutritionId,
    required bool update,
    required double calories,
    required double carb,
    required double fat,
    required double protein,
    required String nutritionName,
    required String nutritionCategory,
    required String nutritionVisibility,
    File? nutritionPic,
    String? howToPrepare,
    required Map component,
  }) async {
    emit(AddNutritionLoadingState());

    final result = await _addNutritionUseCase(AddNutritionParams(
      nutritionId: nutritionId,
      update: update,
      calories: calories,
      carb: carb,
      fat: fat,
      protein: protein,
      nutritionName: nutritionName,
      nutritionPic: nutritionPic,
      nutritionCategory: nutritionCategory,
      nutritionVisibility: nutritionVisibility,
      component: component,
      howToPrepare: howToPrepare,
    ));

    result.fold((failure) {
      emit(AddNutritionErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(AddNutritionSuccessState(data));
    });
  }

  List<AddNutritionEntity>? nutritionResult;

  void getNutrition({String? search}) async {
    emit(GetNutritionLoadingState());

    final result = await _getNutritionUseCase(GetNutritionParams(
      searchNutrition: search,
    ));

    result.fold((failure) {
      emit(GetNutritionErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetNutritionSuccessState(data));
      nutritionResult = data;
    });
  }

  void deleteNutrition(DeleteNutritionParams params) async {
    emit(DeleteNutritionLoadingState());

    final result = await _deleteNutritionUseCase(params);

    result.fold((failure) {
      emit(DeleteNutritionErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(DeleteNutritionSuccessState());
    });
  }

  void addNutritionDetails(NutritionDetailsParams params) async {
    emit(AddNutritionDetailsLoadingState());

    final result = await _addNutritionDetailsUseCase(params);

    result.fold((failure) {
      emit(AddNutritionDetailsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(AddNutritionDetailsSuccessState());
    });
  }

  void getNutritionPlanDetails(int nutritionPlanId) async {
    emit(GetNutritionDetailsLoadingState());

    final result = await _getNutritionPlanDetailsUseCase(
        GetNutritionPlanDetailsParams(nutritionPlanId));

    result.fold((failure) {
      emit(GetNutritionDetailsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetNutritionDetailsSuccessState(data));
    });
  }

  void subscriptionRequest(SubscriptionRequestParams params) async {
    emit(SubscriptionRequestLoadingState());
    final result = await _subscriptionRequestUseCase(params);

    result.fold((failure) {
      emit(SubscriptionRequestErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(SubscriptionRequestSuccessState(data));
    });
  }

  void getSubscriptionRequests(GetSubscriptionsRequestsParams params) async {
    emit(GetSubscriptionRequestLoadingState());
    final result = await _getSubscriptionUseCase(params);

    result.fold((failure) {
      emit(GetSubscriptionRequestErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetSubscriptionRequestSuccessState(data));
    });
  }

  void deleteSubscriptionRequest(DeleteSubscriptionRequestParams params) async {
    emit(DeleteSubscriptionRequestLoadingState());

    final result = await _deleteSubscriptionRequestUseCase(params);

    result.fold((failure) {
      emit(DeleteSubscriptionRequestErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(DeleteSubscriptionRequestSuccessState());
    });
  }

  void getNotifications() async {
    emit(GetNotificationsLoadingState());
    final result = await _getNotificationsUseCase(NoParams());

    result.fold((failure) {
      emit(GetNotificationsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetNotificationsSuccessState(data));
    });
  }

  void markAsRead(MarkAsReadParams params) async {
    emit(MarkAsReadLoadingState());

    final result = await _markAsReadUseCase(params);

    result.fold((failure) {
      emit(MarkAsReadErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(MarkAsReadSuccessState());
    });
  }

  void getCoachSubscriptions() async {
    emit(GetCoachSubscriptionsLoadingState());

    final result = await _getCoachSubscriptionsUseCase(NoParams());

    result.fold((failure) {
      emit(GetCoachSubscriptionsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetCoachSubscriptionsSuccessState(data));
    });
  }

  void updateSubscriptionStatus(UpdateSubscriptionStatusParams params) async {
    emit(UpdateSubscriptionStatusLoadingState());

    final result = await _updateSubscriptionStatusUseCase(params);

    result.fold((failure) {
      emit(UpdateSubscriptionStatusErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateSubscriptionStatusSuccessState(data));
    });
  }

  void notificationsSubscription(NotificationsSubscriptionParams params) async {
    emit(NotificationsSubscriptionLoadingState());
    final result = await _notificationsSubscriptionUseCase(params);

    result.fold((failure) {
      emit(NotificationsSubscriptionErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(NotificationsSubscriptionSuccessState());
    });
  }

  void bodyMeasurements(BodyMeasurementsParams params) async {
    emit(BodyMeasurementsLoadingState());
    final result = await _bodyMeasurementsUseCase(params);

    result.fold((failure) {
      emit(BodyMeasurementsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(BodyMeasurementsSuccessState(data));
    });
  }

  void getBodyMeasurements(GetBodyMeasurementsParams params) async {
    emit(GetBodyMeasurementsLoadingState());
    final result = await _getBodyMeasurementsUseCase(params);

    result.fold((failure) {
      emit(GetBodyMeasurementsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetBodyMeasurementsSuccessState(data));
    });
  }

  void deleteBodyMeasurements() async {
    emit(DeleteBodyMeasurementsLoadingState());
    final result = await _deleteBodyMeasurementsUseCase(NoParams());

    result.fold((failure) {
      emit(DeleteBodyMeasurementsErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(DeleteBodyMeasurementsSuccessState());
    });
  }

  void userPlan(UserPlanParams params) async {
    emit(UserPlanLoadingState());
    final result = await _userPlanUseCase(params);

    result.fold((failure) {
      emit(UserPlanErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UserPlanSuccessState(data));
    });
  }

  void getUserPlan() async {
    emit(GetUserPlanLoadingState());
    final result = await _getUserPlanUseCase(NoParams());

    result.fold((failure) {
      emit(GetUserPlanErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(GetUserPlanSuccessState(data));
    });
  }

  void deleteUserPlan(DeleteUserPlanParams params) async {
    emit(DeleteUserPlanLoadingState());
    final result = await _deleteUserPlanUseCase(params);

    result.fold((failure) {
      emit(DeleteUserPlanErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(DeleteUserPlanSuccessState());
    });
  }

  Future<void> launch(Uri link) async {
    await launchUrl(
      link,
      mode: LaunchMode.externalApplication,

    ).catchError((error) {
      throw Exception(error);
    });
  }
}

class Suggestions extends Equatable {
  final String img;
  final String title;

  const Suggestions({required this.img, required this.title});

  @override
  List<Object?> get props => [img, title];
}
