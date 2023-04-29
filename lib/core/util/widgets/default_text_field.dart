import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final String hint;
  final bool disabled;
  final EdgeInsetsGeometry margin;
  final Widget? suffixIcon;
  final Color? colorPrefixIcon;
  final IconData? iconPrefix;
  final String? svgImg;
  final bool isPassword;
  final bool showSuffix;
  final String? Function(String?)? validate;
  final Function(String?)? onChanged;
  final TextInputAction textInputAction;
  final TextInputType type;
  final VoidCallback? onSubmit;
  final TextStyle? hintStyle;
  final Color? textFormFillColor;
  final int? maxLines;
  final VoidCallback? onTap;

  const DefaultTextField({
    required this.controller,
    this.label,
    this.onChanged,
    this.svgImg,
    this.type = TextInputType.text,
    required this.hint,
    this.validate,
    this.disabled = false,
    this.margin = const EdgeInsets.only(bottom: 16),
    this.isPassword = false,
    this.suffixIcon,
    this.iconPrefix,
    this.onSubmit,
    this.colorPrefixIcon,
    this.textInputAction = TextInputAction.next,
    this.hintStyle,
    this.textFormFillColor = Colors.black12,
    this.showSuffix = false,
    this.maxLines = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: margin,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 20.rSp,vertical: 5.rSp),
      decoration: BoxDecoration(
        color: textFormFillColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        keyboardType: type,
        textInputAction: textInputAction,
        readOnly: disabled,
        obscureText:isPassword,
        onTap: onTap,
        onEditingComplete: onSubmit,
        style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontFamily: 'english',
            fontSize: 14.rSp
        ),
        maxLines: maxLines,
        onChanged: onChanged,
        validator: validate,
        controller: controller,
        autocorrect: true,
        cursorColor: ColorsManager.mainColor,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: svgImg != null
              ? Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              svgImg!,
              height: 24,
              width: 24,
              // fit: BoxFit.scaleDown,
            ),
          )
              : null,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          hintText: hint,
          hintStyle: hintStyle,
        ),
      ),
    );
  }
}
