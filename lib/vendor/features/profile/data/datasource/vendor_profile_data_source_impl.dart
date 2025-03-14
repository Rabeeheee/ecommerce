import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tech_haven/vendor/features/profile/data/datasource/vendor_profile_data_source.dart';
import 'package:tech_haven/vendor/features/registervendor/data/models/vendor_model.dart';

class VendorProfileDataSourceImpl implements VendorProfileDataSource {
  final FirebaseFirestore firestore;

  VendorProfileDataSourceImpl({required this.firestore});

  @override
  Future<VendorModel> fetchVendorProfile(String vendorID) async {
    try {
      final doc = await firestore.collection('vendors').doc(vendorID).get();
      if (doc.exists) {
        return VendorModel.fromJson(doc.data()!);
      } else {
        throw Exception('Vendor not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch vendor profile: $e');
    }
  }
}