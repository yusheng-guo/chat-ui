import 'package:flutter/material.dart';
import 'package:talk/data/session.dart';
import 'package:talk/ui/widgets/session/session_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            // 菜单
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 20,
              color: Colors.black,
            ),
            onPressed: () {
              // 搜索
            },
          ),
        ],
        flexibleSpace: const SafeArea(
          child: Center(
            child: Text(
              "Talk",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(), // 回弹效果
        child: Column(
          children: <Widget>[
            ListView.separated(
              itemCount: dialogs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                // return DialogWidget(
                //   name: dialogs[index].name,
                //   text: dialogs[index].text,
                //   image: dialogs[index].image,
                //   time: dialogs[index].time,
                //   unReadMessageCount: dialogs[index].unReadMessageCount,
                // );
                return SessionWidget(s: dialogs[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  // color: Colors.grey[400],
                  height: 1,
                  thickness: 0.2,
                  indent: 80,
                  endIndent: 16,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
