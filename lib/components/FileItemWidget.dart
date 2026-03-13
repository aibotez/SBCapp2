import 'package:flutter/material.dart';

import '../models/file_node.dart';


class FileItemWidget extends StatelessWidget {
  final FileNode item;
  final bool isSelected;
  final VoidCallback onTap, onLongPress;

  const FileItemWidget({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            _getFileIcon(item),
            const SizedBox(width: 16),
            Expanded(child: _buildFileInfo(item)),
            _buildTrailingWidget(isSelected),
          ],
        ),
      ),
    );
  }

  Widget _getFileIcon(FileNode item) {
    // ...同原逻辑
  }

  Widget _buildFileInfo(FileNode item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        Row(
          children: [
            Text(item.date),
            if (item.size != null && !item.isDir) ...[
              const SizedBox(width: 8),
              Text(item.size!),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildTrailingWidget(bool isSelected) {
    return Container(
      // Selection or More button
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue : Colors.transparent,
        border: Border.all(color: isSelected ? Colors.blue : Colors.grey.shade400),
      ),
      child: isSelected
          ? const Icon(Icons.check, size: 12, color: Colors.white)
          : const Icon(Icons.more_horiz, size: 16, color: Colors.grey),
    );
  }
}