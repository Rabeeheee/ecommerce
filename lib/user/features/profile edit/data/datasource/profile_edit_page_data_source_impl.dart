import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tech_haven/core/common/data/model/user_model.dart';
import 'package:tech_haven/user/features/profile%20edit/data/datasource/profile_edit_page_data_source.dart';
import 'package:uuid/uuid.dart';

class ProfileEditPageDataSourceImpl implements ProfileEditPageDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  ProfileEditPageDataSourceImpl(
      {required this.firebaseFirestore, required this.firebaseStorage});

  @override
  Future<void> updateUserData(UserModel userModel, dynamic newImage) async {
    try {
      String? imageUrl;
      String imageID =
          const Uuid().v1(); // Generate a new unique ID for the image

      if (newImage != null) {
        // Create a reference to the storage location for the user's profile picture
        Reference reference = firebaseStorage
            .ref('user')
            .child('usersProfilePicture')
            .child(userModel.uid!);

        // Upload the new image file
        if (userModel.userImageID != null) {
          await reference.child(userModel.userImageID!).delete();
        }
        newImage is File
            ? await reference.child(imageID).putFile(newImage)
            : await reference.child(imageID).putData(newImage);

        // Get the download URL of the uploaded image
        imageUrl = await reference.child(imageID).getDownloadURL();
      }

      // Prepare updated user data
      // final Map<String, dynamic> userData = {

      // };

      // // If imageUrl is not null, update profilePicture field
      // if (imageUrl != null) {
      //   userData['profilePicture'] = imageUrl;
      // } else {
      //   // Use the existing profile photo URL if no new image was uploaded
      //   userData['profilePicture'] = userModel.profilePhoto;
      // }

      // Update user document in Firestore
      await firebaseFirestore.collection('users').doc(userModel.uid).update({
        'userImageID': imageID,
        'username': userModel.username,
        'isProfilePictureUploaded': userModel.isProfilePhotoUploaded,
        'profilePhoto': imageUrl ?? userModel.profilePhoto
      });
    } catch (e) {
      // Handle errors here (logging, UI feedback, etc.)
      rethrow; // Optionally rethrow the exception for further handling upstream
    }
  }
}
