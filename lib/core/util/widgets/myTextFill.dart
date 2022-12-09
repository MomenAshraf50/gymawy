import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';

class myTextFill extends StatelessWidget {
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
  final String? Function(String?)? validate;
  final Function(String?)? onChanged;
  final TextInputAction textInputAction;
  final TextInputType type;
  final ValueChanged<String>? onSubmit;
  final TextStyle? hintStyle;
  final Color? textFormFillColor;

  const myTextFill({
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
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 14, right: 14, top: 4),
        margin: margin,
        decoration: BoxDecoration(
          color: textFormFillColor,
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(width: 1, color: ColorManager().darkColor),
        ),
        child: TextFormField(
          keyboardType: type,
          textInputAction: textInputAction,
          readOnly: disabled,
          obscureText: isPassword,
          style: Theme.of(context).textTheme.displaySmall,
          maxLines: 1,
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
                : Icon(iconPrefix,
                    color: colorPrefixIcon ?? ColorsManager.iconColor),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: InputBorder.none,

            hintText: hint,
            hintStyle: hintStyle,
          ),

          // label: Text(
          //   widget.label,
          //   style: TextStyle(
          //     color: ColorManager().darkColor,
          //     fontSize: 14,
          //   ),
          // ),
        ),
      ),
    );
  }
}
