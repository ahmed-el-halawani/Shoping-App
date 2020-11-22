import 'dart:async';
import 'package:clothes_demo_app/model/image.dart';
import 'package:clothes_demo_app/repositry/firebase_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class MainProvider extends ChangeNotifier {
  bool isGettingImages = false;
  bool isGettingSlider = false;
  bool finishProgress = false;
  bool openFinish = false;

  FirebaseRepo repo = FirebaseRepo.instance;

  StreamSubscription stream;

  List<ImageModel> image2L = [];

  List<Collection> collections = [];

  List<String> s = ["summer", "winter"];

  int sliderIndex = 0;

  void changeSliderIndex(int index) {
    sliderIndex = index;
    collections.clear();
    getCollection();
    notifyListeners();
  }

  List<Collection> getCollection() {
    if (collections.isEmpty) {
      if (stream != null) {
        stream.cancel();
      }
      stream =
          Stream.fromFuture(Future.delayed(Duration(milliseconds: 500))).listen(
        (event) {
          collections =
              seasonsList[s[sliderIndex]].seasonCollection.values.toList();
          openFinish = true;
          notifyListeners();
        },
      );
    }
    return collections;
  }

  List<Product> getSearch(String searchKey) {
    List<Product> list = [];
    print(searchKey);
    if (searchKey == "") {
      print("here1");
      notifyListeners();
      return [];
    }
    for (var i in products.values) {
      if (i.productName.toUpperCase().contains(searchKey.toUpperCase())) {
        print("here2");
        list.add(i);
        print(i.productName);
      }
    }
    notifyListeners();
    return list;
  }

// List<ImageModel> getImage() {
//   if (image2L.isEmpty) getImageAsync();
//   return image2L;
// }
//
// Future<void> getImageAsync() async {
//   repo.getImageJson().then((value) async {
//     image2L = await compute(imageObjectMaker, value);
//     notifyListeners();
//   });
// }

}

// List<ImageModel> imageObjectMaker(dynamic Data) {
//   List<ImageModel> i = [];
//   Map<dynamic, dynamic> jsonList = Data;
//
//   jsonList.forEach((key, value) {
//     i.add(ImageModel.fromJson(value));
//   });
//
//   return i;
// }
