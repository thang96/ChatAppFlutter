import 'package:base_core/resources.dart';
import 'package:chat_app/pages/chat_page/chat_page.dart';
import 'package:flutter/material.dart';

import '../../apis/FirebaseAPIs.dart';

class ChatScreen {
  BuildContext _context;
  ChatPageState _main;
  ChatScreen(this._context, this._main);

  Widget screen() {
    return _mainScreen(_context);
  }

  _mainScreen(BuildContext context) {
    return Scaffold(
      appBar: _header(_context, _main),
      body: Column(
        children: [
          Expanded(child: StreamBuilder(
            stream: FireBases.getAllUser(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                // TODO: Handle this case.
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.active:
                // TODO: Handle this case.
                case ConnectionState.done:
                  // if (snapshot.hasData) {
                  //   final response = snapshot.data.docs;
                  //   _main.vm.listUser = response
                  //       .map((user) => ChatUser.fromJson(user.data()))
                  //       .toList() ??
                  //       [];
                  // }
              }
              List _list = ['non','send'];
              if (_list.isNotEmpty) {
                return ListView.builder(
                  itemCount: _list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Text('${_list[index]}');
                  },
                );
              } else {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.dp),
                    child: Text(
                      'Say hi!👋',
                      style:
                      TextStyle(fontSize: 20.dp, color: Colors.black38),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),),
          _chatInput(),
        ],
      ),
    );
  }
}

AppBar _header(BuildContext context, ChatPageState main) {
  return AppBar(
    title: Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${main.vm.currentUserChat.username}'),
              Container(
                width: 8.dp,
                height: 8.dp,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.dp),
                    color: main.vm.currentUserChat.isOnline
                        ? Colors.greenAccent
                        : Colors.red),
              ),
            ],
          )
        ],
      ),
    ),
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back_ios),
    ),
  );
}

Widget _chatInput() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.dp,horizontal: 0.3.dp),
    child: Row(
      children: [
        Expanded(
            child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.dp)),
          child: Row(
            children: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.emoji_emotions,
                    size: 24.dp,
                    color: Colors.orange,
                  )),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(
                    hintText: '...',
                    hintStyle: TextStyle(color: Colors.blueAccent),
                    border: InputBorder.none),
              )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.image,
                    size: 24.dp,
                    color: Colors.indigo,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.camera_alt,
                    size: 24.dp,
                    color: Colors.black87,
                  )),
            ],
          ),
        )),
        MaterialButton(
            onPressed: () {},
            shape: CircleBorder(),
            color: Colors.green,
            minWidth: 0,
            padding: EdgeInsets.only(top: 10.dp,bottom: 15.dp,left: 5.dp,right: 5.dp),
            child: Icon(Icons.send,color: Colors.white,size: 28.dp,))
      ],
    ),
  );
}
