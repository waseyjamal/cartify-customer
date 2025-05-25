import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class uploadImageController extends GetxController{
   var isUploading = false.obs;

   Future<String?> uploadImage(File imageFile, String  folderName) async{
        try{
           isUploading.value= true;
           String fileName= DateTime.now().millisecondsSinceEpoch.toString();
           Reference storageRef= FirebaseStorage.instance.ref().child("$folderName/$fileName");

           UploadTask uploadTask =storageRef.putFile(imageFile);
           await uploadTask;

           String downloadUrl = await storageRef.getDownloadURL();
           isUploading.value= false;
           return downloadUrl;
        }catch(e){
             isUploading.value = false;
      print("Error uploading image: $e");
      return null;
        }finally{
          isUploading.value=false;
        }
   }
}