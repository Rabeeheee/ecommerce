class Vendor {
  final String userID;
  final String vendorID;
  final String email;
  final String phoneNumber;
  final bool businessProfileUploaded;
  final int color;
  final String userName;
  final bool isVendor;
  final String? businessPicture;
  final String businessName;
  final String physicalAddress;
  final String accountNumber;

  Vendor({
    required this.userID,
    required this.vendorID,
    required this.email,
    required this.phoneNumber,
    required this.businessProfileUploaded,
    required this.color,
    required this.userName,
    required this.isVendor,
    required this.businessPicture,
    required this.businessName,
    required this.physicalAddress,
    required this.accountNumber,
  });
}
