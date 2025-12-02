import 'package:flutter/material.dart';

class FilesPage extends StatelessWidget {
  const FilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("文件")),
      body: const Center(
        child: Text(
          "这里是文件页面",
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }
}
