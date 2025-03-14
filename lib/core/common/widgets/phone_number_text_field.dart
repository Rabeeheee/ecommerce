import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_haven/core/utils/auth_utils.dart';
import 'package:tech_haven/core/validators/validators.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/user/features/auth/presentation/widgets/country_code_container.dart';

class PhoneNumberTextField extends StatelessWidget {
  const PhoneNumberTextField({
    super.key,
    required this.countryCode,
    required this.textFormFieldEnabled,
    required this.phoneNumberController,
     this.errorText,
  });
  final String? errorText;
  final ValueNotifier<String> countryCode;
  final bool textFormFieldEnabled;
  final TextEditingController phoneNumberController;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // the container for selecting the counctry code
        ValueListenableBuilder(
          valueListenable: countryCode,
          builder: (context, value, child) {
            return CountryCodeContainer(
              enabled: textFormFieldEnabled,
              countryCode: countryCode.value,
              onTap: () {
                AuthUtils.changeCountryCode(context, countryCode);
              },
            );
          },
        ),
        //phone number field
        Expanded(
          child: CustomTextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            errorText: errorText,
            enabled: textFormFieldEnabled,
            textEditingController: phoneNumberController,
            labelText: 'Phone Number',
            hintText: '1234567890',
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: Validator.validatePhoneNumber,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
