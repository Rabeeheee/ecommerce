class User {
  final String? uid;
  final String? userImageID;
  final String? phoneNumber;
  final String? username;
  final String? currency;
  final String? vendorID;
  final String? currencySymbol;
  final bool userAllowed;
  final String? email;
  final String? profilePhoto;
  final bool isVendor;
  final bool isProfilePhotoUploaded;
  final int color;

  User({
    required this.isVendor,
    required this.userAllowed,
    required this.userImageID,
    required this.isProfilePhotoUploaded,
    required this.uid,
    required this.phoneNumber,
    required this.username,
    required this.currency,
    required this.vendorID,
    required this.currencySymbol,
    required this.email,
    required this.profilePhoto,
    required this.color,
  });
}
