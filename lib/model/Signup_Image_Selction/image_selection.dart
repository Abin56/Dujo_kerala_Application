
// ignore_for_file: override_on_non_overriding_member, unused_local_variable



import 'package:get/get.dart';



class GetImage extends GetxController {
    String? pickedImage;
  String? pickedimagefromGallery;
    
    @override
getCamera() async {
    // final images = await ImagePicker().pickImage(source: ImageSource.camera);
    // pickedImage = images!.path.obs;
    // pickedImage = images!.path;
    

    update();
  }
  

  getGallery() async {
    // final images = await ImagePicker().pickImage(source: ImageSource.gallery);
    update();
  }
    clearPicked() {
    pickedImage = null;
  }

}