import 'package:flutter/material.dart';

class BaseTextfield extends StatelessWidget {
  final double? width;
  final TextEditingController? controller;
  final String? labelText;
  final EdgeInsets? padding;
  final void Function(String)? onChanged;
  final void Function()? onFieldTapped;
  final String? forceErrorText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? initialValue;

  /// This is our basic textfield widget that we will use in our reusable widgets with variations in our app.
  ///
  /// It is a wrapper for the [TextFormField] widget.
  ///
  /// If [width] parameter is used to set a fixed width for the textfield.
  /// If you want to use all the [width] available space, set it to null and play with
  /// the [padding] parameter to set a space between the textfield and other widgets.
  ///
  /// The [labelText] parameter is used to show a label above the textfield.
  ///
  /// The [forceErrorText] parameter is used to show an error message below the textfield and trigger
  /// the error animation.
  const BaseTextfield({
    super.key,
    this.obscureText = false,
    this.suffixIcon,
    this.onFieldTapped,
    this.width,
    this.controller,
    this.labelText,
    this.initialValue,
    this.padding,
    this.onChanged,
    this.forceErrorText,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: padding,
      child: TextSelectionTheme(
        data: TextSelectionThemeData(),
        child: TextFormField(
          initialValue: initialValue,
          controller: controller,
          onTap: onFieldTapped,
          cursorHeight: 20.0,
          keyboardType: keyboardType,
          cursorOpacityAnimates: true,
          onChanged: onChanged,
          // We could need this events if we need to do something special
          // when the user tap outside of the textfield.
          // onTapUpOutside: (event) {
          //   log("tap up outside");
          // },
          // onTapOutside: (event) {
          //   log("tap outside");
          // },
          forceErrorText: forceErrorText,
          obscureText: obscureText,
          decoration: InputDecoration(
            errorMaxLines: 2,
            labelText: labelText,
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 121, 38, 38),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            floatingLabelStyle: const TextStyle(
              color: Color.fromARGB(255, 121, 38, 38),
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            filled: true,
            // fillColor: appColors.secondaryColor.withValues(alpha: 0.1),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color.fromARGB(122, 121, 38, 38),

                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16.0),
            ),
            errorBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: AppColors.warning, width: 1.5),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: AppColors.warning, width: 1.5),
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      ),
    );
  }
}
