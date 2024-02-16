import 'package:base_core/resources.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
    ));
  }

  static void showProgressBar(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Center(
              child: CircularProgressIndicator(),
            ));
  }

  static void showMessageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => Center(
              child: Container(
                width: ds.width - 20.dp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.dp),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(5.dp),
                  child: Wrap(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Internet connection error',
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Gaps.vGap5,
                          Text(
                            '   Check your internet to use the service',
                            style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black45),
                          ),
                        ],
                      ),
                      Center(
                        child: TextButton(onPressed: () {
                          Navigator.pop(context);
                        }, child: Text('OK')),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
