import 'package:uzaar/services/xFiletoBase64.dart';
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
    'image': {
      'imageInXFile': selectedImage,
      'imageInBase64': selectedImageInBase64
    }
  };
  // images = {
  //   'imageInXFile': selectedImage,
  //   'imageInBase64': selectedImageInBase64
  // };
  print(selectedImageInBase64);
  return images;
}

Future pickMultiImage() async {
  List<Map<String, dynamic>> images = [];
  List<XFile> imageList;
  imageList = await ImagePicker().pickMultiImage();

  images = await collectMultiImages(imageList: imageList);
  return images;
}

Future<List<Map<String, dynamic>>> collectMultiImages(
    {required List<XFile> imageList}) async {
  String imageInBase64 = '';
  // Map<String, dynamic> image = {};
  List<Map<String, dynamic>> images = [];
  if (imageList.isEmpty) {
    images = [];
    return images;
  }

  for (int i = 0; i < imageList.length; i++) {
    imageInBase64 = await convertXFileToBase64(imageList[i]);
    // print('image$i : $imageInBase64');
    // print(i);
    images.add({
      'image': {'imageInXFile': imageList[i], 'imageInBase64': imageInBase64}
    });
  }

  print(images);
  return images;
}
