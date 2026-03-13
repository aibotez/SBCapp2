import 'package:flutter/material.dart';


Widget _buildSelectionBottomBar() {
  return SelectionBottomBar(
    selectedIndices: _selectedIndices,
    onDownload: () {},
    onShare: () {},
    onDelete: () {},
    onMove: () {},
    onCopy: () {},
    onCompress: () {},
  );
}

class SelectionBottomBar extends StatelessWidget {
  final Set<int> selectedIndices;
  final VoidCallback onDownload, onShare, onDelete, onMove, onCopy, onCompress;

  const SelectionBottomBar({
    required this.selectedIndices,
    required this.onDownload,
    required this.onShare,
    required this.onDelete,
    required this.onMove,
    required this.onCopy,
    required this.onCompress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, -2), blurRadius: 10),
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionItem(Icons.download_outlined, "下载", onDownload),
          _buildActionItem(Icons.share_outlined, "分享", onShare),
          _buildActionItem(Icons.delete_outline, "删除", onDelete),
          _buildActionItem(Icons.drive_file_move_outline, "移动", onMove),
          _buildActionItem(Icons.copy_outlined, "复制", onCopy),
          _buildActionItem(Icons.folder_zip_outlined, "压缩", onCompress),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.black87),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.black87)),
        ],
      ),
    );
  }
}