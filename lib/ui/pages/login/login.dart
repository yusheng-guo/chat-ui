import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF00008B),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.settings), onPressed: () {})
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
            Positioned(
              child: ClipPath(
                clipper: CustomLoginShapeClipper1(),
                child: Container(
                  height: heightOfScreen,
                  decoration: const BoxDecoration(
                    color: Color(0xFFDAD0D3),
                  ),
                ),
              ),
            ),
            Positioned(
              child: ClipPath(
                clipper: CustomLoginShapeClipper2(),
                child: Container(
                  height: heightOfScreen,
                  decoration: const BoxDecoration(
                    color: Color(0xFF00008B),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 36),
              child: ListView(
                children: <Widget>[
                  //10% of the height of screen
                  SizedBox(height: heightOfScreen * 0.075),
                  const IntroText(),
                  const SizedBox(height: 8),
                  LogInForm(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// 登录形状
class CustomLoginShapeClipper1 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.85);

    var firstEndpoint = Offset(size.width, size.height * 0.7);
    var firstControlPoint = Offset(size.width * 0.6, size.height * 0.85);

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

// 登录形状2
class CustomLoginShapeClipper2 extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height * 0.5);

    var firstEndpoint = Offset(size.width, size.height * 0.25);
    var firstControlPoint = Offset(size.width * 0.75, size.height * 0.5);

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
    TextTheme textTheme = Theme.of(context).textTheme;
    double heightOfScreen = MediaQuery.of(context).size.height;
    return ListBody(
      children: <Widget>[
        const Text(
          "Welcome",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Back!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Hey! Good to see you again.",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: heightOfScreen * 0.075),
        const Text(
          "Log in",
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

// 登录表单
class LogInForm extends StatefulWidget {
  LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Username: $_username, Password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Please enter your email.';
              }
              return null;
            },
            onSaved: (value) {
              if (value != null) {
                _username = value.trim();
              }
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
              if (value?.isEmpty == true) {
                return 'Please enter your password.';
              }
              return null;
            },
            onSaved: (value) {
              if (value != null) {
                _password = value.trim();
              }
            },
          ),
          const SizedBox(height: 16.0),
          MaterialButton(
            onPressed: _submitForm,
            child: const Text('Log In'),
          ),
        ],
      ),
    );
  }
}
