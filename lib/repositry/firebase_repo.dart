class FirebaseRepo {
  FirebaseRepo._();

  static FirebaseRepo instance = FirebaseRepo._();

// FirebaseDatabase _db = FirebaseDatabase.instance;
//
// void setImage(String url, int colorCode) {
//   _db
//       .reference()
//       .child("images")
//       .push()
//       .set({"imageColor": colorCode, "imageUrl": url});
// }
//
// Future<dynamic> getImageJson() {
//   return _db.reference().child("images").once().then((value) => value.value);
// }
}
