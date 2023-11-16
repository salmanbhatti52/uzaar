import 'package:Uzaar/services/xFiletoBase64.dart';
import 'package:image_picker/image_picker.dart';

Future getImage({required String from}) async {
  XFile? returnedImage;
  Map<String, dynamic> images = {};
  if (from == 'camera') {
    returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    images = await collectImages(returnedImage);
    return images;
  } else if (from == 'gallery') {
    returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    images = await collectImages(returnedImage);
    return images;
  } else {}
}

Future<Map<String, dynamic>> collectImages(XFile? returnedImage) async {
  XFile? selectedImage;
  String selectedImageInBase64 = '';
  Map<String, dynamic> images = {};

  if (returnedImage == null) {
    images = {};
    return images;
  }
  selectedImage = returnedImage;

  selectedImageInBase64 = await convertXFileToBase64(selectedImage);
  images = {
    'selectedImage': selectedImage,
    'selectedImageInBase64': selectedImageInBase64
  };
  print(selectedImageInBase64);
  return images;
}
