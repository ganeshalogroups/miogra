// ignore_for_file: avoid_print, file_names

import 'package:dio/dio.dart';
import 'package:testing/parcel/p_services_provider/p_Round_Trip_Validation.dart';
import 'package:testing/parcel/p_services_provider/p_address_provider.dart';
import 'package:testing/utils/Const/ApiConstvariables.dart';
import 'package:testing/utils/Urlist.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageUploader {
  var isListLoading = false.obs;
  static var img = ''.obs;
  // static String img = '';
  Future<void> uploadImage(XFile? pickFile, XFile? image) async {
    if (pickFile == null) return;

    isListLoading(true);

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(image!.path, filename: pickFile.name),
      });

      Response response = await dio.post(
        "${API.microservicedev}api/utility/file/bannerUpload",
        data: formData,
        options: Options(headers: API().headers),
      );

      if (response.statusCode == 200) {
        // Get.snackbar('Image added Successfully', '',
        //     backgroundColor: const Color.fromARGB(255, 14, 167, 93));
        String imgUrl = response.data['data']["imgUrl"];
        profileuploed = response.data['data']["imgUrl"];

        getStorage.write('imgUrl', imgUrl);

        img(profileuploed);
        print("Image added Successfully: $imgUrl");
      } else {
        print("Image upload failed. Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Errojknr: $error");
    } finally {
      isListLoading(false);
    }
  }
}

class ImageUploaderProvider with ChangeNotifier {
  bool isListLoading = false;
  String imageList= "";
  Future<void> uploadImage({XFile? pickFile, XFile? image, contexxt}) async {
    if (pickFile == null) return;

    isListLoading = true;
    notifyListeners();

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(image!.path, filename: pickFile.name),
      });

      Response response = await dio.post(
        API.imageuploadurl,
        data: formData,
        options: Options(headers: API().headers),
      );

      if (response.statusCode == 200) {
        // Get full URL from response
        String imgUrl = response.data['data']["imgUrl"];
        imageList = imgUrl;
        // Extract only the file name from the URL
        String imageName = imgUrl.split('/').last;

        // Send only the image name
        Provider.of<ParcelAddressProvider>(contexxt, listen: false)
            .addPackageImage(imageUrl: imageName); // Now sending only the name

        notifyListeners();

        print("Image name added successfully: $imageName");
        print("Image name added successfully: $imgUrl");
      } else {
        print("Image upload failed. Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Error in upload: $error");
    } finally {
      isListLoading = false;
      notifyListeners();
    }
  }

  // Future<void> uploadImage({XFile? pickFile, XFile? image, contexxt}) async {
  //   if (pickFile == null) return;

  //   isListLoading = true;
  //   notifyListeners();

  //   try {
  //     Dio dio = Dio();
  //     FormData formData = FormData.fromMap({
  //       "file":
  //           await MultipartFile.fromFile(image!.path, filename: pickFile.name)
  //     });

  //     Response response = await dio.post(
  //       API.imageuploadurl,
  //       data: formData,
  //       options: Options(headers: API().headers),
  //     );

  //     if (response.statusCode == 200) {
  //       String imgUrl = response.data['data']["imgUrl"];
  //       Provider.of<ParcelAddressProvider>(contexxt, listen: false)
  //           .addPackageImage(imageUrl: imgUrl);
  //       notifyListeners();

  //       print("Image added Successfully: $imgUrl");
  //     } else {
  //       print("Image upload failed. Error: ${response.statusCode}");
  //     }
  //   } catch (error) {
  //     print("Error in here: $error");
  //   } finally {
  //     isListLoading = false;
  //     notifyListeners(); // Notify listeners when the loading state is finished
  //   }
  // }
}

class RoundTripImageUploaderProvider with ChangeNotifier {
  bool isListLoading = false;

  Future<void> uploadImage({XFile? pickFile, XFile? image, contexxt}) async {
    if (pickFile == null) return;

    isListLoading = true;
    notifyListeners();

    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(image!.path, filename: pickFile.name)
      });

      Response response = await dio.post(
        API.imageuploadurl,
        data: formData,
        options: Options(headers: API().headers),
      );

      if (response.statusCode == 200) {
        String imgUrl = response.data['data']["imgUrl"];
        Provider.of<RoundTripLOcatDataProvider>(contexxt, listen: false)
            .addPackageImage(imageUrl: imgUrl);
        notifyListeners();

        print("Image added Successfully: $imgUrl");
      } else {
        print("Image upload failed. Error: ${response.statusCode}");
      }
    } catch (error) {
      print("Errorrrrr: $error");
    } finally {
      isListLoading = false;
      notifyListeners(); // Notify listeners when the loading state is finished
    }
  }
}
