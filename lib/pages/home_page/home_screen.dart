import 'package:base_core/resources.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/apis/FirebaseAPIs.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/pages/home_page/home_page.dart';
import 'package:chat_app/widgets/ChatUserCard.dart';
import 'package:flutter/material.dart';

class HomeScreen {
  BuildContext _context;
  HomeState _main;
  HomeScreen(this._context, this._main);

  Widget screen() {
    return _mainScreen(_context);
  }

  _mainScreen(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(_context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (_main.vm.isSearch) {
            _main.changeIsSearch();
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            leading: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            actions: [
              IconButton(
                  onPressed: _main.changeIsSearch,
                  icon: _main.vm.isSearch
                      ? Icon(Icons.close)
                      : Icon(Icons.search)),
              IconButton(
                onPressed: () {
                  _main.gotoProfile();
                },
                icon: CachedNetworkImage(
                  imageUrl:
                      '${FireBases.auth.currentUser!.photoURL.toString()}',
                  imageBuilder: (context, imageProvider) => Container(
                    width: 20.dp,
                    height: 20.dp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.dp),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.white, BlendMode.colorBurn)),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ],
            title: _main.vm.isSearch
                ? TextFormField(
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    style:
                        TextStyle(color: Colors.white, decorationThickness: 0),
                    onChanged: (value) => _main.filterUser(value),
                  )
                : Container(
                    child: Row(
                      children: [
                        Text(
                          'Live ',
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrangeAccent,
                              fontSize: 16.sp),
                        ),
                        Text('Chat',
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                color: Colors.green))
                      ],
                    ),
                  ),

          ),
          body: StreamBuilder(
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
                  if (snapshot.hasData) {
                    final response = snapshot.data.docs;
                    _main.vm.listUser = response
                            .map((user) => ChatUser.fromJson(user.data()))
                            .toList() ??
                        [];
                  }
              }
              if (_main.vm.listUser.isNotEmpty) {
                return ListView.builder(
                  itemCount: _main.vm.isSearch
                      ? _main.vm.listSearchUser.length
                      : _main.vm.listUser.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return ChatUserCard(
                      user: _main.vm.isSearch
                          ? _main.vm.listSearchUser[index]
                          : _main.vm.listUser[index],
                    );
                  },
                );
              } else {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.dp),
                    child: Text(
                      'Chưa có người bạn nào\n Hãy kết bạn với mọi người để có thể trò chuyện với nhau',
                      style: TextStyle(fontSize: 20.dp, color: Colors.black38),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
