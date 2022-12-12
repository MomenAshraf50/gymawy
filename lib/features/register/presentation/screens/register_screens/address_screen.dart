import 'dart:convert';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/myElevatedButton.dart';
import 'package:gymawy/core/util/widgets/my_icon_button.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/set_your_location.dart';


class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<String> listCountry = [];
  List<String> listCity = [];
  var myData;
  late RegisterCubit cubit;
  bool changeCity = false;

  @override
  void initState() {
    cubit = context.read<RegisterCubit>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: readJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: const LoadingPage(),
          );
        } else {
          return StatefulBuilder(
            builder: (context, setState) => Padding(
              // Padding(
              padding: designApp,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    svgImage(path: Assets.images.svg.location),
                    Align(
                      alignment: Alignment.centerRight,
                      child: DefaultIconButton(
                          icon: const Icon(Icons.add_location_alt_outlined),
                          onPressed: ()
                          {
                            navigateTo(context,  SetYourLocation());
                          }
                      ),
                    ),
                    verticalSpace(5.h),
                    CustomDropdown.search(
                      hintText: AppString.select_country,
                      items: listCountry,
                      controller: countryController,
                      onChanged: (value) {
                        setState(() {
                          changeCity = false;
                          getCities(value);
                        });
                      },
                    ),
                    verticalSpace(5.h),
                    if (listCity.isNotEmpty)
                      CustomDropdown.search(
                        hintText: AppString.select_city,
                        items: listCity,
                        controller: cityController,
                        onChanged: (value) {
                          setState(() {
                            changeCity = true;
                          });


                        },
                      ),
                    verticalSpace(5.h),
                    myElevatedButton(
                        text: AppString.next,
                        onPressed: changeCity ? () => cubit.nextPage(true, context) : null),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> readJson() async {
    var snapshot = await DefaultAssetBundle.of(context)
        .loadString('assets/json/new_json.json');
    myData = await json.decode(snapshot);
    myData.keys.forEach((key) {
      listCountry.add(key);
    });
  }

  Future<void> getCities(String txt) async {
    listCity.clear();
    await myData[txt].forEach((element) {
      listCity.add(element);
    });
    cityController.text = '';
  }
}
