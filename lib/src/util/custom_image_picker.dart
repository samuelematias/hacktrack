import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../themes/color_palette.dart';
import '../themes/spacing/linear_scale.dart';

class CustomImagePicker {
  static show(
    BuildContext context,
    ImageCroppedCallback onImageCropped,
    bool cutInCircle,
  ) {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text("Choose photo"),
              onPressed: () {
                choosePhoto(onImageCropped, cutInCircle);
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: Text("Take a picture"),
              onPressed: () {
                takePicture(onImageCropped, cutInCircle);
                Navigator.pop(context);
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text("Cancel"),
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } else if (Platform.isAndroid) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Select Image",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Container(
                height: space_magic_mint,
                // color: avocado,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        takePicture(onImageCropped, cutInCircle);
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Text(
                          "Open camera",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        choosePhoto(onImageCropped, cutInCircle);
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          top: space_fire_bush,
                        ),
                        child: Text(
                          "Select from Gallery",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    } else {
      return null;
    }
  }

  static Future choosePhoto(
      ImageCroppedCallback onImageCropped, bool cutInCircle) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _cropImage(image, onImageCropped, cutInCircle);
  }

  static Future takePicture(
      ImageCroppedCallback onImageCropped, bool cutInCircle) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    _cropImage(image, onImageCropped, cutInCircle);
  }

  static Future<Null> _cropImage(
      File imageFile, onImageCropped, bool cutInCircle) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
      circleShape: cutInCircle,
      toolbarColor: purple,
      toolbarWidgetColor: white,
      statusBarColor: purple,
      // toolbarWidgetColor:
    );
    onImageCropped(croppedFile);
  }
}

typedef void ImageCroppedCallback(
  File imageCropped,
);
