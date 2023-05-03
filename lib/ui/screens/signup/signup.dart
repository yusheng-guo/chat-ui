import 'dart:convert';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:talk/colors.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double heightOfScreen = MediaQuery.of(context).size.height;
    double widthOfScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: heightOfScreen,
              width: widthOfScreen,
              decoration: const BoxDecoration(color: kPrimary),
            ),
            Positioned(
              child: ClipPath(
                clipper: CustomSignUpShapeClipper1(),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
            ),
            Positioned(
              child: ClipPath(
                clipper: CustomSignUpShapeClipper2(),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 36),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: heightOfScreen * 0.1),
                  const IntroText(),
                  SizedBox(height: heightOfScreen * 0.1),
                  const SignUpForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomSignUpShapeClipper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height);

    var firstEndpoint = Offset(size.width, size.height * 0.52);
    var firstControlPoint = Offset(size.width * 0.25, size.height * 0.52);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

class CustomSignUpShapeClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.30);

    var firstEndpoint = Offset(size.width, size.height * 0.15);
    var firstControlPoint = Offset(size.width * 0.5, size.height * 0.13);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndpoint.dx, firstEndpoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}

// 介绍文本
class IntroText extends StatelessWidget {
  const IntroText({super.key});

  @override
  Widget build(BuildContext context) {
    return ListBody(
      children: const <Widget>[
        Text(
          "Sign up",
          style: TextStyle(
            color: Colors.black,
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 36),
        Text(
          "We are happy to see you here!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// 注册表单
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      print('Email: $_email, Password: $_password');
      _showAlertDialog(await register(_email, _password));
    }
  }

  // 显示对话框
  void _showAlertDialog(String message) async {
    await showOkAlertDialog(
      context: context,
      title: 'Message',
      message: message,
      okLabel: 'OK',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            onChanged: (value) {
              _email = value.trim();
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.password),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            onChanged: (value) {
              _password = value.trim();
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _submitForm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              fixedSize: const Size(250.0, 40.0),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// 用户登录
Future<String> register(String email, String password) async {
  // 设置请求URL
  final url = Uri.parse('http://127.0.0.1:8080/v1/register');

  // 设置请求头
  final headers = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // 设置请求体（以JSON格式发送）
  final body = jsonEncode(<String, String>{
    'email': email,
    'password': password,
  });

  // 发送POST请求
  final response = await http.post(url, headers: headers, body: body);

  // 解析响应数据
  return jsonDecode(response.body)["message"];
}
