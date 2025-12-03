import 'package:flutter/material.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FilesPage> {
  int _selectedIndex = 1; // 默认选中"文件"

  // --- 多选模式状态 ---
  bool _isSelectionMode = false;
  final Set<int> _selectedIndices = {};

  // 模拟文件数据
  final List<FileItem> _files = [
    FileItem(name: "新建", date: "昨天 13:41", isFolder: true),
    FileItem(name: "doc_1761822872509.pdf", date: "2025/11/29 20:49", size: "239.38 KB", fileType: FileType.pdf),
    FileItem(name: "Screenshot_20251129_204901_com.trim.app.jpg", date: "2025/11/29 20:49", size: "315.74 KB", fileType: FileType.image),
  ];

  // --- 逻辑方法 ---

  // 切换到底部导航栏某一项
  void _onItemTapped(int index) {
    if (_isSelectionMode) return; // 选择模式下禁止切换 tab
    setState(() {
      _selectedIndex = index;
    });
  }

  // 进入/退出选择模式
  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      _selectedIndices.clear(); // 退出或进入时清空选择
    });
  }

  // 切换单个文件的选中状态
  void _toggleItemSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  // 全选/取消全选
  void _toggleSelectAll() {
    setState(() {
      if (_selectedIndices.length == _files.length) {
        _selectedIndices.clear();
      } else {
        // 全选所有索引
        _selectedIndices.addAll(List.generate(_files.length, (index) => index));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // 动态构建 AppBar
    PreferredSizeWidget buildAppBar() {
      if (_isSelectionMode) {
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: _toggleSelectionMode,
          ),
          title: Text(
            "已选 ${_selectedIndices.length} 项",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          actions: [
            TextButton(
              onPressed: _toggleSelectAll,
              child: Text(
                _selectedIndices.length == _files.length ? "取消全选" : "全选",
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            const SizedBox(width: 8),
          ],
        );
      } else {
        return AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          title: const Text(
            "测试",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: false,
          titleSpacing: 0,
          actions: [
            IconButton(icon: const Icon(Icons.import_export), onPressed: () {}),
            IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () {}),
            const SizedBox(width: 8),
          ],
        );
      }
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          // 1. 搜索框区域
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 12),
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Text("搜索", style: TextStyle(color: Colors.grey, fontSize: 16)),
                ],
              ),
            ),
          ),

          // 2. 列表区域
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  // 2.1 筛选/排序头
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      children: [
                        const Text(
                          "按文件名",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_upward, size: 16, color: Colors.grey),
                        const Spacer(),
                        const Icon(Icons.grid_view, color: Colors.black54),
                        const SizedBox(width: 16),
                        // 点击这个图标进入多选模式
                        InkWell(
                          // 修改此处：移除 null 判断，允许点击切换回正常模式
                          onTap: _toggleSelectionMode,
                          child: Icon(
                            _isSelectionMode ? Icons.check_box : Icons.check_box_outlined,
                            color: _isSelectionMode ? Colors.blue : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2.2 文件列表
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        return _buildFileItem(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // 根据模式切换底部栏
      bottomNavigationBar: _isSelectionMode ? _buildSelectionBottomBar() : null,
    );
  }

  // --- 正常模式的底部导航 ---
  Widget _buildNormalBottomBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedFontSize: 12,
      unselectedFontSize: 12,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'FN'),
        BottomNavigationBarItem(icon: Icon(Icons.folder), label: '文件'),
        BottomNavigationBarItem(icon: Icon(Icons.cloud_download_outlined), label: '下载'),
        BottomNavigationBarItem(icon: Icon(Icons.movie_outlined), label: '影视'),
        BottomNavigationBarItem(icon: Icon(Icons.photo_outlined), label: '相册'),
      ],
    );
  }

  // --- 多选模式的操作栏 ---
  Widget _buildSelectionBottomBar() {
    return Container(
      height: 80, // 比普通导航栏稍高
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionItem(Icons.download_outlined, "下载"),
          _buildActionItem(Icons.share_outlined, "分享"),
          _buildActionItem(Icons.delete_outline, "删除"),
          _buildActionItem(Icons.drive_file_move_outline, "移动"),
          _buildActionItem(Icons.copy_outlined, "复制"),
          _buildActionItem(Icons.folder_zip_outlined, "压缩"), // 假设最后被截断的是压缩
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return InkWell(
      onTap: () {}, // 点击操作逻辑
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

  // --- 构建文件列表项 ---
  Widget _buildFileItem(int index) {
    final item = _files[index];
    final isSelected = _selectedIndices.contains(index);

    return InkWell(
      onTap: () {
        if (_isSelectionMode) {
          _toggleItemSelection(index);
        } else {
          // 正常点击逻辑，比如打开文件
          print("Opening ${item.name}");
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // 图标
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: _getFileIcon(item),
            ),
            const SizedBox(width: 16),

            // 信息区域
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(item.date, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      if (item.size != null) ...[
                        const SizedBox(width: 8),
                        Text(item.size!, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // 根据模式显示不同尾部组件
            if (_isSelectionMode)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.blue : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.grey.shade400,
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              )
            else
              IconButton(
                icon: Icon(Icons.more_horiz, color: Colors.grey[400]),
                onPressed: () {},
              ),
          ],
        ),
      ),
    );
  }

  Widget _getFileIcon(FileItem item) {
    if (item.isFolder) {
      return const Icon(Icons.folder, size: 48, color: Color(0xFF42A5F5));
    }
    switch (item.fileType) {
      case FileType.pdf:
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8)
          ),
          child: const Icon(Icons.picture_as_pdf, size: 32, color: Colors.redAccent),
        );
      case FileType.image:
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.purple[50],
              borderRadius: BorderRadius.circular(8)
          ),
          child: const Icon(Icons.image, size: 32, color: Colors.purpleAccent),
        );
      default:
        return const Icon(Icons.insert_drive_file, size: 48, color: Colors.grey);
    }
  }
}

enum FileType { other, pdf, image }

class FileItem {
  final String name;
  final String date;
  final String? size;
  final bool isFolder;
  final FileType fileType;

  FileItem({
    required this.name,
    required this.date,
    this.size,
    this.isFolder = false,
    this.fileType = FileType.other,
  });
}