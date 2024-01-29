import 'dart:async';

import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

String numberValidator(String value) {
  String number = value.replaceAll(new RegExp(r'[^0-9]'), '');
  String result = int.parse(number).toString();
  return result;
}

String formatAmount(String string) {
  String priceIntText = '';
  int counter = 0;
  for (int i = (string.length - 1); i >= 0; i--) {
    counter++;
    String str = string[i];
    if ((counter % 3) != 0 && i != 0) {
      priceIntText = '$str$priceIntText';
    } else if (i == 0) {
      priceIntText = '$str$priceIntText';
    } else {
      priceIntText = ',$str$priceIntText';
    }
  }
  return priceIntText.trim();
}

String formatAmountToThousands(String price) {
  String priceInText = '';
  int counter = 0;
  for (int i = (price.length - 1); i >= 0; i--) {
    counter++;
    String str = price[i];
    if ((counter % 3) != 0 && i != 0) {
      priceInText = "$str$priceInText";
    } else if (i == 0) {
      priceInText = "$str$priceInText";
    } else {
      priceInText = ",$str$priceInText";
    }
  }
  return priceInText.trim();
}

extension ColorExtension on String {
  toColor() {
    var hexString = this;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

Future<void> showMyDialog(
    BuildContext context, String title, String content) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('$title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('$content'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Xác nhận'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<int> showMenuGalleryBottom(BuildContext context) {
  Completer<int> completer = Completer<int>();
  showModalBottomSheet(
      backgroundColor: Color.fromRGBO(0, 0, 0, 0),
      context: context,
      builder: (_) {
        return Container(
          height: 190.dp,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      completer.complete(2);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(ds.width * 0.9, 52.dp),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.dp))),
                    child: Text(
                      'Camera',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Gaps.vGap5,
                ElevatedButton(
                    onPressed: () {
                      completer.complete(1);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(ds.width * 0.9, 52.dp),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.dp))),
                    child: Text(
                      'Library',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Gaps.vGap10,
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      completer.complete(0);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: Size(ds.width * 0.9, 52.dp),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.dp))),
                    child: Text(
                      'Close',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ))
              ],
            ),
          ),
        );
      });
  return completer.future;
}

final ImagePicker picker = ImagePicker();

Future<XFile?> captureAPhoto() async {
  final XFile? image = await picker.pickImage(source: ImageSource.camera);
  return image;
}

Future<XFile?> pickAnImage() async {
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<List<XFile?>> pickMultipleImages() async {
  final List<XFile> images = await picker.pickMultiImage();
  return images;
}
