import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/register/presentation/controller/register_states.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/address_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/complete_profile_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/create_account_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/goal_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/select_fat_screen.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/social_media_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/remote/location_service.dart';
import '../../../../core/util/resources/appString.dart';
import '../../../../core/util/resources/assets.gen.dart';
import '../../../../core/util/resources/goal_data_static.dart';
import '../../../../core/util/widgets/myText.dart';
import '../../domain/usecase/register_usecase.dart';

class RegisterCubit extends Cubit<RegisterStates>{
  final RegisterUseCase _registerUseCase;
  RegisterCubit({required RegisterUseCase registerUseCase,
  })
      : _registerUseCase = registerUseCase,
        super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isCoach = false;
  int currentNavIndex = 0;
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController userFirstNameController = TextEditingController();
  TextEditingController userLastNameController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userAgeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController pricePerMonth = TextEditingController();
  TextEditingController dataOfBirth = TextEditingController();
  TextEditingController currentWeightController = TextEditingController();
  TextEditingController currentTallController = TextEditingController();
  bool isMoneyEmpty = true;


  Future selectType({required bool isCoach}) async {
    this.isCoach = isCoach;
    isCoachRegister = isCoach;
    emit(RegisterChangeTypeState());
  }
 late List<Widget> pagesClint = [
     CreateAccountScreen(),
     CompleteProfileScreen(),
     const AddressScreen(),
     const SelectFatScreen(),
     const GoalScreen(),
  ];

  late List<Widget> pagesCoach = [
    CreateAccountScreen(),
    CompleteProfileScreen(),
    const AddressScreen(),
    const SocialMediaScreen(),
  ];

  int selectedPage = 0;
  int currentIndex = 0;
  PageController pageController = PageController();
  void bottomChanged(
      int index,
      context
      ){
    currentNavIndex = index;
    pageController.jumpToPage(index);
    emit(RegisterBottomChangedState());
  }

  Future<void> nextPage(bool isNext,BuildContext context) async {
    isNext ? currentIndex++ : currentIndex--;
    await changePage(currentIndex,context);
    emit(RegisterChangePageState());
  }

