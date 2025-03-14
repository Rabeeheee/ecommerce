// import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
// import 'package:country_picker/country_picker.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/common/widgets/profile_image_widget.dart';
import 'package:tech_haven/core/routes/app_route_constants.dart';
import 'package:tech_haven/core/utils/get_random_color.dart';
import 'package:tech_haven/core/utils/pick_image.dart';
// import 'package:tech_haven/core/utils/pick_image.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tech_haven/user/features/auth/presentation/bloc/sign_up_welcome_page.dart';
// import 'dart:typed_data';
// import 'dart:io';
import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

class SignUpWelcomePage extends StatelessWidget {
  final String initialUsername;

  const SignUpWelcomePage({super.key, required this.initialUsername});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<Currency?> currentCurrency = ValueNotifier(null);
    ValueNotifier<String> username = ValueNotifier(initialUsername);
    ValueNotifier<dynamic> image = ValueNotifier(null);
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
    ];

    void selectImage() async {
      if (kIsWeb) {
        final pickedImageInWeb = await pickImageForWeb();
        if (pickedImageInWeb != null) {
          image.value = pickedImageInWeb;
        }
      } else {
        final pickedImageInMobile = await pickImageForMobile();
        if (pickedImageInMobile != null) {
          image.value = pickedImageInMobile;
        }
      }
    }

    final Color userColor = getRandomColor();
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthIsUserLoggedInSuccess) {
            context.read<AuthBloc>().add(
                  SignUpWelcomePageProfileUploadEvent(
                    uid: state.user.uid!,
                    isProfilePhotoUploaded: image.value != null,
                    image: image.value,
                    username: username.value,
                    color: userColor.value,
                  ),
                );
          }
          if (state is AuthIsUserLoggedInFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
          }
          if (state is CreateUserSuccess) {
            GoRouter.of(context).goNamed(AppRouteConstants.mainPage);
          }
          if (state is CreateUserFailed) {
            showSnackBar(
              context: context,
              title: 'Oh',
              content: state.message,
              contentType: ContentType.failure,
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Loader();
          }
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(40),
              children: [
                ValueListenableBuilder(
                  valueListenable: username,
                  builder: (context, value, child) {
                    return Text(
                      'WELCOME ${username.value}!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w800),
                    );
                  },
                ),
                const Text(
                  'upload your image and enter your name below.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 50,
                ),
                Center(
                  child: ProfileImageWidget(
                    image: image,
                    userColor: userColor,
                    username: username,
                    onPressed: () async => selectImage(),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  initialValue: initialUsername,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      username.value = value;
                    } else {
                      username.value = initialUsername;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: 'Enter your UserName',
                  ),
                ),
                InkWell(
                  onTap: () {
                    showCurrencyPicker(
                      context: context,
                      onSelect: (Currency currency) {
                        currentCurrency.value = currency;
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 5,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: currentCurrency,
                      builder: (context, value, child) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton2<String>(
                            isExpanded: true,
                            hint: Text(
                              currentCurrency.value != null
                                  ? '${currentCurrency.value!.name} ${currentCurrency.value!.symbol}'
                                  : 'Select You Base Currency',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: items
                                .map(
                                  (String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            buttonStyleData: const ButtonStyleData(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              height: 40,
                              width: 140,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                PrimaryAppButton(
                  buttonText: 'Save',
                  onPressed: () {
                    if (currentCurrency.value != null) {
                      context.read<AuthBloc>().add(
                            CreateUserEvent(
                              username: username.value,
                              currency: currentCurrency.value!.name,
                              currencySymbol: currentCurrency.value!.symbol,
                              image: image.value,
                              color: userColor.value,
                            ),
                          );
                    } else {
                      Fluttertoast.showToast(
                          msg: 'Please Select Your Currency');
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Future<Uint8List?> pickImageForWeb() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (imageFile != null) {
  //     return await imageFile.readAsBytes();
  //   }
  //   return null;
  // }

  // Future<File?> pickImageForMobile() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? imageFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (imageFile != null) {
  //     return File(imageFile.path);
  //   }
  //   return null;
  // }
}
