// import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tech_haven/core/common/widgets/custom_app_bar.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/common/widgets/primary_app_button.dart';
import 'package:tech_haven/core/common/widgets/profile_image_widget.dart';
import 'package:tech_haven/core/entities/user.dart';
import 'package:tech_haven/core/utils/pick_image.dart';
// import 'package:tech_haven/core/utils/pick_image.dart';
import 'package:tech_haven/vendor/features/registervendor/presentation/bloc/register_vendor_bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:typed_data';
// import 'dart:io';

class RegisterVendorPage extends StatefulWidget {
  final User user;

  const RegisterVendorPage({
    super.key,
    required this.user,
  });

  @override
  State<RegisterVendorPage> createState() => _RegisterVendorPageState();
}

class _RegisterVendorPageState extends State<RegisterVendorPage> {
  TextEditingController physicalAdressController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  final vendorRegisterFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.user.vendorID != null) {
      context
          .read<RegisterVendorBloc>()
          .add(CheckForVendorStatusEvent(vendorID: widget.user.vendorID!));
    }

    ValueNotifier<String> businnessName = ValueNotifier(widget.user.username!);
    ValueNotifier<dynamic> image = ValueNotifier(null);

    void selectImage() async {
      if (kIsWeb) {
        final pickedImage = await pickImageForWeb();
        if (pickedImage != null) {
          image.value = pickedImage;
        }
      } else {
        final pickedImage = await pickImageForMobile();
        if (pickedImage != null) {
          image.value = pickedImage;
        }
      }
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Register as Vendor',
      ),
      body: BlocConsumer<RegisterVendorBloc, RegisterVendorState>(
        listener: (context, state) {
          if (state is SendRequestForVendorSuccess) {
            context
                .read<RegisterVendorBloc>()
                .add(CheckForVendorStatusEvent(vendorID: state.vendorID));
          }
          if (state is SendRequestForVendorFailed) {
            Fluttertoast.showToast(msg: state.message);
          }
          if (state is CheckForVendorStatusFailed) {
            physicalAdressController.clear();
            accountNumberController.clear();
            Fluttertoast.showToast(msg: state.message);
          }
        },
        builder: (context, state) {
          if (state is RegisterVendorLoading) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Please Wait...'),
                  CircularProgressIndicator(),
                ],
              ),
            );
          }
          if (state is CheckForVendorStatusSuccess) {
            return Center(
              child: Text(
                !state.vendor.isVendor
                    ? 'This May take a while to be accepted by the admin, Please Wait...'
                    : 'You are a vendor',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(40),
            children: [
              Text(
                'Hey ${widget.user.username}!',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              const Text(
                'Upload your business image and enter your business name below.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Center(
                child: ProfileImageWidget(
                  image: image,
                  userColor: Color(widget.user.color),
                  username: businnessName,
                  onPressed: () async => selectImage(),
                ),
              ),
              const SizedBox(height: 50),
              Form(
                key: vendorRegisterFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: widget.user.username,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          businnessName.value = value;
                        } else {
                          businnessName.value = widget.user.username!;
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Enter your Business Name',
                        hintText: 'Name',
                      ),
                    ),
                    CustomTextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Physical Address',
                      hintText: 'Enter your Physical Address',
                      textEditingController: physicalAdressController,
                    ),
                    CustomTextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      labelText: 'Account Number',
                      hintText: 'Enter Your Account Number',
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textEditingController: accountNumberController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              PrimaryAppButton(
                buttonText: 'Register as Vendor',
                onPressed: () {
                  if (vendorRegisterFormKey.currentState!.validate()) {
                    context.read<RegisterVendorBloc>().add(
                          SendRequestForVendorEvent(
                            user: widget.user,
                            businessPicuture: image.value,
                            businessName: businnessName.value,
                            physicalAddress: physicalAdressController.text,
                            accountNumber: accountNumberController.text,
                          ),
                        );
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
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
