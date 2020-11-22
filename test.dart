main() {
  // img.Image photo;
  //
  // photo =img.decodeImage(File(r"C:\Users\A H M E D\Desktop\1.jpg").readAsBytesSync());
  //
  // double px = 1.0;
  // double py = 0.0;
  //
  // int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
  // int hex = abgrToArgb(pixel32);
  // print("Value of int: $hex ");
  //
  // double minHealth = 0;
  // double maxHealth = 100;
  // double minColValue = 0;
  // double maxColValue = 255;
  //
  // double output = ((hex - minHealth) / (maxHealth - minHealth) * (maxColValue - minColValue) + minColValue);
  // print("out ${output}");'

  var s =
      "https://cdn.shopify.com/s/files/1/0293/1107/4409/files/WhatsApp_Image_2020-10-11_at_3.12.59_PM_900x.jpg?v=1602422550";

  print(s.substring(s.indexOf("?v=")).replaceAll("?v=", ""));

  print(0 % 3); //0
  print(1 % 3); //1
  print(2 % 3); //2
  print(3 % 3); //0
  print(4 % 3); //1
  print(5 % 3); //2
  print(6 % 3); //0
  print(7 % 3); //1
  print(8 % 3); //2
}

int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
