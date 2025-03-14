import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';

class AuthUtils {
  // this is for the notifying the change in the country picker
  static ValueNotifier<String> signUpCountryCode = ValueNotifier('000');
  static ValueNotifier<String> signInCountryCode = ValueNotifier('000');
  static ValueNotifier<String> forgotPasswordCountryCode = ValueNotifier('000');

  CurrencyService currencyService = CurrencyService();

  Country? country;
//choosing the country code
  static void changeCountryCode(
      BuildContext context, ValueNotifier<String> valueNotifier) {
    showCountryPicker(
        exclude: [],
        // searchAutofocus: true,
        context: context,
        showPhoneCode: true,
        countryListTheme: const CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
          bottomSheetHeight: 500, // Optional. Country list modal height

          //Optional. Sets the border radius for the bottomsheet.
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45),
            topRight: Radius.circular(45),
          ),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
              labelText: 'Search',
              hintText: 'Start typing to search',
              prefixIcon: Icon(Icons.search),
              border: UnderlineInputBorder()),
        ),
        onSelect: (Country country) {
          valueNotifier.value = country.phoneCode;
        });
  }

//for extracting the name from the email entered by the user
  static String extractNameFromEmail(String email) {
    // Split the email address by the "@" symbol
    List<String> parts = email.split("@");

    // If the email has parts before and after the "@" symbol
    if (parts.length == 2) {
      // Return the part before the "@" symbol
      // print(parts[0]);
      return parts[0];
    } else {
      // Return the full email address if "@" symbol is not found
      return email;
    }
  }
}
