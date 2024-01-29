import 'dart:io';

import 'package:base_core/resources.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/pages/profile_page/profile_page.dart';
import 'package:flutter/material.dart';

import '../../apis/FirebaseAPIs.dart';
import '../../utils/common.dart';

class ProfileScreen {
  ProFilePageState _main;
  BuildContext _context;
  ProfileScreen(this._main, this._context);
  Widget screen() {
    return _mainScreen(_context);
  }

  _mainScreen(BuildContext context) {
    final user = FireBases.me;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('ProFile'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade300,
        onPressed: _main.logoutAccount,
        child: Center(
            child: Icon(
          Icons.login,
          color: Colors.white,
        )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 30.dp, bottom: 10.dp),
              child: Stack(
                children: [
                  Container(
                    height: 190,
                    child: Column(
                      children: [
                        _main.vm.userAvatar != ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(150.dp),
                                child: Image.file(
                                  File('${_main.vm.userAvatar}'),
                                  width: 150.dp,
                                  height: 150.dp,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: '${user.avatar}',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 150.dp,
                                  height: 150.dp,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(150.dp),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                        colorFilter: ColorFilter.mode(
                                            Colors.white, BlendMode.colorBurn)),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: -4.dp,
                      right: -4.dp,
                      child: MaterialButton(
                        color: Colors.white,
                        onPressed: () async {
                          await showMenuGalleryBottom(_context).then((result) {
                            if (result == 2) {
                              _main.openCamera();
                            } else if (result == 1) {
                              _main.openGallery();
                            }
                          });
                        },
                        shape: CircleBorder(),
                        elevation: 2,
                        child: Icon(
                          Icons.edit_outlined,
                          size: 20,
                        ),
                      ))
                ],
              ),
            ),
            Container(
              child: Text(
                '${user.email}',
                style: TextStyle(color: Colors.black54, fontSize: 16.sp),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.dp),
                child: InputForm(_context, 'Username', '${user.username}',
                    _main.vm.usernameController, true, () {}, true)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: _main.updateInformation,
                  child: Container(
                    child: Text('Update'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

Widget InputForm(
    BuildContext context,
    String section,
    String username,
    TextEditingController controller,
    bool obscureText,
    onChanged,
    bool isEmpty) {
  return Container(
    width: MediaQuery.of(context).size.width - 20,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic),
          decoration: InputDecoration(
              labelText: section,
              labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                      color: Colors.blueAccent, width: 1.dp, strokeAlign: 2))),
        ),
      ],
    ),
  );
}
