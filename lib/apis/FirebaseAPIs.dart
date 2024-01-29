import 'dart:io';

import 'package:chat_app/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBases {
  // Auth Firebase
  static FirebaseAuth auth = FirebaseAuth.instance;

  // Firebase storeage
  static FirebaseStorage storage = FirebaseStorage.instance;

  // Get current user
  static User get user => auth.currentUser!;

  static late ChatUser me;

  // Accessing Cloud Store
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  // For self infor
  static Future<void> getSelfInfo() async {
    await FirebaseFirestore.instance
        .collection('chat_users')
        .doc(user!.uid)
        .get()
        .then((value) async {
      if (value.exists) {
        me = ChatUser.fromJson(value.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // Check user exist
  static Future<bool> isUserExist() async {
    // Kiểm tra xem người dùng đã đăng nhập chưa trước khi truy cập Firestore
    if (user == null) {
      return false;
    }

    // Thực hiện truy vấn để kiểm tra sự tồn tại của người dùng trong Firestore
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('chat_users')
        .doc(user!.uid)
        .get();

    // Kiểm tra xem dữ liệu người dùng có tồn tại hay không
    return userSnapshot.exists;
  }

  // Created user
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUser(
        createdAt: time,
        id: user.uid,
        avatar: user.photoURL.toString(),
        isOnline: false,
        lastActive: time,
        message: 'Msg',
        email: user.email.toString(),
        username: user.displayName.toString(),
        pushToken: '');
    await FirebaseFirestore.instance
        .collection('chat_users')
        .doc(user!.uid)
        .set(chatUser.toJson());
  }

  static Future<void> updateUserInfo(String userName) async {
    await firestore.collection('chat_users').doc(user.uid).update({
      'username': userName,
    });
  }

  static Future<void> signOutAccount() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await auth.signOut().then((value) async {
      await googleSignIn.signOut().then((value) {});
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore
        .collection('chat_users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  static Future<void> updateProfile(File file) async {
    // Get image file extension
    final ext = file.path.split('.').last;

    // Storage file with path
    final ref = storage.ref().child('profile_avatar').child('/${user.uid}.$ext');

    // Uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      print('Bytes transferred : ${p0.bytesTransferred / 1000} kb');
    });

    // Update image in firebase database
    String avatar = await ref.getDownloadURL();
    print(avatar);
    me.avatar = avatar;
    await firestore.collection('chat_users').doc(me.id).update({
      'avatar': '${avatar}',
    });

      // await ref.putFile(File(file.path), metadata);
  }
}
