import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowMessage extends StatelessWidget {
  final String text;
  final Timestamp timestamp;
  final String imageUrl;
  final bool isSender;

  const ShowMessage({
    super.key,
    required this.text,
    required this.timestamp,
    required this.imageUrl,
    required this.isSender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(
        top: 5,
        bottom: 5,
        right: isSender ? 5 : 0,
        left: isSender ? 0 : 5,
      ),
      decoration: BoxDecoration(
        color: isSender ? Color(0xFFEFFEDD) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: isSender ? Radius.circular(8) : Radius.circular(0),
          bottomRight: isSender ? Radius.circular(0) : Radius.circular(8),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          if (text.isNotEmpty)
            Text(text)
          else
            Image.network(
              imageUrl,
              height: 300,
              width: 200,
              fit: BoxFit.cover,
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                _formatTime(timestamp),
                style: TextStyle(
                  color: isSender ? Color(0xFF899F74) : Color(0xFFBBBEBE),
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (isSender)
                Icon(
                  Icons.check,
                  size: 15,
                  color: Color(0xFF899F74),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatTime(Timestamp timeStamp) {
    return timeStamp
        .toDate()
        .toString()
        .split(' ')[1]
        .split('.')[0]
        .split(':')
        .sublist(0, 2)
        .join(':');
  }
}
