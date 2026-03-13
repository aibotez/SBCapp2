import 'package:flutter/material.dart';


Widget _getFileIcon(FileNode item) {
  IconData iconData;
  Color color;
  Color bgColor;

  if (item.isDir) {
    iconData = Icons.folder;
    color = Colors.blue;
    bgColor = Colors.blue.shade50;
  } else {
    switch (item.fileType) {
      case FileType.pdf:
        iconData = Icons.picture_as_pdf;
        color = Colors.redAccent;
        bgColor = Colors.red.shade50;
        break;
      case FileType.image:
        iconData = Icons.image;
        color = Colors.purpleAccent;
        bgColor = Colors.purple.shade50;
        break;
      case FileType.video:
        iconData = Icons.movie;
        color = Colors.green;
        bgColor = Colors.green.shade50;
        break;
      default:
        iconData = Icons.insert_drive_file;
        color = Colors.grey;
        bgColor = Colors.grey.shade100;
        break;
    }
  }

  return Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(iconData, size: 32, color: color),
  );
}