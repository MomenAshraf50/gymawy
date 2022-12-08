import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:lottie/lottie.dart';


// if (snapshot.connectionState == ConnectionState.waiting) {
// return const LoadingPage();
// }

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Lottie.asset(
          Assets.images.lotti.loading,
          ),
        );
  }
}
