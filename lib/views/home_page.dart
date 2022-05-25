import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_manager/utilities/general_utility.dart';
import 'package:image_picker_manager/utilities/managers/font_enum.dart';

import '../utilities/extensions/common_extensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? base64Img;

  @override
  Widget build(BuildContext context) {
    Image? image = GeneralUtility.shared.getBase64Image(base64String: base64Img, fit: BoxFit.fill);
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Pick Demo", style: GeneralUtility.shared.getTextStyle(myFont: MyFont.medium, fontSize: 20),),
        actions: [
          IconButton(onPressed: (){
            GeneralUtility.shared.showImagePicker(withRemoveOption: true, completion: (imagePickType, xFile){
              updateBase64ImgValue(xFile);
            });
          }, icon: const Icon(Icons.image))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
                child: Center(
                  child: image ?? Text("No image available", style: GeneralUtility.shared.getTextStyle(myFont: MyFont.medium, fontSize: 24)),
                )
            ),
          ],
        ),
      ),
    );
  }
}

extension on _HomePageState {

  updateBase64ImgValue(XFile? xFile) async {
    Uint8List? data = await xFile?.readAsBytes();
    setState(() {
      base64Img = ExtString.getBase64(data);
    });
  }

}