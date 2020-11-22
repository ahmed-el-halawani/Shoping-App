import 'package:clothes_demo_app/model/image.dart';

class Slider {
  ImageModel image;
  String title;

  Slider({this.image, this.title});
}

List<Slider> sliderList = [
  Slider(
    image: ImageModel(
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0293/1107/4409/files/WhatsApp_Image_2020-10-11_at_2.16.05_PM_900x.jpg?v=1602422397",
        imageColor: 4291998339),
    title: "NEW COLLECTION AVAILABLE NOW !",
  ),
  Slider(
    image: ImageModel(
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0293/1107/4409/files/MRP_5670_900x.jpg?v=1603971925",
        imageColor: 4279373841),
    title: "YOU CAN NOW ENJOY WINTER ... THROUGH OUR PRODUCTS !",
  ),
  Slider(
    image: ImageModel(
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0293/1107/4409/files/WhatsApp_Image_2020-10-11_at_3.12.59_PM_900x.jpg?v=1602422550",
        imageColor: 4279373841),
    title: "WINTER STORM HAS STARTED NOW .. YOU CAN SHOP!",
  ),
];
