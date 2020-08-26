
import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart' as img;

import 'utils/blurhash_dart.dart';

void main(){

  Uint8List fileData = File("https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/allbikes-1539286251.jpg").readAsBytesSync();
  img.Image image = img.decodeImage(fileData.toList());

final blurHash = encodeBlurHash(
  image.getBytes(format: img.Format.rgba),
  image.width,
  image.height,
);

print("$blurHash");
}