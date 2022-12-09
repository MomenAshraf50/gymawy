import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/cubit/cubit.dart';
import 'package:gymawy/core/util/cubit/state.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';

class myTextField extends StatelessWidget {
  myTextField({
    Key? key,
    required this.controller,
    required this.text,
    this.validate,
    this.onChanged,
    this.iconPrefix,
    this.readOnly = false,
    this.enabled = true,
    this.isPassword = false,
    this.onSubmit,
    this.colorPrefixIcon,
    this.isBoarder = false,
    this.type = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.iconSuffix,
    this.showSuffix = false
  }) : super(key: key);

  final TextEditingController controller;
  final Function(String val)? onChanged;
  final IconData? iconPrefix;
  final bool? readOnly;
  final bool? enabled;
  final Color? colorPrefixIcon;
  final ValueChanged<String>? onSubmit;
  final TextInputType type;
  final bool isPassword;
  final Widget? iconSuffix;
  final String text;
  final TextInputAction? textInputAction;
  final bool isBoarder;
  final bool showSuffix;
  String? Function(String?)? validate;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        AppBloc appBloc = AppBloc.get(context);
        return TextFormField(
            onFieldSubmitted: onSubmit,
            controller: controller,
            maxLines: 1,
            onChanged: onChanged,
            keyboardType: type,
            enabled: enabled!,
            readOnly: readOnly!,
            validator: validate,
            textInputAction: textInputAction,
            obscureText: appBloc.showPassword,
            decoration: InputDecoration(
              labelText: text,
              border: isBoarder
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
// color: HexColor(redColor),
                        width: 2,
                      ),
                    )
                  : null,
              prefixIcon: Icon(
                iconPrefix,
                color: colorPrefixIcon ?? ColorsManager.mainColor,
              ),
              hintText: text,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
              suffixIcon: showSuffix
                  ? IconButton(
                      onPressed: () {
                        appBloc.changePasswordVisibility();
                      },
                      icon: Icon(appBloc.visibilityShowPassword))
                  : null,
            ));
      },
    );
  }
}
