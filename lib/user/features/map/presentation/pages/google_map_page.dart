import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/widgets/custom_back_button.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/theme/app_pallete.dart';
import 'package:tech_haven/core/validators/validators.dart';
import 'package:tech_haven/user/features/map/presentation/bloc/map_page_bloc.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key, required this.isForCheckout});

  final bool isForCheckout;

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  TextEditingController locationTextEditingController = TextEditingController();
  TextEditingController apartmentHouseNumberTextEditingController =
      TextEditingController();
  TextEditingController emailAddressTextEditingController =
      TextEditingController();
  TextEditingController specificAddressTextEditingController =
      TextEditingController();
  TextEditingController phoneNumberTextEditingController =
      TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // context.read<MapPageBloc>().add(GetCurrentUserDataEvent());
    context.read<MapPageBloc>().add(GetCurrentLocationDetailsEvent());
  }

  @override
  void dispose() {
    locationTextEditingController.dispose();
    apartmentHouseNumberTextEditingController.dispose();
    emailAddressTextEditingController.dispose();
    specificAddressTextEditingController.dispose();
    phoneNumberTextEditingController.dispose();
    nameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isForCheckout
          ? null
          : AppBar(
              title: const Text('Location'),
              backgroundColor: AppPallete.whiteColor,
              leading: const CustomBackButton(),
              scrolledUnderElevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      GoRouter.of(context).pop();
                    },
                    child: const Text('CANCEL'),
                  ),
                )
              ],
            ),
      body: BlocConsumer<MapPageBloc, MapPageState>(
        listener: (context, state) {
          if (state is UpdateLocationDetailsFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is UpdateLocationDetailsSuccess) {
            Fluttertoast.showToast(msg: 'Location Updated SuccessFully');
            GoRouter.of(context).pop();
          }
          if (state is GetLocationDetailsFailed) {
            if (state.user == null) {
              Fluttertoast.showToast(msg: 'You Are Not Yet Signed In');
              GoRouter.of(context).pop();
            } else {
              if (state.user!.phoneNumber != null) {
                phoneNumberTextEditingController.text =
                    state.user!.phoneNumber!;
              }
              nameTextEditingController.text = state.user!.username!;
              emailAddressTextEditingController.text = state.user!.email!;
              Fluttertoast.showToast(msg: state.message);
            }
          }
          // if (state is GetCurrentUserDataFailed) {
          //   Fluttertoast.showToast(msg: state.message);
          // }
          // if (state is GetCurrentUserDataSuccess) {
          //   print('hjgjh');
          //   if (state.user != null) {
          //     phoneNumberTextEditingController.text = state.user!.phoneNumber!;

          //     nameTextEditingController.text = state.user!.username!;
          //     emailAddressTextEditingController.text = state.user!.email!;
          //   }
          // }
          if (state is GetLocationDetailsSuccess) {
            if (state.location != null) {
              if (state.user.phoneNumber != null) {
                phoneNumberTextEditingController.text = state.user.phoneNumber!;
              }
              emailAddressTextEditingController.text = state.user.email!;
              nameTextEditingController.text = state.user.username!;
              locationTextEditingController.text = state.location!.location;
              apartmentHouseNumberTextEditingController.text =
                  state.location!.apartmentHouseNumber;
              specificAddressTextEditingController.text =
                  state.location!.addressInstructions;
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 700,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (!widget.isForCheckout)
                        GlobalTitleText(
                            title: widget.isForCheckout
                                ? 'Confirm Your Location'
                                : 'Enter Your Location Details'),
                      CustomTextFormField(
                          enabled: false,
                          durationMilliseconds: 500,
                          labelText: 'Name',
                          hintText: 'e.g. John',
                          textEditingController: nameTextEditingController),
                      CustomTextFormField(
                          enabled: false,
                          durationMilliseconds: 500,
                          labelText: 'Phone Number',
                          hintText: '+ 000 00 000 0000',
                          textEditingController:
                              phoneNumberTextEditingController),
                      CustomTextFormField(
                        enabled: false,
                        durationMilliseconds: 500,
                        labelText: 'Email Address',
                        hintText: 'john@example.com',
                        textEditingController:
                            emailAddressTextEditingController,
                        validator: Validator.validateEmail,
                      ),
                      CustomTextFormField(
                        enabled: state is UpdateLocationDetailsLoading
                            ? false
                            : true,
                        durationMilliseconds: 500,
                        labelText: 'Location',
                        hintText: 'e.h. building name,street #',
                        textEditingController: locationTextEditingController,
                        validator: Validator.validateEmptyField,
                      ),
                      CustomTextFormField(
                        enabled: state is UpdateLocationDetailsLoading
                            ? false
                            : true,
                        durationMilliseconds: 500,
                        labelText: 'Apartment / House number',
                        hintText: 'building name / 1202.',
                        textEditingController:
                            apartmentHouseNumberTextEditingController,
                        validator: Validator.validateEmptyField,
                      ),
                      CustomTextFormField(
                        enabled: state is UpdateLocationDetailsLoading
                            ? false
                            : true,
                        durationMilliseconds: 500,
                        labelText: 'Address Specific Instructions (Optional)',
                        hintText: '',
                        textEditingController:
                            specificAddressTextEditingController,
                        validator: Validator.validateEmptyField,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: widget.isForCheckout
          ? null
          : BlocBuilder<MapPageBloc, MapPageState>(
              builder: (context, state) {
                return Container(
                  height: 70,
                  color: AppPallete.whiteColor,
                  padding: const EdgeInsets.all(8),
                  child: RoundedRectangularButton(
                    isLoading:
                        state is UpdateLocationDetailsLoading ? true : false,
                    title: 'CONFIRM LOCATION',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<MapPageBloc>().add(
                            UpdateLocationDetailsEvent(
                                name: nameTextEditingController.text,
                                phoneNumber:
                                    phoneNumberTextEditingController.text,
                                location: locationTextEditingController.text,
                                apartmentHouseNumber:
                                    apartmentHouseNumberTextEditingController
                                        .text,
                                emailAdress:
                                    emailAddressTextEditingController.text,
                                addressInstructions:
                                    specificAddressTextEditingController.text));
                      }
                    },
                  ),
                );
              },
            ),
    );
  }
}
