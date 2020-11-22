import 'package:clothes_demo_app/model/image.dart';
import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  User user = User.instance;

  setToFavorit(String productName) {
    user.liskedProducts.contains(productName)
        ? user.liskedProducts.remove(productName)
        : User.instance.liskedProducts.add(productName);
    notifyListeners();
  }

  List<Product> getFavoriteList() {
    List<Product> productList = [];
    for (var i in user.liskedProducts) {
      if (products.keys.contains(i.trim())) {
        productList.add(products[i]);
      }
    }
    return productList;
  }

  List<Basket> getBasketProductList() {
    List<Basket> productList = [];
    for (var i in user.userBasket) {
      if (products.keys.contains(i.productName.trim())) {
        i.product = products[i.productName.trim()];
        productList.add(i);
      }
    }
    return productList;
  }

  setToBasket(Basket basket) {
    for (var i in user.userBasket) {
      if (i.productName == basket.productName &&
          i.productSize == basket.productSize &&
          i.productColor == basket.productColor) {
        i.productQuantity++;
        notifyListeners();
        return;
      }
    }
    user.userBasket.add(basket);
    notifyListeners();
  }

  removeFromBasket(Basket basket) {
    for (var i in user.userBasket) {
      if (i.productName == basket.productName &&
          i.productSize == basket.productSize &&
          i.productColor == basket.productColor) {
        if (i.productQuantity == 1) {
          user.userBasket.remove(basket);
          notifyListeners();
          return;
        } else {
          i.productQuantity--;
          notifyListeners();
          return;
        }
      }
    }
  }

  bool isLikedProduct(String productName) {
    return user.liskedProducts.contains(productName);
  }

  bool isLogin() {
    return user.logIn != null;
  }

  bool loginUser(UserLogIn logIn) {
    if (user.logIn == null) {
      user.logIn = logIn;
      notifyListeners();

      return true;
    }
  }

  bool logupUser(UserLogIn logUp) {
    for (var i in usersList) {
      if (i.userEmail == logUp.userEmail) {
        notifyListeners();

        return false;
      } else {
        usersList.add(logUp);
        loginUser(logUp);
        notifyListeners();

        return true;
      }
    }
  }

  bool logOutUser() {
    if (user.logIn != null) {
      user.logIn = null;
      notifyListeners();
      return true;
    }
  }

  UserLogIn getUser() {
    return User.instance.logIn;
  }

  double getTotalPrice() {
    double price = 0.0;
    for (var i in getBasketProductList()) {
      price += i.productQuantity * i.product.price;
    }
    return price;
  }

  void setLocation({String location, String country, double lat, double long}) {
    user.userLat = lat;
    user.userLong = long;
    user.userLocationDetails = location;
    user.userLocationContry = country;
    notifyListeners();
  }

  double shappingPrice() {
    var location = getLocationContry();
    if (!location.contains("No Location")) {
      if (location.toUpperCase().contains("cairo".toUpperCase()) ||
          location.toUpperCase().contains("giza".toUpperCase())) {
        return 55.0;
      } else {
        return 85.0;
      }
    } else {
      return 85.0;
    }
  }

  int getTotalQuantity() {
    int quantity = 0;
    for (var i in getBasketProductList()) {
      quantity += i.productQuantity;
    }
    return quantity;
  }

  String getLocationDetails() {
    if (user.userLocationDetails != null) {
      return user.userLocationDetails;
    } else {
      return "No address details set";
    }
  }

  String getLocationContry() {
    if (user.userLocationContry != null) {
      return user.userLocationContry;
    } else {
      return "No Location";
    }
  }
}

class LikedProduct {
  String productId;
  String productSeason;

  LikedProduct({this.productId, this.productSeason});
}

class Basket {
  String productName;
  int productColor;
  String productSize;
  Product product;
  int productQuantity;

  Basket(
      {this.productName,
      this.productColor,
      this.productSize = "m",
      this.productQuantity = 1,
      this.product});
}

class User {
  User._();

  static User instance = User._();

  List<String> liskedProducts = [];
  List<Basket> userBasket = [];
  double userLat;
  double userLong;
  String userLocationDetails;
  String userLocationContry;

  UserLogIn logIn;
}

class UserLogIn {
  String username;
  String userEmail;
  String password;
  String userNumber;
  double userLat;
  double userLong;
  String userLocationContry;
  String userLocationDetails;

  UserLogIn(
      {this.username,
      this.userEmail,
      this.userNumber,
      this.userLat,
      this.userLong,
      this.password,
      this.userLocationContry,
      this.userLocationDetails});
}

List<UserLogIn> usersList = [
  UserLogIn(
    userEmail: "ag1@gmail.com",
    password: "123123",
    username: "ahmed gomaa",
    userLat: 29.8407818,
    userLong: 31.3565201,
    userNumber: "12345678",
    userLocationContry: "Cairo",
    userLocationDetails: "Street 133, Helwan, Cairo Governorate",
  ),
  UserLogIn(
    userEmail: "ag2@gmail.com",
    password: "123123",
    username: "ahmed gomaa",
    userLat: 29.8407818,
    userLong: 31.3565201,
    userLocationContry: "Cairo",
    userLocationDetails: "Street 133, Helwan, Cairo Governorate",
  ),
  UserLogIn(
    userEmail: "ag3@gmail.com",
    password: "123123",
    username: "ahmed gomaa",
    userLat: 29.8407818,
    userLong: 31.3565201,
    userLocationContry: "Cairo",
    userLocationDetails: "Street 133, Helwan, Cairo Governorate",
  ),
];
