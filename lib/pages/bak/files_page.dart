import 'package:flutter/material.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FilesPage> {
  // --- View Mode State ---
  bool _isGridView = true;

  // --- Selection Mode State ---
  bool _isSelectionMode = false;
  final Set<int> _selectedIndices = {};

  // Mock file data
  final List<FileItem> _files = [
    FileItem(name: "新建文件夹", date: "昨天 13:41", isFolder: true),
    FileItem(name: "doc_1761822872509.pdf", date: "2025/11/29 20:49", size: "239.38 KB", fileType: FileType.pdf),
    FileItem(name: "Screenshot_20251129_204901_com.trim.app.jpg", date: "2025/11/29 20:49", size: "315.74 KB", fileType: FileType.image),
    FileItem(name: "Video_Clip_2025.mp4", date: "2025/11/28 10:00", size: "12.5 MB", fileType: FileType.video),
    FileItem(name: "Work.docx", date: "2025/11/27 09:30", size: "450 KB", fileType: FileType.other),
    FileItem(name: "A_very_long_file_name_that_spans_multiple_lines.txt", date: "2025/11/26 09:00", size: "10 KB", fileType: FileType.other),
  ];

  // --- Logic Methods ---

  // Toggle list view mode (List/Grid)
  void _toggleViewMode() {
    if (!_isSelectionMode) {
      setState(() {
        _isGridView = !_isGridView;
      });
    }
  }

  // Enter/Exit selection mode
  void _toggleSelectionMode() {
    setState(() {
      _isSelectionMode = !_isSelectionMode;
      _selectedIndices.clear(); // Clear selection when exiting
    });
  }

  // Toggle single file selection status
  void _toggleItemSelection(int index) {
    setState(() {
      if (_isSelectionMode) {
        if (_selectedIndices.contains(index)) {
          _selectedIndices.remove(index);

          if (_selectedIndices.isEmpty) {
            _isSelectionMode = false;
          }
        } else {
          _selectedIndices.add(index);
        }
      }
    });
  }

  // Handle file tap in non-selection mode
  void _onFileItemTap(FileItem item) {
    print("Executing action: Open/View details for ${item.name}");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("打开文件: ${item.name}"), duration: const Duration(milliseconds: 800)),
    );
  }

  // Select all/Deselect all
  void _toggleSelectAll() {
    setState(() {
      if (_selectedIndices.length == _files.length) {
        _selectedIndices.clear();
        _isSelectionMode = false;
      } else {
        _selectedIndices.addAll(List.generate(_files.length, (index) => index));
        _isSelectionMode = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamically build AppBar
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
          // 1. Search Bar Area
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

          // 2. List Area
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
                  // 2.1 Filter/Sort Header
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
                        // View Toggle Icon
                        InkWell(
                          onTap: _toggleViewMode,
                          child: Icon(
                            _isGridView ? Icons.list : Icons.grid_view,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Selection Mode Toggle Icon
                        InkWell(
                          onTap: _toggleSelectionMode,
                          child: Icon(
                            _isSelectionMode ? Icons.check_box : Icons.check_box_outlined,
                            color: _isSelectionMode ? Colors.blue : Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 2.2 File List/Grid Rendering
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: _isGridView ? 10.0 : 0.0),
                      child: _isGridView
                          ? GridView.builder(
                        padding: const EdgeInsets.all(10),
                        itemCount: _files.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          // 保持比例不变
                          childAspectRatio: 0.70,
                        ),
                        itemBuilder: (context, index) {
                          return _buildGridItem(index);
                        },
                      )
                          : ListView.builder(
                        padding: const EdgeInsets.only(top: 0),
                        itemCount: _files.length,
                        itemBuilder: (context, index) {
                          return _buildFileItem(index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar 是 Scaffold 的顶级属性
      bottomNavigationBar: _isSelectionMode ? _buildSelectionBottomBar() : null,
    );
  }

  // --- Selection Mode Bottom Bar ---
  Widget _buildSelectionBottomBar() {
    return Container(
      height: 80,
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
          _buildActionItem(Icons.folder_zip_outlined, "压缩"),
        ],
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String label) {
    return InkWell(
      onTap: () {},
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

  // --- List View Item ---
  Widget _buildFileItem(int index) {
    final item = _files[index];
    final isSelected = _selectedIndices.contains(index);

    return InkWell(
      onTap: () {
        if (_isSelectionMode) {
          _toggleItemSelection(index);
        } else {
          _onFileItemTap(item);
        }
      },
      onLongPress: () {
        if (!_isSelectionMode) {
          setState(() {
            _isSelectionMode = true;
            _selectedIndices.add(index);
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: _getFileIcon(item, isGrid: false),
            ),
            const SizedBox(width: 16),

            // Info Area
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
                      if (item.size != null && !item.isFolder) ...[
                        const SizedBox(width: 8),
                        Text(item.size!, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Trailing Widget (Selection/More)
            _buildTrailingWidget(isSelected, index),
          ],
        ),
      ),
    );
  }

  // --- Grid View Item ---
  Widget _buildGridItem(int index) {
    final item = _files[index];
    final isSelected = _selectedIndices.contains(index);

    return InkWell(
      onTap: () {
        if (_isSelectionMode) {
          _toggleItemSelection(index);
        } else {
          _onFileItemTap(item);
        }
      },
      onLongPress: () {
        if (!_isSelectionMode) {
          setState(() {
            _isSelectionMode = true;
            _selectedIndices.add(index);
          });
        }
      },
      child: Container(
        // 移除卡片内边距，使内容更靠近边缘
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            // Add blue border when selected
            border: isSelected && _isSelectionMode
                ? Border.all(color: Colors.blue, width: 2)
                : Border.all(color: Colors.grey.shade200, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ]
        ),
        child: Column(
          // 文本居中显示
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // height: 20,
              padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 4.0),
              alignment: Alignment.topRight,
              child: _buildTrailingWidget(isSelected, index, isGrid: true),
            ),
            Container(
              child: _getFileIcon(item, isGrid: true),
            ),
            // 1. Icon/Thumbnail Area (固定高度的 Stack)
            // SizedBox(
            //   // 固定 Stack 的总高度，需要增加一些高度来容纳更大的图标和留出顶部空间
            //   height: 100,
            //   width: double.infinity,
            //   child: Stack(
            //     // 使用 Alignment.centerLeft 或 centerRight 来防止图标溢出
            //     alignment: Alignment.center,
            //     children: [
            //       // 主要文件图标容器
            //       // 将图标向下移动，避免与右上角的三个点重叠
            //       Positioned(
            //         bottom: 0,
            //         child: _getFileIcon(item, isGrid: true),
            //       ),
            //
            //       // Top-right More/Selection button
            //       // 关键修改：将 top 从 0 调整为 4， right 从 0 调整为 4，并移除边距
            //       Positioned(
            //         top: 4, // 向上贴近顶部
            //         right: 4, // 向右贴近右边
            //         child: _buildTrailingWidget(isSelected, index, isGrid: true),
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(height: 10),

            // 2. File Name (添加水平内边距以避免文本紧贴边缘)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item.name,
                // 关键修改：将最大行数限制为 1，确保文件名不会溢出
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center, // 确保文本自身居中
                style: const TextStyle(fontSize: 13, color: Colors.black87, height: 1),
              ),
            ),

            const SizedBox(height: 2),

            // 3. Date/Size info
            Text(
              item.date,
              textAlign: TextAlign.center, // 确保文本自身居中
              style: TextStyle(fontSize: 10, color: Colors.grey[500]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (item.size != null && !item.isFolder)
              Text(
                item.size!,
                textAlign: TextAlign.center, // 确保文本自身居中
                style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }

  // Trailing Widget: Show selection box or more button based on mode
  Widget _buildTrailingWidget(bool isSelected, int index, {bool isGrid = false}) {
    if (_isSelectionMode) {
      // Selection Mode: Always show selection status
      return Container(
        width: 20,
        height: 20,
        // 关键修改：移除所有可能存在的外部或内部边距，使其紧贴 Positioned 的 top/right
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.blue : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey.shade400,
            width: 1.5,
          ),
        ),
        child: isSelected
            ? const Icon(Icons.check, size: 12, color: Colors.white)
            : null,
      );
    } else {
      // Non-Selection Mode: Show More action icon
      return Container(
        // 关键修改：使用 Container 包装 IconButton 并给它设置背景色和圆角，使其看起来像一个按钮
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(8),
        ),
        width: 24, // 减小宽度，使其更精致
        height: 24, // 减小高度
        child: IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.grey[600],
            size: 16, // 减小图标大小
          ),
          onPressed: () {},
          padding: EdgeInsets.zero, // 移除内边距
          constraints: const BoxConstraints(), // 移除默认的最小约束
        ),
      );
    }
  }

  // Return icon based on file type
  Widget _getFileIcon(FileItem item, {required bool isGrid}) {
    // 保持图标/容器尺寸一致
    // 网格视图下，图标尺寸增大
    double size = isGrid ? 56 : 32;
    double containerSize = isGrid ? 70 : 48;


    // File type icon
    IconData iconData;
    Color color;
    Color bgColor;

    if (item.isFolder) {
      // Folder icon
      iconData = Icons.folder;
      color = Colors.blue;
      bgColor = Colors.blue.shade50;
    }
    else{
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
        case FileType.other:
        default: // Fallback for safety
          iconData = Icons.insert_drive_file;
          color = Colors.grey;
          bgColor = Colors.grey.shade100;
          break;
      }
    }

    // 确保文件图标容器具有明确的尺寸
    return Container(
      width: containerSize,
      height: containerSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8)
      ),
      child: Icon(iconData, size: size, color: color),
    );
  }
}

// --- Data Models ---
enum FileType { other, pdf, image, video }

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