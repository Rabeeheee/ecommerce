import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tech_haven/core/common/icons/icons.dart';
import 'package:tech_haven/core/common/widgets/global_title_text.dart';
import 'package:tech_haven/core/common/widgets/loader.dart';
import 'package:tech_haven/core/common/widgets/rounded_rectangular_button.dart';
import 'package:tech_haven/core/constants/constants.dart';
import 'package:tech_haven/core/common/widgets/custom_text_form_field.dart';
import 'package:tech_haven/core/entities/image.dart' as model;
import 'package:tech_haven/core/entities/category.dart';
import 'package:tech_haven/core/entities/product.dart';
import 'package:tech_haven/core/utils/show_snackbar.dart';
import 'package:tech_haven/core/validators/validators.dart';
import 'package:tech_haven/vendor/core/common/widget/vendor_app_bar.dart';
import 'package:tech_haven/vendor/features/manageproduct/presentation/bloc/manage_product_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/get_images_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/bloc/register_product_bloc.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/add_images_widget.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/brand_drop_down.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/drop_down_widgets.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/dynamic_form.dart';
import 'package:tech_haven/vendor/features/registerproduct/presentation/widgets/sub_text.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterProductPage extends StatefulWidget {
  const RegisterProductPage({super.key, required this.product});

  final Product? product;

  @override
  State<RegisterProductPage> createState() => _RegisterProductPageState();
}

class _RegisterProductPageState extends State<RegisterProductPage> {
  // final TextEditingController brandNameTextEditingController =
  //     TextEditingController();

  final TextEditingController productNameTextEditingController =
      TextEditingController();
  final TextEditingController colorTextEditingController =
      TextEditingController();
  final TextEditingController productPrizeTextEditingController =
      TextEditingController();

  final TextEditingController productOldPrizeTextEditingController =
      TextEditingController();

  final TextEditingController productQuantityTextEditingController =
      TextEditingController();

  final TextEditingController productOverviewTextEditingController =
      TextEditingController();
  final TextEditingController shippingChargeController =
      TextEditingController();

  List<int?> categoryIndexes = [null, null, null];

  List<Category> allCategories = [];
  List<Category> allBrands = [];

  List<int?> selectedBrandIndex = [null];

  GlobalKey<FormState> globalFormKey = GlobalKey();

  Map<String, String> specifications = {};
  // bool isValid = false;
  void handleFormData(Map<String, String> data) {
    // setState(() {
    // context
    // .read<RegisterProductBloc>()
    // .add(OnChangeDynamicFormEvent(data: data));
    // print('hello');
    specifications = data;
    // print(specifications);
    // validateFormData(data);
    // });
  }

  // bool validateFormData() {
  //   for (var entry in specifications.entries) {
  //     print(specifications.entries.first.key);
  //     if (entry.key.isEmpty || entry.value.isEmpty) {
  //       return false;
  //     }
  //   }
  //   print('ok da');
  //   return true;
  // }

  Map<int, List<dynamic>> productImages = {};
  // Map<int, List<Uint8List>>? productImagesForWeb = {};
  ValueNotifier<bool> shippingChargeBool = ValueNotifier(false);

  List<int> deletedImagesIndex = []; //

