import 'package:base_core/resources.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:flutter/material.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;
  const ChatUserCard({super.key, required this.user});

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(10.dp),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.dp)),
      child: InkWell(
        onTap: () {},
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: '${widget.user.avatar}',
            imageBuilder: (context, imageProvider) => Container(
              width: 50.dp,
              height: 50.dp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.dp),
                image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter:
                        ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
              ),
            ),
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          title: Text(
            widget.user.username,
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(widget.user.message,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black87,
              )),
          trailing: Container(
            width: 10.dp,
            height: 10.dp,
            decoration: BoxDecoration(
                color: widget.user.isOnline
                    ? Colors.greenAccent.shade400
                    : Colors.redAccent.shade400,
                borderRadius: BorderRadius.circular(10.dp)),
          ),
        ),
      ),
    );
  }
}
