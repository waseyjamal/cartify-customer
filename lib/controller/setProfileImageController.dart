import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SetProfileImagecontroller extends GetxController {
  var imageUrl = "".obs;
  var isUploading = false.obs;

  final GetStorage _storage = GetStorage();
  final String _imageUrlKey = 'profile_image_url';
  @override
  void onInit() {
    super.onInit();
    loadImageUrl();
  }

  Future<void> setData(String imageUrl, String userId) async {
    try {
      isUploading.value = true;

      // Update the user document with the imageUrl
      await FirebaseFirestore.instance
          .collection('users') // Use the 'users' collection
          .doc(userId) // Use the userId as the document ID
          .update({
            'imageUrl': imageUrl, // Use imageUrl (same as before)
            'timestamp': FieldValue.serverTimestamp(),
          });

      this.imageUrl.value = imageUrl;
      await _storage.write(_imageUrlKey, imageUrl);
    } catch (e) {
      print("Error updating user profile: $e");
    } finally {
      isUploading.value = false;
    }
  }

  void loadImageUrl() {
    final savedImageUrl = _storage.read<String>(_imageUrlKey);
    if (savedImageUrl != null) {
      imageUrl.value = savedImageUrl;
    }
  }

  Future<void> removePhoto() async {
    try {
      isUploading.value = true;
      await _storage.remove(_imageUrlKey);
      imageUrl.value = '';
    } catch (e) {
      print("Error removing photo: $e");
    } finally {
      isUploading.value = false;
    }
  }

  Future<void> fetchImageUrl(String userId) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance
              .collection('Profiles')
              .doc(userId)
              .get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        imageUrl.value = data['ImageURL'] ?? '';
      } else {
        imageUrl.value = ''; // No image found for this user
      }
    } catch (e) {
      print("Error fetching image URL: $e");
    }
  }

  // Future<void> fetchImageUrl() async {
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('Profiles')
  //         .orderBy('timestamp', descending: true)
  //         .limit(1)
  //         .get();

  //     if (snapshot.docs.isNotEmpty) {
  //       var data = snapshot.docs.first.data() as Map<String, dynamic>;
  //       imageUrl.value = data['ImageURL'] ?? '';
  //     }
  //   } catch (e) {
  //     print("Error fetching image URL: $e");
  //   }
  // }
  Future<void> clearImageUrl() async {
    await _storage.remove(_imageUrlKey);
    imageUrl.value = '';
  }
}
