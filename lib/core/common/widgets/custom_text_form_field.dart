import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/validators/validators.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? errorText;
  final String hintText;
  final bool isObscureText;
  final TextEditingController? textEditingController;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final TextInputType? keyboardType;
  final void Function()? suffixOnTap;
  final bool isPasswordField;
  final bool enabled;
  final void Function(String)? onChanged;
  final int durationMilliseconds;
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.onChanged,
    this.errorText,
    required this.hintText,
    this.isObscureText = false,
    this.inputFormatters,
    required this.textEditingController,
    this.validator = Validator.validateEmptyField,
    this.autovalidateMode,
    this.keyboardType = TextInputType.text,
    this.suffixOnTap,
    this.isPasswordField = false,
    this.enabled = true,
    this.durationMilliseconds = 1500,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: Duration(milliseconds: durationMilliseconds),
      curve: Curves.easeIn,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextFormField(
            
            onChanged: onChanged,
            enabled: enabled,
            controller: textEditingController,
            autovalidateMode: autovalidateMode,
            keyboardType: keyboardType,
            validator: validator,
            obscureText: isPasswordField ? isObscureText : false,
            inputFormatters: inputFormatters,
            style: const TextStyle(fontSize: 16),
            decoration: InputDecoration(
              errorText: errorText,
              contentPadding: const EdgeInsets.only(top: 5),
              errorStyle: const TextStyle(
                fontSize: 10,
                overflow: TextOverflow.visible,
              ),
              errorMaxLines: 3,
              labelText: labelText,
              labelStyle: const TextStyle(),
              hintStyle: const TextStyle(color: AppPallete.greyTextColor),
              hintText: hintText,
              suffix: isPasswordField
                  ? InkWell(
                      onTap: suffixOnTap,
                      child: isObscureText
                          ? const Icon(
                              Icons.remove_red_eye,
                              color: AppPallete.greyTextColor,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: AppPallete.primaryAppColor,
                            ),
                    )
                  : null,
            ),
          )
        ],
      ),
    );
  }
}
