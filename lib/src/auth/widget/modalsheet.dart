import 'package:candy_app/decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  var imageUrl = RxString('');

  Future<void> imagePic() async {
    final XFile? pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      File imageFile = File(pickedImageFile.path);
      //convert file to bytes.
      List<int> imageBytes = await imageFile.readAsBytes();
      //encode the bytes to base64
      String base64String = base64Encode(imageBytes);
      imageUrl.value = base64String;
      update();
    }
  }
}

class UpdateImageModalSheet extends StatelessWidget {
  const UpdateImageModalSheet({
    super.key,
    required this.height,
    required this.width,
    required this.btnTitle,
    required this.text,
    required this.ontap,
    required this.imageController,
  });

  final double height;
  final double width;

  final btnTitle, text;
  final void Function()? ontap;
  final ImageController imageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: width * 0.075,
              ),
              Icon(
                FontAwesomeIcons.camera,
                size: 20,
                color: black,
              ),
              SizedBox(
                width: width * 0.15,
              ),
              SizedBox(
                width: width * 0.5,
                child: Text(
                  "Add Image ",
                  textAlign: TextAlign.start,
                  style: textBlackMediumBold,
                ),
              ),
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    color: black,
                  ))
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Text(text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textBlackMini.copyWith(color: lightGrey)),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
            child: GestureDetector(
              onTap: () {
                imageController.imagePic();
              },
              child: Container(
                height: height * 0.25,
                width: width * 0.5,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromRGBO(40, 40, 40, 1)),
                child: Obx(() {
                  final imagePath = imageController.imageUrl.value;
                  if (imagePath.isNotEmpty) {
                    return CircleAvatar(
                      backgroundImage: MemoryImage(base64Decode(imagePath)),
                    );
                  } else {
                    return Container(
                      height: height * 0.25,
                      width: width * 0.5,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ),
        SizedBox(
          height: height * 0.035,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: SizedBox(
                height: height * 0.065,
                width: width * 0.9,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: primaryColor,
                        shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: ontap,
                    child: Text(
                      btnTitle,
                      style: textWhiteMedium,
                    ))),
          ),
        ),
        SizedBox(
          height: height * 0.035,
        ),
      ],
    );
  }
}