  Future<void> changePage(int index,BuildContext context) async {
    currentIndex = index;
    if (index >= 0) {
      if (pageController.hasClients) {
        await pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease);
      }
    } else {
      Navigator.pop(context);
    }
    emit(RegisterChangePageState());
  }

  bool isPasswordEightCharacters = false;
  bool isPasswordHasSpecialCharacter = false;
  bool isPasswordHasUpperAndLower = false;
  bool isPasswordNotMach = false;

  matchPassword() {
    if (passwordController.text == confirmPasswordController.text) {
      isPasswordNotMach = true;
    } else {
      isPasswordNotMach = false;
    }
    emit(RegisterMatchPasswordState());
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
    emit(RegisterPasswordChangedState());
  }

  bool isPasswordValid() {
    return isPasswordEightCharacters &&
        isPasswordHasSpecialCharacter &&
        isPasswordHasUpperAndLower;
  }

  bool isPasswordMach() {
    return passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        !isPasswordNotMach;
  }

  String changeDateFormat(DateTime value){
    emit(RegisterChangeDateFormatState());
    return DateFormat.yMMMd().format(value);
  }

  bool changeMoney(bool isEmpty){
    if(isEmpty){
      emit(RegisterChangeMoneyState());
      return false;
    }else{
      emit(RegisterChangeMoneyState());
      return true;
    }

  }
  void changeSelectedPage(int index){
    selectedPage = index;
    emit(RegisterChangeSelectedPageCreateAccountScreen());
  }

  File? imageFile;

  Future<File?> pickImageFromGallery(BuildContext context) async {
    File? image;
    try {
      final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        image = File(pickedImage.path);
        emit(RegisterImagePickedSuccessState());
      }
    } catch (e) {
      designToastDialog(context: context, toast: TOAST.error);
      emit(RegisterImagePickedErrorState());
    }
    return image;
  }

  void selectImage(context) async {
    imageFile = await pickImageFromGallery(context);
    emit(RegisterImageSelectedState());
  }

  bool isAccept = false;

  void changeRadioButton(){
    isAccept = !isAccept;
    emit(RegisterChangeRadioButtonState());
}

  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<String> listCountry = [];
  List<String> listCity = [];
  dynamic myData;
  bool changeCity = false;


  Future<void> readJson(context) async {
    var snapshot = await DefaultAssetBundle.of(context)
        .loadString('assets/json/new_json.json');
    myData = await json.decode(snapshot);
    myData.keys.forEach((key) {
      listCountry.add(key);
    });
    emit(RegisterGetCountryState());
  }

  Future<void> getCities(String txt) async {
    listCity.clear();
    await myData[txt].forEach((element) {
      listCity.add(element);
    });
    cityController.text = '';
    emit(RegisterGetCitiesState());
  }

  double fatValue = 0;

  List<String> listFat = [
    Assets.images.fat.fat1,
    Assets.images.fat.fat2,
    Assets.images.fat.fat3,
    Assets.images.fat.fat4,
    Assets.images.fat.fat5,
  ];

  void changeFatValue(double fat){
    fatValue = fat;
    emit(RegisterGetFatTextState());
  }

  PageController pageFatController = PageController(viewportFraction: 1/2,);
  Future<void> changeFatPage(index) async {
    await pageFatController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease);
    emit(RegisterPageFatControllerState());
  }

  myText getText(int val) {
    switch (val) {
      case 0:
        emit(RegisterGetFatTextState());
        return const myText(title:'3 - 7 ', style: Style.medium);
      case 1:
        emit(RegisterGetFatTextState());
        return const myText(title:'8 - 16', style: Style.medium);
      case 2:
        emit(RegisterGetFatTextState());
        return const myText(title:'17 - 24', style: Style.medium);
      case 3:
        emit(RegisterGetFatTextState());
        return const myText(title:'24 - 32', style: Style.medium);
      case 4:
        emit(RegisterGetFatTextState());
        return const myText(title:'32+', style: Style.medium);
      default:
        return const myText(title:'', style: Style.medium);
    }

  }

  int selected = 0;

  List<GoalDataStatic> listGoal = [
    GoalDataStatic(
      body: AppString.lean_tone_title,
      title: AppString.lean_tone,
      img: Assets.images.lotti.coach,
    ),
    GoalDataStatic(
      body: AppString.lose_title,
      title: AppString.lose,
      img: Assets.images.lotti.running,
    ),
    GoalDataStatic(
      body: AppString.improve_title,
      title: AppString.improve,
      img: Assets.images.lotti.jumpRope,
    ),
  ];



  TextEditingController facebookController = TextEditingController();
  TextEditingController instagramController  = TextEditingController();
  TextEditingController youtubeController  = TextEditingController();
  TextEditingController tiktokController  = TextEditingController();


  //RegisterModel? registerModel;
  void registerClient({
    required String email,
    required String password,
    required String bio,
    required String city,
    required String confirmPassword,
    required String country,
    required String firstName,
    required String fullName,
    required String gander,
    required String governorate,
    required String lastName,
    required String phoneNumber,
    required File profilePicture,
    required String userName,
    int? bodyFat,
    int? currentWeight,
    int? currentTall,
    int? fixedPrice,
    String? age,
    String? facebookLink,
    String? instagramLink,
    String? youTubeLink,
    String? tikTokLink,
    context
  }) async {
    emit(RegisterLoadingState());
    final result = await _registerUseCase(
        isCoachRegister == false ?
        RegisterParams(
      userName: userName,
      firstName: firstName,
      lastName: lastName,
      fullName: fullName,
      email: email,
      profilePicture: profilePicture,
      bio: '',
      phoneNumber: phoneNumber,
      gander: gander,
      country: country,
      governorate: governorate,
      city: city,
      password: password,
      confirmPassword: confirmPassword,
      age: age!,
      currentWeight: currentWeight!,
      currentTall: currentTall!,
      bodyFat: bodyFat!,
      fixedPrice: 0,
      instagramLink: '',
      tikTokLink: '',
      youTubeLink: '',
      facebookLink: '',
    ) :
        RegisterParams(
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          fullName: fullName,
          email: email,
          profilePicture: profilePicture,
          bio: '',
          phoneNumber: phoneNumber,
          gander: gander,
          country: country,
          governorate: governorate,
          city: '',
          password: password,
          confirmPassword: confirmPassword,
          fixedPrice: fixedPrice!,
          facebookLink: facebookLink!,
          youTubeLink: youTubeLink!,
          tikTokLink: tikTokLink!,
          instagramLink: instagramLink!,
          age: '',
          bodyFat: 0,
          currentTall: 0,
          currentWeight: 0,
        )
    );

    result.fold((failure) {
      emit(RegisterErrorState(
          failure: mapFailureToMessage(failure)
      ));
      debugPrintFullText('Error is ----------------------------- ${failure.toString()}');
    }, (data) {
      //registerModel = data;
      emit(RegisterSuccessState(
          token: data.token
      ));
      imageFile = null;
      emailController.text = '';
      currentTallController.text = '';
      currentWeightController.text = '';
      dataOfBirth.text = '';
      pricePerMonth.text = '';
      currencyController.text = '';
      genderController.text = '';
      confirmPasswordController.text = '';
      passwordController.text = '';
      phoneController.text = '';
      userAgeController.text = '';
      fullNameController.text = '';
      userLastNameController.text = '';
      userFirstNameController.text = '';
      userNameController.text = '';
      facebookController.text = '';
      instagramController.text  = '';
      youtubeController.text  = '';
      tiktokController.text  = '';
      cityController.text = '';
      countryController.text = '';
    });
  }


  late GoogleMapController googleMapController;
  //final LatLng center = LatLng(currentLat!, currentLng!);
  Completer<GoogleMapController> mapController = Completer();
  final searchLocation = TextEditingController();

  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  // void getPlaceId(
  // {
  //   String? input
  // })
  // {
  //   LocationService().getPlaceId(
  //       input!
  //   );
  //   emit(GetLocationIdState());
  // }

  void goToLocation(
      double lat,
      double lng,
      Map<String,dynamic> boundsNe,
      Map<String,dynamic> boundsSw,
      BuildContext context,
      )async{
    currentLat = lat;
    currentLng = lng;

    debugPrintFullText('laaaaaaaaaaaaaaaaat is $currentLat');
    debugPrintFullText('lnnnnnnnnnnnnnnnnng is $currentLng');


    final GoogleMapController locationMapController = await mapController.future;
    locationMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentLat!, currentLng!),
          zoom: 15,
        ),
      ),
    );

    locationMapController.animateCamera(
        CameraUpdate.newLatLngBounds(
            LatLngBounds(
              southwest: LatLng(boundsSw['lat'],boundsSw['lng'],),
              northeast: LatLng(boundsNe['lat'],boundsNe['lng'],),
            ),
            10.rSp
        )
    );

    setMarker(LatLng(currentLat!, currentLng!));

    emit(GoToLocationState());
  }

  Set<Marker> markers = <Marker>{};
  void setMarker (LatLng point)
  {
    markers.add(
      Marker(
        markerId: const MarkerId('marker'),
        position: point,
        icon: BitmapDescriptor.defaultMarker,
        //LatLng(latLocationSearch!,lngLocationSearch!),
      ),
    );
    emit(SetMarkerState());
  }


  getPlace(
      double? lat ,
      double? lng ,
      )
  async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      lat!,
      lng!,
    );
    debugPrintFullText(placeMarks.toString());
    Placemark placeMark = placeMarks[0];
    currentCountry = '${placeMark.country}';
    currentCity = '${placeMark.subAdministrativeArea}';
    currentGovernment = '${placeMark.administrativeArea}';
  }


  // void goToLocation(
  //     double lat,
  //     double lng,
  //     Map<String,dynamic> boundsNe,
  //     Map<String,dynamic> boundsSw,
  //     BuildContext context,
  //     )async{
  //   // double lat = location['geometry']['location']['lat'];
  //   // double lng = location['geometry']['location']['lng'];
  //   currentLat = lat;
  //   currentLng = lng;
  //
  //   debugPrintFullText('laaaaaaaaaaaaaaaaat is $currentLat');
  //   debugPrintFullText('lnnnnnnnnnnnnnnnnng is $currentLng');
  //
  //
  //   final GoogleMapController locationMapController = await mapController.future;
  //   locationMapController.animateCamera(
  //     CameraUpdate.newCameraPosition(
  //       CameraPosition(
  //         target: LatLng(lat, lng),
  //         zoom: 15,
  //       ),
  //     ),
  //   );
  //
  //   locationMapController.animateCamera(
  //       CameraUpdate.newLatLngBounds(
  //           LatLngBounds(
  //             southwest: LatLng(boundsSw['lat'],boundsSw['lng'],),
  //             northeast: LatLng(boundsNe['lat'],boundsNe['lng'],),
  //           ),
  //         10.rSp
  //       )
  //   );
  //
  //
  //   setMarker(LatLng(currentLat!, currentLng!));
  //
  //   emit(GoToLocationState());
  // }
  //
  // Set<Marker> markers = <Marker>{};
  // void setMarker (LatLng point)
  // {
  //   markers.add(
  //     Marker(
  //       markerId: const MarkerId('marker'),
  //       position: point,
  //       icon: BitmapDescriptor.defaultMarker,
  //     ),
  //   );
  //   emit(SetMarkerState());
  // }





// String? city;
    // String? country;
    // String? government;
    // void getAddressFromLatLng()
    // async {
    //
    //   country = '${placeMark.country}';
    //   city = '${placeMark.administrativeArea}';
    //   city = '${placeMark.name}';
    // }

}