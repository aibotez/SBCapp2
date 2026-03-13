import 'package:flutter/material.dart';
import '../models/file_node.dart';
import '../services/file_service.dart';
import '../components/FileAppBar.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  @override

  final bool isSelectionMode = false;
  final String title="1";
  final bool showBack = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FileAppBar(isSelectionMode:isSelectionMode,title:title,showBack:showBack),
    );
  }
}
