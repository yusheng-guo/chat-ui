import 'package:web_socket_channel/io.dart';

class CompositionRoot {
  static IUserService _userService;

  static configure() async{
    final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');
    _userService = UserService()
  }
}
