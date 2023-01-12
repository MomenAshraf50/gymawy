import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_previewer/file_previewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/features/home/data/models/search_model.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/presentation/screens/qr_code/qr_code_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../login/presentation/screens/login_screen.dart';
import '../../domain/entities/certificate_entity.dart';
import '../../domain/entities/search_entity.dart';
import '../../domain/usecase/certification_usecase.dart';
import '../../domain/usecase/profile_usecase.dart';
import '../../domain/usecase/search_usecase.dart';
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

  HomeCubit({
    required UpdateProfilePicture updateProfilePicture,
    required UpdateProfile updateProfile,
    required UpdateCoachSocialLinks updateCoachSocialLinks,
    required SearchUseCase searchUseCase,
    required ProfileUseCase profileUseCase,
    required CertificateUseCase certificateUseCase,
    required GetCertificateUseCase getCertificateUseCase,
  })  : _updateProfilePicture = updateProfilePicture,
        _updateProfile = updateProfile,
        _updateCoachSocialLinks = updateCoachSocialLinks,
        _searchUseCase = searchUseCase,
        _profileUseCase = profileUseCase,
        _certificateUseCase = certificateUseCase,
        _getCertificateUseCase = getCertificateUseCase,
        super(HomeInitialState());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Widget> clientWidgets = [
    const HomeClientScreen(),
    const SearchScreen(),
    const QRCodescreen(),
    SettingsScreen(),
    ClientProfileScreen(),
  ];

  List<Widget> coachWidgets = [
    const HomeClientScreen(),
    const SearchScreen(),
    SettingsScreen(),
    const ProfileCoachScreen(),
  ];

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
      title: AppString.clients,
      img: Assets.images.svg.clients,
    ),
    Suggestions(
      title: AppString.clientProgress,
      img: Assets.images.svg.clients,
    ),
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

  bool? isVisibilityPlanIcon = false;

  void visibilityPlan() {
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

  TextEditingController nameOfPlanController = TextEditingController();

  TextEditingController certificateNameController = TextEditingController();
  String? year;
  String? month;
  String? day;

  File? exerciseImageFile;
  File? mealImageFile;
  File? profileImageFile;
  File? certificationImageFile;

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
    profileImageFile = await pickImageFromGallery(context);
    emit(HomePlansImageSelectedState());
  }

  void selectMealImage(context) async {
    mealImageFile = await pickImageFromGallery(context);
    emit(HomePlansImageSelectedState());
  }

  void selectProfileImage(context) async {
    profileImageFile = await pickImageFromGallery(context);
    updateCoachProfilePicture(image: profileImageFile!);
    emit(HomePlansImageSelectedState());
  }

  void selectCertificationImage(context) async {
    certificationImageFile = await pickImageFromGallery(context);
    emit(HomePlansImageSelectedState());
  }

  late VideoPlayerController videoPlayerController;

  void initializeVideoPlayerController() {
    videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
    videoPlayerController.initialize().then((value) {
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

  void updateCoachProfile({
    required String userName,
    required String email,
    required String password,
    required String phone,
    required String firstName,
    required String lastName,
    required String fullName,
    required double fixedPrice,
    required String bio,
  }) async {
    emit(UpdateCoachLoadingState());
    final result = await _updateProfile(UpdateProfileParams(
      email: email,
      userName: userName,
      password: password,
      phone: phone,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      bio: bio,
      fixedPrice: fixedPrice,
    ));

    result.fold((failure) {
      debugPrintFullText(
          '++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
      emit(UpdateCoachErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateCoachSuccessState(data));
    });
  }

  void updateCoachProfilePicture({required File image}) async {
    emit(UpdateCoachLoadingState());
    final result =
        await _updateProfilePicture(UpdateProfilePictureParams(image: image));
    result.fold((failure) {
      emit(UpdateCoachErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateCoachSuccessState(data));
    });
  }

  void updateCoachSocialLinks({
    required facebookLink,
    required instagramLink,
    required tiktokLink,
    required youtubeLink,
  }) async {
    emit(UpdateCoachLoadingState());
    final result = await _updateCoachSocialLinks(UpdateCoachSocialLinksParams(
      facebookLink: facebookLink,
      instagramLink: instagramLink,
      tiktokLink: tiktokLink,
      youtubeLink: youtubeLink,
    ));

    result.fold((failure) {
      emit(UpdateCoachErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(UpdateCoachSuccessState(data));
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

  void profile({required String id, context}) async {
    emit(ProfileLoadingState());

    final result = await _profileUseCase(ProfileParams(
      id: id,
    ));

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
      {
      required String id,
      required String certificateName,
      required FilePickerResult certificateFile,
      required String certificateDate,
      context}) async {
    emit(CertificationLoadingState());
    final result = await _certificateUseCase(CertificateParams(
      id: id,
      certificateName: certificateName,
      certificateFile: certificateFile,
      certificateDate: certificateDate,
    ));
    result.fold((failure) {
      emit(CertificationErrorState(mapFailureToMessage(failure)));
    }, (data) {
      emit(CertificationSuccessState(data));
    });
  }

  List<CertificateEntity>? certificateResult;
  Widget? certificateResultImg;

  void getCertificates(GetCertificateParams params, index) async {
    emit(GetCertificateLoadingState());
    final result = await _getCertificateUseCase(params);
    result.fold((failure) {
      emit(GetCertificateErrorState(mapFailureToMessage(failure)));
    }, (data) async {
      emit(GetCertificateSuccessState(data));
      certificateResult = data;
    });
  }

  void convertCertificateToImg(index)
  async
  {
    certificateResultImg = await FilePreview.getThumbnail(certificateResult![index].certificateFile);
    emit(ConvertCertificateToImgState());
  }

}

class Suggestions extends Equatable {
  final String img;
  final String title;

  const Suggestions({required this.img, required this.title});

  @override
  List<Object?> get props => [img, title];
}
