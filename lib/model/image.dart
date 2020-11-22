class Season {
  String seasonId;
  String seasonName;
  Map<String, Collection> seasonCollection;

  Season({this.seasonId, this.seasonCollection, this.seasonName});
}

class Collection {
  String collectionName;
  ImageModel collectionImage;
  Map<String, Product> collectionProduc;

  Collection(
      {this.collectionName, this.collectionImage, this.collectionProduc});
}

class ColorsModel {
  String colorName;
  int colorHex;

  ColorsModel({this.colorName, this.colorHex});
}

class Product {
  String productName;
  Map<String, ImageModel> image;
  String date;
  List<String> color;

  List<ColorsModel> colors;
  List<String> size;
  int quantity;
  double price;

  Product(
      {this.productName,
      this.image,
      this.date,
      this.color,
      this.size,
      this.quantity,
      this.price,
      this.colors});
}

class ImageModel {
  ColorsModel color;
  String imageUrl;
  int imageColor;

  ImageModel({this.imageUrl, this.imageColor, this.color});

  factory ImageModel.fromJson(json) => ImageModel(
        imageUrl: json["imageUrl"],
        imageColor: json["imageColor"] ?? 4291998339,
      );
}

Map<String, Season> seasonsList = {
  "winter": Season(
      seasonId: "winter",
      seasonName: "winter2021",
      seasonCollection: seasonCollections),
  "summer": Season(
      seasonId: "summer",
      seasonName: "Summer2020",
      seasonCollection: seasonCollections)
};

Map<String, Product> products = {
  "WATER PROOF JACKET ZIPPER POCKET": Product(
      size: ["l", "m", "s"],
      productName: "WATER PROOF JACKET ZIPPER POCKET",
      price: 750.00,
      image: {
        "Olive Green": ImageModel(
          imageUrl:
              "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_3808copy_240x.jpg?v=1603622710",
          imageColor: 4289374638,
          color: ColorsModel(colorName: "Olive Green", colorHex: 4286611456),
        ),
      },
      date: DateTime.now().toString(),
      quantity: 100),
  "BELTED DENIM JACKET2": Product(
      size: ["l", "m", "s"],
      productName: "BELTED DENIM JACKET",
      price: 390.00,
      image: {
        "Medium Blue": ImageModel(
          imageUrl:
              "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_6822_1024x1024.jpg?v=1593526756",
          imageColor: 4284899683,
          color: ColorsModel(
            colorName: "Medium Blue",
            colorHex: 4278190285,
          ),
        ),
      },
      date: DateTime.now().toString(),
      quantity: 100),
  "WATER PROOF JACKET ZIPPER POCKET2": Product(
      size: ["l", "m", "s"],
      productName: "WATER PROOF JACKET ZIPPER POCKET",
      price: 750.00,
      image: {
        "Olive Green": ImageModel(
          imageUrl:
              "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_3808copy_240x.jpg?v=1603622710",
          imageColor: 4289374638,
          color: ColorsModel(
            colorName: "Olive Green",
            colorHex: 4286611456,
          ),
        ),
      },
      date: DateTime.now().toString(),
      quantity: 100),
  "WATER PROOF JACKET ZIPPER POCKET": Product(
      size: ["l", "m", "s"],
      productName: "WATER PROOF JACKET ZIPPER POCKET",
      price: 750.00,
      image: {
        "Olive Green": ImageModel(
          imageUrl:
              "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_3808copy_240x.jpg?v=1603622710",
          imageColor: 4289374638,
          color: ColorsModel(
            colorName: "Olive Green",
            colorHex: 4286611456,
          ),
        ),
      },
      date: DateTime.now().toString(),
      quantity: 100),
  "BELTED DENIM JACKET": Product(
      size: ["l", "m", "s"],
      productName: "BELTED DENIM JACKET",
      price: 390.00,
      image: {
        "Medium Blue": ImageModel(
          imageUrl:
              "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_6822_1024x1024.jpg?v=1593526756",
          imageColor: 4284899683,
          color: ColorsModel(
            colorName: "Medium Blue",
            colorHex: 4278190285,
          ),
        ),
      },
      date: DateTime.now().toString(),
      quantity: 100),
  "BELTED DENIM JACKET": Product(
      size: ["l", "m", "s"],
      productName: "BELTED DENIM JACKET",
      price: 390.00,
      image: {
        "Medium Blue": ImageModel(
          imageUrl:
              "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_6822_1024x1024.jpg?v=1593526756",
          imageColor: 4284899683,
          color: ColorsModel(
            colorName: "Medium Blue",
            colorHex: 4278190285,
          ),
        ),
      },
      date: DateTime.now().toString(),
      quantity: 100),
  "TWO POCKET GABARDINE JACKET": Product(
      size: ["l", "m", "s"],
      productName: "TWO POCKET GABARDINE JACKET",
      price: 350.00,
      image: {
        "Beige": ImageModel(
          imageUrl:
              "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/W1A2074_1024x1024.jpg?v=1591447793",
          imageColor: 4289374638,
          color: ColorsModel(
            colorName: "Beige",
            colorHex: 4294046168,
          ),
        ),
      },
      date: DateTime.now().toString(),
      quantity: 100),
};

Map<String, Collection> seasonCollections = {
  "BLOUSE+SHIRTS": Collection(
    collectionName: "Cardigan",
    collectionProduc: products,
    collectionImage: ImageModel(
      imageUrl:
          "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_1004copy_1024x1024.jpg?v=1602075886",
      imageColor: 4291998339,
    ),
  ),
  "JACKET": Collection(
    collectionName: "JACKET",
    collectionImage: ImageModel(
        imageUrl:
            "https://cdn.shopify.com/s/files/1/0293/1107/4409/products/AGV_3746copy_1024x1024.jpg?v=1603625441",
        imageColor: 4290361533),
    collectionProduc: products,
  ),
  "CARDIGAN": Collection(
    collectionName: "Dress",
    collectionProduc: products,
    collectionImage: ImageModel(
      imageUrl:
          "https://cdn.shopify.com/s/files/1/0293/1107/4409/collections/AGV_0702copy_720x.jpg?v=1602415420",
      imageColor: 4291998339,
    ),
  ),
  "JUMPSUIT": Collection(
    collectionName: "Pullovers&Tops",
    collectionProduc: products,
    collectionImage: ImageModel(
      imageUrl:
          "https://cdn.shopify.com/s/files/1/0293/1107/4409/collections/AGV_1956copy_720x.jpg?v=1602415343",
      imageColor: 4291998339,
    ),
  ),
};
