import 'dart:io';
import 'dart:typed_data';

import 'package:clothes_demo_app/repositry/firebase_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';


enum ViewChoise {
  stagridGrid,
  grid,
  list
}

class DesignProvider extends ChangeNotifier {
  // bool isGettingImages = false;
  // bool isGettingSlider = false;
  // FirebaseRepo repo = FirebaseRepo.instance;
  //
  //
  //
  // final List<String> images = [
  //   "assets/image/1.jpg",
  //   "assets/image/2.jpg",
  //   "assets/image/3.jpg",
  //   "assets/image/1.jpg",
  //   "assets/image/2.jpg",
  //   "assets/image/3.jpg",
  //   "assets/image/1.jpg",
  //   "assets/image/2.jpg",
  //   "assets/image/3.jpg"
  // ];
  //
  // final List<String> sliderImagesUrl = [
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/files/WhatsApp_Image_2020-10-11_at_2.16.05_PM_900x.jpg?v=1602422397",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/files/MRP_5670_900x.jpg?v=1603971925",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/files/WhatsApp_Image_2020-10-11_at_3.12.59_PM_900x.jpg?v=1602422550",
  // ];
  //
  // final List<String> images2 = [
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_4340_1024x1024.jpg?v=1603629054",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_2453copy_1024x1024.jpg?v=1602082920",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_0772copy_1024x1024.jpg?v=1602086211",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/W1A1363_5db2da08-b0ba-4526-8e4f-3eb8ee7cb062_1024x1024.jpg?v=1597665276",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_1646copy_1024x1024.jpg?v=1602157833",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_2013copy_1024x1024.jpg?v=1602158672",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_2022copy_1024x1024.jpg?v=1602158673",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_5714_1024x1024.jpg?v=1593701796",
  //   "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_5499_1024x1024.jpg?v=1593701795",
  // ];
  //
  // List<Uint8List> image2L = [];
  // List<int> colors2 = [];
  // List<Uint8List> sliderImage = [];
  // List<int> sliderColors = [];
  //
  //
  // List<Uint8List> getSliderImage() {
  //   if(!isGettingSlider ){
  //     if(sliderImage.isEmpty) getSliderImageAsync();
  //     return sliderImage;
  //   }
  //   return [];
  // }
  //
  // Future<void> getSliderImageAsync() async{
  //   var folderPath = (await getExternalStorageDirectory()).path + "/slider/";
  //
  //   if (!File(folderPath).existsSync()) {
  //     Directory(folderPath).createSync(recursive: true);
  //   }
  //
  //   for (var i in sliderImagesUrl) {
  //     Uint8List data;
  //     var sp = i
  //         .substring(i.indexOf("?v=")).replaceAll("?v=", "");
  //
  //     try {
  //       var imageDirectory = folderPath + sp;
  //       if (await File(imageDirectory).exists()) {
  //         data = await File(imageDirectory).readAsBytes();
  //       } else {
  //         data = (await NetworkAssetBundle(Uri.parse(i)).load(i))
  //             .buffer
  //             .asUint8List();
  //
  //         compute(createImageFile,
  //             {"imageDirectory": imageDirectory, "data": data});
  //       }
  //     } catch (ex) {
  //       print(ex.toString());
  //     }
  //     sliderImage.add(data);
  //   }
  //   var hex = await compute(hexFun, sliderImage);
  //   sliderColors.addAll(hex);
  //   isGettingSlider = false;
  //   notifyListeners();
  // }
  //
  // List<int> getColors2() {
  //   if (image2L.isEmpty && !isGettingImages) {
  //     isGettingImages = true;
  //     print("here333");
  //     _getColor2();
  //   }
  //   if(!isGettingImages){
  //     return colors2;
  //   }
  //     return [];
  // }
  //
  // Future<void> _getColor2() async {
  //   var folderPath = (await getExternalStorageDirectory()).path + "/images/";
  //
  //   if (!File(folderPath).existsSync()) {
  //     Directory(folderPath).createSync(recursive: true);
  //   }
  //
  //   for (var i in images2) {
  //     Uint8List data;
  //     var sp = i
  //         .substring(i.indexOf("?v=")).replaceAll("?v=", "");
  //
  //     try {
  //       var imageDirectory = folderPath + sp;
  //       if (await File(imageDirectory).exists()) {
  //         data = File(imageDirectory).readAsBytesSync();
  //       } else {
  //         data = (await NetworkAssetBundle(Uri.parse(i)).load(i))
  //             .buffer
  //             .asUint8List();
  //
  //         compute(createImageFile,
  //             {"imageDirectory": imageDirectory, "data": data});
  //       }
  //     } catch (ex) {
  //       print(ex.toString());
  //     }
  //     image2L.add(data);
  //   }
  //   var hex = await compute(hexFun, image2L);
  //   colors2.addAll(hex);
  //   isGettingImages = false;
  //   // for(var i in colors2){
  //   //   repo.setImage(images2[colors2.indexOf(i)], i);
  //   // }
  //   notifyListeners();
  // }


  ViewChoise viewChoiseIndex = ViewChoise.stagridGrid;

  void changeViewChoise(ViewChoise value) {
    viewChoiseIndex = value;
    notifyListeners();
  }


}
//
// int abgrToArgb(int argbColor) {
//   print("abgrToArgb");
//   int r = (argbColor >> 16) & 0xFF;
//   int b = argbColor & 0xFF;
//   return (argbColor & 0xFF00FF00) | (b << 16) | r;
// }

// List<int> hexFun(List<Uint8List> data) {
//   List<int> colors = [];
//   for (Uint8List i in data) {
//     img.Image photo = img.decodeImage(i);
//
//     double px = 20.0;
//     double py = 20.0;
//
//     int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
//     int hex = abgrToArgb(pixel32);
//     colors.add(hex);
//   }
//   return colors;
// }
//
// void createImageFile(Map<String, dynamic> args) {
//   // var imageDirectory = args["imageDirectory"];
//   // Uint8List data = args["data"];
//   //
//   // var x = new File(imageDirectory);
//   // var z2 = img.copyResize(img.decodeImage(data), height: 500);
//   // x.writeAsBytesSync(img.encodeJpg(z2));
// }
