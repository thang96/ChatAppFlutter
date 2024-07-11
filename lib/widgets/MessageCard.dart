import 'package:base_core/resources.dart';
import 'package:chat_app/apis/FirebaseAPIs.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/utils/common.dart';
import 'package:flutter/material.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {

    return FireBases.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }



  Widget _greenMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Padding(padding: EdgeInsets.only(left: ds.width * 0.04)),
          if (widget.message.read.isNotEmpty)
            Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          Gaps.hGap2,
          Text(
            '${getFormatDateTime(context, widget.message.send)}',
            style: TextStyle(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ]),
        Flexible(
            child: Container(
          padding: EdgeInsets.all(5.dp),
          margin: EdgeInsets.symmetric(
              vertical: ds.height * 0.01, horizontal: ds.width * 0.04),
          decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.dp),
                topRight: Radius.circular(10.dp),
                bottomRight: Radius.circular(10.dp),
              )),
          child: Text(
            '${widget.message.msg}',
            style: TextStyle(color: Colors.black, fontSize: 15.sp),
          ),
        )),
      ],
    );
  }

  Widget _blueMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            child: Container(
          padding: EdgeInsets.all(5.dp),
          margin: EdgeInsets.symmetric(
              vertical: ds.height * 0.01, horizontal: ds.width * 0.04),
          decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.dp),
                topRight: Radius.circular(10.dp),
                bottomRight: Radius.circular(10.dp),
              )),
          child: Text(
            '${widget.message.msg}',
            style: TextStyle(color: Colors.black, fontSize: 15.sp),
          ),
        )),
        Padding(
          padding: EdgeInsets.only(right: ds.width * 0.04),
          child: Text(
            '${'${getFormatDateTime(context, widget.message.send)}'}',
            style: TextStyle(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
