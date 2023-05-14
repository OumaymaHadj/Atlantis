import 'package:flutter/material.dart';

import '../helper/main.color.dart';

class MessagesScreen extends StatefulWidget {
  final List messages;
  const MessagesScreen({super.key, required this.messages});

  @override
  // ignore: library_private_types_in_public_api
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: widget.messages[index]['isUserMessage']
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 14),
                    decoration: BoxDecoration(
                        // color: (widget.messages[index].messageType  == "receiver"?Colors.grey.shade200:Colors.blue[200]),
                        borderRadius: BorderRadius.only(
                          bottomLeft: const Radius.circular(
                            20,
                          ),
                          topRight: const Radius.circular(20),
                          bottomRight: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 0 : 20),
                          topLeft: Radius.circular(
                              widget.messages[index]['isUserMessage'] ? 20 : 0),
                        ),
                        color: widget.messages[index]['isUserMessage']
                            ? Color.fromARGB(255, 46, 46, 46)
                            : MainColor.mainColor  ),
                    constraints: BoxConstraints(maxWidth: w * 2 / 3),
                    child: Text(widget.messages[index]['message'].text.text[0],
                        style: const TextStyle(
                            fontSize: 17, color: Colors.white))),
              ],
            ),
          );
        },
        separatorBuilder: (_, i) =>
            const Padding(padding: EdgeInsets.only(top: 10)),
        itemCount: widget.messages.length);
  }
}
