import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的")),
      body: const Center(
        child: Text(
          "这里是个人页面",
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}
