import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';

class ViewCertification extends StatelessWidget {
  ViewCertification({Key? key , required this.certification, required this.certificationName}) : super(key: key);
  String? certification;
  String? certificationName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: designApp,
        child: Column(
          children: [
            defaultAppBar(
                title: certificationName!,
                context: context
            ),
            verticalSpace(5.h),
          Expanded(
            child: const PDF(
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: false,
        ).cachedFromUrl(
              certification!,
              placeholder: (double progress) => Center(child: Text('$progress %')),
              errorWidget: (dynamic error) => Center(child: Text(error.toString())),
        ),
          ),
          ],
        ),
      ),
    );
  }
}
