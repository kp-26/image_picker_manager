import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'managers/font_enum.dart';
import 'managers/kg_image_picker.dart';
import 'extensions/common_extensions.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class GeneralUtility {

  static GeneralUtility? _instance;
  GeneralUtility._internal() {
    _instance = this;
  }

  static GeneralUtility get shared => _instance ?? GeneralUtility._internal();

}

extension ExtGeneralUtility1 on GeneralUtility {

  showSnackBar(String message) {
    if (navigatorKey.currentContext == null) {
      return;
    }
    ScaffoldMessenger.of(navigatorKey.currentContext!).removeCurrentSnackBar();
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(snackBar);
  }

  showImagePicker({bool withRemoveOption = true, required void Function(ImagePickType, XFile?)? completion}) {
    if (navigatorKey.currentContext == null){
      return;
    }
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            )
        ),
        backgroundColor: Colors.white,
        context: navigatorKey.currentContext!,
        builder: (context) {
          return KGImagePicker(showRemove: withRemoveOption, completion: completion);
        });
  }

}

extension ExtGeneralUtility2 on GeneralUtility {

  getTextStyle({MyFont myFont = MyFont.regular, Color? color, Color? bgColor, double fontSize = 15}) {
    return TextStyle(
        fontFamily: myFont.family,
        fontWeight: myFont.weight,
        color: color,
        backgroundColor: bgColor,
        fontSize: fontSize
    );
  }

}

extension ExtGeneralUtility3 on GeneralUtility {

  Future<XFile?> imageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera, imageQuality: 50
    );
    return image;
  }

  Future<XFile?> imageFromGallery() async {
    XFile? image = await  ImagePicker().pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );
    return image;
  }

}

extension ExtGeneralUtility4 on GeneralUtility {

  Image getAssetImage({String? name, double? height, double? width, BoxFit? fit, String? ext, Color? color}){
    if (height != null || width != null) {
      return Image.asset("assets/images/${name ?? ""}.${ext ?? "png"}", fit: fit ?? BoxFit.none, color: color, height: height, width: width,);
    }
    return Image.asset("assets/images/${name ?? ""}.${ext ?? "png"}", fit: fit ?? BoxFit.fill, color: color,);
  }

  Image? getBase64Image({String? base64String, double? height, double? width, BoxFit? fit, String? ext, Color? color}) {
    if((base64String?.isSpaceEmpty() ?? true) == true) {
      return null;
    }
    return Image.memory(base64Decode(base64String ?? ""), fit: fit, height: height, width: width, color: color);
  }

}