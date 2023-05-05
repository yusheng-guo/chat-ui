import 'dart:convert';

import 'package:get/get.dart';
import 'package:talk/configure.dart';
import 'package:talk/models/message.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketController extends GetxController {
  final String _url = 'ws://127.0.0.1:8080/v1/ws/'; // WebSocket服务器地址
  late WebSocketChannel _channel; // WebSocket通信通道
  // bool _isConnected = false; // 连接状态

  // 可观察对象，用于监听连接状态和消息列表变化
  final _messages = Rx<List<Message>>([]);

  // 获取消息
  List<Message> get messages => _messages.value;

  @override
  void onInit() {
    super.onInit();
    connect(token); // 建立WebSocket连接
  }

  // 建立WebSocket连接
  void connect(String token) {
    final headers = {'Authorization': 'Bearer $token'}; // 将token添加到请求头

    _channel =
        IOWebSocketChannel.connect(_url, headers: headers); // 建立WebSocket连接
    _channel.stream.listen((dynamic message) {
      onMessage(message); // 接收服务器发送的消息
    });
  }

  // 断开WebSocket连接
  void disconnect() {
    _channel.sink.close();
  }

  // 发送消息
  void sendMessage(Message message) {
    final json = jsonEncode(message.toJson()); // 将消息对象转换为JSON格式
    _channel.sink.add(json); // 发送消息到服务器端
    // _messages.add(message); // 将Message对象添加到消息列表
    // messagesRx.value = _messages; // 更新消息列表
    _messages.value = List.from(_messages.value)..add(message);
  }

  // 接收消息
  void onMessage(dynamic message) {
    final json = jsonDecode(message); // 将JSON格式的消息转换为Map对象
    final messageObj = Message.fromJson(json); // 将Map对象转换为Message对象
    // _messages.add(messageObj); // 将Message对象添加到消息列表
    // messagesRx.value = _messages; // 更新消息列表
    _messages.value = List.from(_messages.value)..add(messageObj);
  }

  @override
  void onClose() {
    disconnect(); // 断开WebSocket连接
    super.onClose();
  }
}
