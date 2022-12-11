import 'dart:convert';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/myElevatedButton.dart';
import 'package:gymawy/core/util/widgets/my_icon_button.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:gymawy/features/register/presentation/screens/register_screens/set_your_location.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({Key? key}) : super(key: key);
  dynamic data;
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  List<String> listCountry = [];
  List<String> listCity = [];
  bool changeCity = false;

  @override
  Widget build(BuildContext context) {

    RegisterCubit registerCubit = RegisterCubit.get(context);

    return FutureBuilder(
      future: readJson(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: LoadingPage(),
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
                    verticalSpace(20.h),
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
                    verticalSpace(10.h),
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
                    verticalSpace(10.h),
                    myElevatedButton(
                        text: AppString.next,
                        onPressed: changeCity ? () => registerCubit.nextPage(true, context) : null),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );

  }
  Future<void> readJson(BuildContext context) async {
    var snapshot = await DefaultAssetBundle.of(context)
        .loadString('assets/json/new_json.json');
    data = await json.decode(snapshot);
    data.keys.forEach((key) {
      listCountry.add(key);
    });
  }

  Future<void> getCities(String txt) async {
    listCity.clear();
    await data[txt].forEach((element) {
      listCity.add(element);
    });
    cityController.text = '';
  }

}
