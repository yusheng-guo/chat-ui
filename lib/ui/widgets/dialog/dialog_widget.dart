import 'package:flutter/material.dart';
import 'package:talk/models/dialog.dart';
import 'package:talk/ui/screens/chat/chat.dart';

class DialogWidget extends StatefulWidget {
  // String name;
  // String text;
  // String image;
  // String time;
  // int unReadMessageCount;

  // DialogWidget({
  //   super.key,
  //   required this.name,
  //   required this.text,
  //   required this.image,
  //   required this.time,
  //   this.unReadMessageCount = 0,
  // });

  DialogM d;
  DialogWidget({
    super.key,
    required this.d,
  });

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.d.read();
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatPage(d: widget.d);
        }));
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.d.image),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.d.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.d.text,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.d.unReadMessageCount == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  widget.d.time,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: widget.d.unReadMessageCount == 0
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
                const SizedBox(
                  height: 6,
                ),
                widget.d.unReadMessageCount == 0
                    ? Container()
                    : Badge(
                        // label: Text("6"),
                        label: Text(
                          widget.d.unReadMessageCount == 0
                              ? ''
                              : '${widget.d.unReadMessageCount}',
                          style: TextStyle(
                            fontWeight: widget.d.unReadMessageCount == 0
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                        backgroundColor: Colors.grey,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