  @override
  Widget build(BuildContext context) {
    // print('I am here');
    Future<bool> deleteProduct({
      required Product product,
      required Map<int, List<model.Image>> listOfImagesLinks,
    }) async {
      final boolean = await showConfirmationDialog(
        context,
        'Delete This Product',
        'Are You Sure You Want To Delete this Product Forever',
        () {
          context.read<RegisterProductBloc>().add(
            DeleteTheProductEvent(
              product: widget.product!,
              mapOfListOfImages: listOfImagesLinks,
            ),
          );
        },
      );
      return boolean!;
    }

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // if (!RegisterProductBloc.isCategoryLoaded) {print('I am here');
      // If data is not loaded and not loading, fetch the data
      BlocProvider.of<RegisterProductBloc>(
        context,
      ).add(GetAllCategoryEvent(refreshPage: false));
      // }
      // if (!RegisterProductBloc.isBrandLoaded) {
      //   BlocProvider.of<RegisterProductBloc>(context).add(GetAllBrandEvent());
      // }
    });

    Map<int, List<model.Image>>? listOfImagesLinks;

    return BlocConsumer<RegisterProductBloc, RegisterProductState>(
      listener: (context, state) {
        // if (state is DynamicFormSuccessState) {
        //   specifications = state.data;
        //   print(specifications);
        // }
        if (state is NewProductRegisteredSuccess) {
          Fluttertoast.showToast(
            msg: "The Product is Registered Successfully",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          context.read<ManageProductBloc>().add(
            const GetAllProductsEventForManage(),
          );
          GoRouter.of(context).pop();
        }
        if (state is NewProductRegisteredFailed) {
          showSnackBar(
            context: context,
            title: 'Oh',
            content: state.message,
            contentType: ContentType.failure,
          );
        }

        if (state is DeleteProductSuccess) {
          Fluttertoast.showToast(
            msg: "The Product is Deleted Successfully",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          BlocProvider.of<ManageProductBloc>(
            context,
          ).add(const GetAllProductsEventForManage());

          GoRouter.of(context).pop();
        }
        if (state is DeleteProductFailed) {
          showSnackBar(
            context: context,
            title: 'Oh',
            content: state.message,
            contentType: ContentType.failure,
          );
        }
      },
      // buildWhen: ,
      builder: (context, state) {
        // print(state);
        if (state is RegisterProductLoading) {
          return Loader(totalImages: productImages[0]?.length);
        }
        if (state is RegisterProductAllCategoryLoadedSuccess) {
          context.read<GetImagesBloc>().add(EmitInitialEvent());
          allCategories = state.allCategoryModel;
          allBrands = state.allBrandModel;
          if (widget.product != null) {
            productOldPrizeTextEditingController.text =
                widget.product!.oldPrize.toString();
            colorTextEditingController.text = widget.product!.color;
            selectedBrandIndex[0] = allBrands.indexWhere(
              (element) => element.id == widget.product!.brandID,
            );
            productNameTextEditingController.text = widget.product!.name;
            productPrizeTextEditingController.text =
                widget.product!.prize.toString();
            productQuantityTextEditingController.text =
                widget.product!.quantity.toString();
            productOverviewTextEditingController.text =
                widget.product!.overview;
            shippingChargeBool.value = widget.product!.shippingCharge != 0;
            shippingChargeController.text =
                widget.product!.shippingCharge.toString();
            categoryIndexes[0] = allCategories.indexWhere(
              (element) => element.id == widget.product!.mainCategoryID,
            );
            categoryIndexes[1] = allCategories[categoryIndexes[0]!]
                .subCategories
                .indexWhere(
                  (element) => element.id == widget.product!.subCategoryID,
                );
            specifications = widget.product!.specifications ?? {};
            categoryIndexes[2] = allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .subCategories
                .indexWhere(
                  (element) => element.id == widget.product!.variantCategoryID,
                );
            context.read<GetImagesBloc>().add(
              GetImagesForTheProductEvent(productID: widget.product!.productID),
            );
          } else {
            selectedBrandIndex[0] = null;
          }
          return Scaffold(
            appBar: VendorAppBar(
              title:
                  widget.product != null
                      ? 'Update The Product'
                      : 'Register New Product',
              bottom: null,
              // messageIcon: widget.product != null ? false : true,
              trailingIcon:
                  widget.product != null ? CustomIcons.trashBinSvg : null,
              onPressedTrailingIcon: () {
                deleteProduct(
                  product: widget.product!,
                  listOfImagesLinks: listOfImagesLinks!,
                );
              },
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GlobalTitleText(title: 'General'),
                      Constants.kHeight,
                      BrandDropDown(
                        allBrandsModel: allBrands,
                        selectedBrandIndex: selectedBrandIndex,
                      ),
                      Constants.kHeight,
                      CustomTextFormField(
                        labelText: 'Product Name',
                        hintText: 'Product Name',
                        textEditingController: productNameTextEditingController,
                        validator: Validator.validateEmptyField,
                      ),
                      Constants.kHeight,
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'Product Prize',
                              hintText: 'Product Prize',
                              textEditingController:
                                  productPrizeTextEditingController,
                              validator: Validator.validateEmptyField,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$'),
                                ),
                              ],
                            ),
                          ),
                          Constants.kWidth,
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'Old Prize',
                              hintText: 'Old Prize',
                              textEditingController:
                                  productOldPrizeTextEditingController,
                              validator: Validator.validateEmptyField,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}$'),
                                ),
                              ],
                            ),
                          ),
                          Constants.kWidth,
                          Expanded(
                            child: CustomTextFormField(
                              labelText: 'Quantity',
                              hintText: 'Quantity',
                              textEditingController:
                                  productQuantityTextEditingController,
                              validator: Validator.validateEmptyField,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                            ),
                          ),
                        ],
                      ),
                      Constants.kHeight,
                      DropDownWidgets(
                        allCategories: allCategories,
                        categoryIndexes: categoryIndexes,
                        // mainCategoryValue: mainCategoryValue,
                        // subCategoryValue: subCategoryValue,
                        // variantCategoryValue: variantCategoryValue,
                      ),
                      Constants.kHeight,
                      const SubText(subText: 'Overview'),
                      Constants.kHeight,
                      TextFormField(
                        controller: productOverviewTextEditingController,
                        validator: Validator.validateEmptyField,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        decoration: const InputDecoration(
                          labelText: 'Enter text',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Constants.kHeight,
                      const SubText(subText: 'Specifications'),
                      Column(
                        children: [
                          if (specifications.isEmpty ||
                              specifications.values.any(
                                (value) => value.isEmpty,
                              ))
                            const ErrorTextWidget(
                              errorText:
                                  "Every name and its specification should be filled...",
                            ),
                          ...specifications.entries.map((entry) {
                            return Text("${entry.key}: ${entry.value}");
                          }).toList(),
                        ],
                      ),

                      DynamicForm(
                        onFormChanged: handleFormData,
                        productSpecifications: specifications,

                        //  widget.product != null
                        //     ? widget.product!.specifications ?? {}
                        //     : {},
                      ),
                      // SpecificationPage(
                      //     specificationTextFormFields:
                      //         specificationTextFormFields),
                      Constants.kHeight,
                      const GlobalTitleText(title: 'Shipping'),
                      Constants.kHeight,
                      ValueListenableBuilder(
                        valueListenable: shippingChargeBool,
                        builder: (context, shippingBool, child) {
                          // shippingBool == false
                          //     ? shippingChargeController.text = '0'
                          //     : null;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Charge Shipping',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Checkbox(
                                    value: shippingBool,
                                    onChanged: (value) {
                                      shippingChargeBool.value = value!;
                                    },
                                  ),
                                ],
                              ),
                              if (shippingBool)
                                CustomTextFormField(
                                  // onChanged: (p0) {
                                  //   print(shippingChargeController.text);
                                  //   print(double.parse(
                                  //       shippingChargeController.text));
                                  // },
                                  labelText: 'Shipping Charge.',
                                  hintText: 'Shipping Charge.',
                                  textEditingController:
                                      shippingChargeController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator:
                                      shippingBool
                                          ? Validator.validateEmptyField
                                          : null,
                                  durationMilliseconds: 150,
                                ),
                            ],
                          );
                        },
                      ),
                      Constants.kHeight,
                      const GlobalTitleText(title: 'Attribute'),
                      CustomTextFormField(
                        labelText: 'Color Name',
                        hintText: 'Color Name',
                        textEditingController: colorTextEditingController,
                        validator: Validator.validateEmptyField,
                      ),
                      BlocConsumer<GetImagesBloc, GetImagesState>(
                        listener: (context, state) {
                          if (state is GetImagesForRegisterProductFailed) {
                            showSnackBar(
                              context: context,
                              title: 'Oh',
                              content: state.message,
                              contentType: ContentType.failure,
                            );
                          }
                        },
                        // buildWhen: (previous, current) =>
                        //     current is GetImageForRegisterProduct,
                        builder: (context, state) {
                          if (state is GetImagesForRegisterProductSuccess) {
                            listOfImagesLinks = state.mapOfListOfImages;
                            return AddImagesWidget(
                              productImages: productImages,
                              productImagesLink: listOfImagesLinks,
                              deletedImagesIndex: deletedImagesIndex,
                              canAddNewImages: true,
                              // productImagesForWeb: productImagesForWeb,
                            );
                          }
                          return AddImagesWidget(
                            productImages: productImages,
                            productImagesLink: null,
                            // productImagesForWeb: productImagesForWeb,
                            deletedImagesIndex: deletedImagesIndex,
                            canAddNewImages: false,
                          );
                        },
                      ),
                      if (widget.product != null)
                        const GlobalTitleText(title: 'Update Current Images'),
                      if (widget.product != null)
                        const ErrorTextWidget(
                          errorText:
                              "Your old images of this product will be replaced by the new images",
                        ),
                      if (widget.product != null)
                        AddImagesWidget(
                          productImages: productImages,
                          productImagesLink: null,
                          deletedImagesIndex: deletedImagesIndex,
                          canAddNewImages: true,
                          // productImagesForWeb: productImagesForWeb,
                        ),

                      Constants.kHeight,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (widget.product == null)
                            SizedBox(
                              width: 150,
                              child: RoundedRectangularButton(
                                title: 'Draft',
                                outlined: true,
                                onPressed: () {
                                  if (globalFormKey.currentState!.validate() &&
                                      categoryIndexes[0] != null &&
                                      categoryIndexes[1] != null &&
                                      categoryIndexes[2] != null &&
                                      selectedBrandIndex[0] != null &&
                                      productImages.isNotEmpty &&
                                      specifications.isNotEmpty) {
                                    registerNewProduct(isPublished: false);
                                  } else if (productImages.isEmpty) {
                                    showSnackBar(
                                      context: context,
                                      title: 'Images',
                                      content: 'Please Upload Product Images',
                                      contentType: ContentType.warning,
                                    );
                                  }
                                },
                              ),
                            ),
                          SizedBox(
                            width: 150,
                            child: RoundedRectangularButton(
                              title:
                                  widget.product != null ? 'Update' : 'Publish',
                              onPressed: () {
                                print(
                                  "Form Valid: ${globalFormKey.currentState!.validate()}",
                                );
                                print("Category Indexes: $categoryIndexes");
                                print(
                                  "Selected Brand Index: $selectedBrandIndex",
                                );
                                print("Specifications: $specifications");
                                print(
                                  "Product Images Length: ${productImages.length}",
                                );

                                if (widget.product != null &&
                                    globalFormKey.currentState!.validate() &&
                                    categoryIndexes[0] != null &&
                                    categoryIndexes[1] != null &&
                                    categoryIndexes[2] != null &&
                                    specifications.isNotEmpty) {
                                  if (listOfImagesLinks!.length.compareTo(
                                            deletedImagesIndex.length,
                                          ) >
                                          0 ||
                                      productImages.isNotEmpty) {
                                    print("Updating product...");
                                    updateTheProduct();
                                  } else {
                                    showSnackBar(
                                      context: context,
                                      title: 'Images',
                                      content:
                                          'There must be at least one Image for the product',
                                      contentType: ContentType.warning,
                                    );
                                  }
                                } else if (globalFormKey.currentState!
                                        .validate() &&
                                    categoryIndexes[0] != null &&
                                    categoryIndexes[1] != null &&
                                    categoryIndexes[2] != null &&
                                    selectedBrandIndex[0] != null &&
                                    productImages.isNotEmpty &&
                                    specifications.isNotEmpty) {
                                  print("Registering new product...");
                                  registerNewProduct(isPublished: true);
                                } else {
                                  print("Validation failed");
                                  if (productImages.isEmpty) {
                                    showSnackBar(
                                      context: context,
                                      title: 'Images',
                                      content: 'Please Upload Product Images',
                                      contentType: ContentType.warning,
                                    );
                                  }
                                  if (categoryIndexes[0] == null &&
                                      categoryIndexes[1] == null &&
                                      categoryIndexes[2] == null) {
                                    showSnackBar(
                                      context: context,
                                      title: 'Categories',
                                      content: 'Please Select the Categories',
                                      contentType: ContentType.warning,
                                    );
                                  }
                                  if (specifications.isEmpty) {
                                    showSnackBar(
                                      context: context,
                                      title: 'Specifications',
                                      content:
                                          'Give the Specifications to Products',
                                      contentType: ContentType.warning,
                                    );
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void updateTheProduct() {
    // print(productImages.length);
    Product product = widget.product!;
    context.read<RegisterProductBloc>().add(
      UpdateExistingProductEvent(
        product: product,
        brandName: allBrands[selectedBrandIndex[0]!].categoryName,
        brandID: allBrands[selectedBrandIndex[0]!].id,
        specifications: specifications,
        productName: productNameTextEditingController.text,
        productPrize: double.parse(productPrizeTextEditingController.text),
        productOldPrize: double.parse(
          productOldPrizeTextEditingController.text,
        ),
        productQuantity: int.parse(productQuantityTextEditingController.text),
        mainCategory: allCategories[categoryIndexes[0]!].categoryName,
        mainCategoryID: allCategories[categoryIndexes[0]!].id,
        subCategory:
            allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .categoryName,
        subCategoryID:
            allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .id,
        variantCategory:
            allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .subCategories[categoryIndexes[2]!]
                .categoryName,
        variantCategoryID:
            allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .subCategories[categoryIndexes[2]!]
                .id,
        productOverview: productOverviewTextEditingController.text,
        shippingCharge: double.parse(shippingChargeController.text),
        productImages: productImages,
        color: colorTextEditingController.text,
        deleteImagesIndexes: deletedImagesIndex,
        isPublished: widget.product!.isPublished,
      ),
    );
  }

  void registerNewProduct({required bool isPublished}) {
    // print(allBrands[selectedBrandIndex[0]!].id);
    context.read<RegisterProductBloc>().add(
      RegisterNewProductEvent(
        color: colorTextEditingController.text,
        brandName: allBrands[selectedBrandIndex[0]!].categoryName,
        brandID: allBrands[selectedBrandIndex[0]!].id,
        productName: productNameTextEditingController.text,
        productPrize: double.parse(productPrizeTextEditingController.text),
        productOldPrize: double.parse(
          productOldPrizeTextEditingController.text,
        ),
        productQuantity: int.parse(productQuantityTextEditingController.text),
        specifications: specifications,
        mainCategory: allCategories[categoryIndexes[0]!].categoryName,
        mainCategoryID: allCategories[categoryIndexes[0]!].id,
        subCategory:
            allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .categoryName,
        subCategoryID:
            allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .id,
        variantCategory:
            allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .subCategories[categoryIndexes[2]!]
                .categoryName,
        variantCategoryID:
            allCategories[categoryIndexes[0]!]
                .subCategories[categoryIndexes[1]!]
                .subCategories[categoryIndexes[2]!]
                .id,
        productOverview: productOverviewTextEditingController.text,
        shippingCharge:
            shippingChargeController.text.isEmpty
                ? 0.01
                : double.parse(shippingChargeController.text),
        productImages: productImages,
        isPublished: isPublished,
      ),
    );
  }
}

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({super.key, required this.errorText});
  final String errorText;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: const TextStyle(color: Colors.red, fontSize: 10),
    );
  }
}

//  ElevatedButton(
//       onPressed: () {
//         var fieldValues = _getFieldValues();
//         if (fieldValues.length == fields.length) {
//           print(fieldValues);
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text('Please fill all fields'),
//             ),
//           );
//         }
//       },
//       child: const Text('Submit'),
//     ),
// class SpecificationPage extends StatefulWidget {
//   final Map<int, Map<String, String>> specificationTextFormFields;
//   const SpecificationPage(
//       {super.key, required this.specificationTextFormFields});

//   @override
//   State<SpecificationPage> createState() => _SpecificationPageState();
// }

// class _SpecificationPageState extends State<SpecificationPage> {
//   final List<Map<String, TextEditingController>> _controllers = [];

//   @override
//   void initState() {
//     super.initState();
//     widget.specificationTextFormFields.forEach((key, value) {
//       _controllers.add({
//         'Name': TextEditingController(text: value['Name']),
//         'Spec': TextEditingController(text: value['Spec']),
//       });
//     });
//   }

//   @override
//   void dispose() {
//     for (var controller in _controllers) {
//       controller['Name']?.dispose();
//       controller['Spec']?.dispose();
//     }
//     super.dispose();
//   }

//   void _addNewSpecification() {
//     setState(() {
//       _controllers.add({
//         'Name': TextEditingController(),
//         'Spec': TextEditingController(),
//       });
//       widget.specificationTextFormFields[_controllers.length - 1] = {
//         'Name': '',
//         'Spec': '',
//       };
//     });
//   }

//   void _removeSpecification(int index) {
//     setState(() {
//       _controllers[index]['Name']?.dispose();
//       _controllers[index]['Spec']?.dispose();
//       _controllers.removeAt(index);
//       widget.specificationTextFormFields.remove(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: _controllers.length + 1,
//       itemBuilder: (context, index) {
//         if (index < _controllers.length) {
//           return Row(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CustomTextFormField(
//                     labelText: 'Name',
//                     hintText: 'Name',
//                     durationMilliseconds: 150,
//                     textEditingController: _controllers[index]['Name'],
//                     onChanged: (value) {
//                       widget.specificationTextFormFields[index]?['Name'] =
//                           value;
//                     },
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: CustomTextFormField(
//                     labelText: 'Spec.',
//                     hintText: 'Spec.',
//                     durationMilliseconds: 150,
//                     textEditingController: _controllers[index]['Spec'],
//                     onChanged: (value) {
//                       widget.specificationTextFormFields[index]?['Spec'] =
//                           value;
//                     },
//                   ),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.remove),
//                 onPressed: () {
//                   _removeSpecification(index);
//                 },
//               ),
//             ],
//           );
//         } else {
//           return IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: _addNewSpecification,
//           );
//         }
//       },
//     );
//   }
// }
