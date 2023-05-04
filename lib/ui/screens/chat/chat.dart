import 'package:flutter/material.dart';
import 'package:talk/configure.dart';
import 'package:talk/data/messages.dart';
import 'package:talk/models/message.dart';
import 'package:talk/models/session.dart';

class ChatPage extends StatefulWidget {
  Session d;

  ChatPage({
    super.key,
    required this.d,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ScrollController _listController = ScrollController();
  List<Message> _messages = messages;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _focusNode.requestFocus()); // 输入框自动聚焦
    scrollToBottom(); // 滚动止最低
  }

  @override
  void dispose() {
    // 释放控制器
    _listController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSendMessage() {
    final String text = _textController.text.trim();
    if (text.isNotEmpty) {
      _sendMessage(text);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 控制器与可滚动组件是否建立了连接
      if (_listController.hasClients) {
        _listController.animateTo(
          _listController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
    _textController.clear();
  }

  void _sendMessage(String text) {
    // 添加消息到列表
    Message msg = Message(
      sender: myid,
      receiver: widget.d.id,
      content: text,
      createdAt: DateTime.now(),
    );

    setState(() {
      _messages.add(msg);
    });
    // 消息发送到服务器

    // 消息存储到本地数据库
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 控制器与可滚动组件是否建立了连接
      if (_listController.hasClients) {
        _listController.jumpTo(_listController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(widget.d.image),
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.d.name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _listController,
              itemCount: _messages.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(
                      left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (_messages[index].receiver == myid
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (_messages[index].receiver == myid
                            ? Colors.grey.shade200
                            : Colors.blue[200]),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        _messages[index].content,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            // height: double.infinity,
            // height: ,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // color: Colors.grey[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(5),
              height: 60,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      focusNode: _focusNode, // 自动对焦
                      onEditingComplete: _handleSendMessage,
                      decoration: const InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                    onPressed: () {
                      // 处理消息
                      _handleSendMessage();
                    },
                    icon: const Icon(
                      Icons.send,
                      size: 24,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
