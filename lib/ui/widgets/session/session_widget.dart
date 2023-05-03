import 'package:flutter/material.dart';
import 'package:talk/models/session.dart';
import 'package:talk/ui/screens/chat/chat.dart';
import 'package:talk/utils/format_date.dart';

class SessionWidget extends StatefulWidget {
  Session s;
  SessionWidget({
    super.key,
    required this.s,
  });

  @override
  _SessionWidgetState createState() => _SessionWidgetState();
}

class _SessionWidgetState extends State<SessionWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.s.read();
        });
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatPage(d: widget.s);
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
                    backgroundImage: AssetImage(widget.s.image),
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
                            widget.s.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.s.text,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: widget.s.unReadMessageCount == 0
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
                  // widget.s.timestrap.toString(),
                  formatDateTime(widget.s.timestrap),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: widget.s.unReadMessageCount == 0
                          ? FontWeight.bold
                          : FontWeight.normal),
                ),
                const SizedBox(
                  height: 6,
                ),
                widget.s.unReadMessageCount == 0
                    ? Container()
                    : Badge(
                        // label: Text("6"),
                        label: Text(
                          widget.s.unReadMessageCount == 0
                              ? ''
                              : '${widget.s.unReadMessageCount}',
                          style: TextStyle(
                            fontWeight: widget.s.unReadMessageCount == 0
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
