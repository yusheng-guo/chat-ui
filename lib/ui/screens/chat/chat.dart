import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk/configure.dart';
import 'package:talk/models/message.dart';
import 'package:talk/models/session.dart';
import 'package:talk/services/ws.dart';
import 'package:uuid/uuid.dart';

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
  final TextEditingController _textController =
      TextEditingController(); // 文本控制器
  final FocusNode _focusNode = FocusNode(); // 聚焦控制器
  final ScrollController _listController = ScrollController(); // 列表滚动控制器
  final WebSocketController _webSocketController =
      Get.find<WebSocketController>(); // websocket通信控制器

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => _focusNode.requestFocus()); // 输入框自动聚焦
    _scrollToBottomDirectly(); // 滚动止最低
  }

  @override
  void dispose() {
    // 释放控制器
    _listController.dispose();
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // _handleSendMessage 消息处理
  void _handleSendMessage() {
    final String text = _textController.text.trim();
    if (text.isNotEmpty) {
      _sendMessage(text);
    }
    _scrollToBottomWithAnimation();
    _textController.clear();
  }

  // _sendMessage 消息发送
  void _sendMessage(String text) {
    // 添加消息到列表
    Message msg = Message(
      id: const Uuid().v4(),
      sender: myid,
      receiver: widget.d.id,
      content: text,
      createdAt: DateTime.now(),
    );

    // 消息发送到服务器
    _webSocketController.sendMessage(msg);
    // 消息存储到本地数据库
  }

  // _scrollToBottomDirectly 滚动到最下面 没有动画
  void _scrollToBottomDirectly() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 控制器与可滚动组件是否建立了连接
      if (_listController.hasClients) {
        _listController.jumpTo(_listController.position.maxScrollExtent);
      }
    });
  }

  // _scrollToBottomWithAnimation 滚动到最下面 有动画
  void _scrollToBottomWithAnimation() {
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
            child: Obx(
              () => ListView.builder(
                itemCount: _webSocketController.messages.length,
                controller: _listController,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final msg = _webSocketController.messages[index];
                  // _scrollToBottomWithAnimation();
                  return Container(
                    padding: const EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (msg.receiver == myid
                          ? Alignment.topLeft
                          : Alignment.topRight),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (msg.receiver == myid
                              ? Colors.grey.shade200
                              : Colors.blue[200]),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          // _messages[index].content,
                          msg.content,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
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
