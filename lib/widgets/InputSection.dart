import 'package:flutter/material.dart';

class InputSection extends StatefulWidget {
  InputSection(
    this.section,
    this.controller,
    this.onChanged,
    this.obscureText,
    this.isShowIcon,
  );

  final String section;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final bool obscureText;
  final bool isShowIcon;

  @override
  State<StatefulWidget> createState() {
    return MyInputSection(
      section,
      controller,
      onChanged,
      obscureText,
      isShowIcon,
    );
  }
}

class MyInputSection extends State<InputSection> {
  String section;
  TextEditingController controller;
  Function(String)? onChanged;
  bool obscureText;
  bool isShowIcon;

  MyInputSection(
    this.section,
    this.controller,
    this.onChanged,
    this.obscureText,
    this.isShowIcon,
  );

  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.text,
            obscureText: obscureText,
            onChanged: (text) {
              if (text.length > 0) {
                onChanged?.call(text);
              }
              setState(() {
                isEmpty = text.isEmpty;
              });
            },
            style: TextStyle(color: Colors.blueAccent),
            decoration: InputDecoration(
              labelText: section,
              labelStyle: TextStyle(
                color: isEmpty ? Colors.red : Colors.blueAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              fillColor: Colors.white,
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: isEmpty ? Colors.red : Colors.blueAccent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 3, color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(4),
              ),
              hintText: 'Nhập $section',
              suffixIcon: isShowIcon
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                      icon: !obscureText
                          ? Icon(
                              Icons.visibility,
                              color: Colors.black,
                            )
                          : Icon(
                              Icons.visibility_off,
                              color: Colors.grey,
                            ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
