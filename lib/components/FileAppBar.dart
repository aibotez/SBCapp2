

PreferredSizeWidget buildAppBar() {
  return _isSelectionMode
      ? _buildSelectionAppBar()
      : _buildNormalAppBar();
}

Widget _buildNormalAppBar() {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ),
    title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    actions: [
      IconButton(icon: const Icon(Icons.import_export), onPressed: () {}),
      IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () {}),
    ],
  );
}

Widget _buildSelectionAppBar() {
  return AppBar(
    leading: IconButton(icon: const Icon(Icons.close), onPressed: _toggleSelectionMode),
    title: Text("已选 ${_selectedIndices.length} 项", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
    actions: [
      TextButton(
        onPressed: _toggleSelectAll,
        child: Text(_selectedIndices.length == _files.length ? "取消全选" : "全选"),
      ),
    ],
  );
}