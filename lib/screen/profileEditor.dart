import 'dart:io';

import 'package:cartify/controller/ImagePickerController.dart';
import 'package:cartify/controller/setProfileImageController.dart';
import 'package:cartify/controller/uploadImagecontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



// ignore: must_be_immutable
class profileOptionSheet extends StatelessWidget {
  final uploadImageController uploadimageController =
      Get.put(uploadImageController());
  final Imagepickercontroller imagePickerController = Imagepickercontroller();

  SetProfileImagecontroller setProfileImageController =
      Get.put(SetProfileImagecontroller());

  profileOptionSheet({super.key});
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Take a Photo'),
              onTap: () async {
                 Get.back();
                File? image = await imagePickerController.getImage(
                    ImageSource.camera, context);
                if (image != null) {
                  String? imageUrl = await uploadimageController.uploadImage(
                      image, "Profile_image");
                  if (imageUrl != null) {
                    print('Profile image URL: $imageUrl');
                    setProfileImageController.setData(
                      imageUrl.toString(), 
                      userId.toString(),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Image upload failed!")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select image")),
                  );
                }

               
              },
            ),
            ListTile(

              leading: Icon(Icons.image),
              title: Text('Choose from Gallery'),
              onTap: () async{
                 Get.back();
                File? image = await imagePickerController.getImage(
                    ImageSource.gallery, context);
                if (image != null) {
                  String? imageUrl = await uploadimageController.uploadImage(
                      image, "Profile_image");
                  if (imageUrl != null) {
                    print('Profile image URL: $imageUrl');
                    setProfileImageController.setData(
                      imageUrl.toString(), userId.toString()
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Image upload failed!")),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please select image")),
                  );
                }
                
              },
            ),
             ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text('Remove Photo', style: TextStyle(color: Colors.red)),
              onTap: () async {
                 Get.back();
                await setProfileImageController.removePhoto();
               
              },
             )
          ],
        ),
      ),
    );
  }
}
