import 'package:flutter/material.dart';

class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FileManagerPageState();
}

class _FileManagerPageState extends State<FilesPage> {
  int _selectedIndex = 1; // 默认选中"文件" (索引为1)

  // 模拟文件数据
  final List<FileItem> _files = [
    FileItem(
      name: "新建",
      date: "昨天 13:41",
      isFolder: true,
    ),
    FileItem(
      name: "doc_1761822872509.pdf",
      date: "2025/11/29 20:49",
      size: "239.38 KB",
      fileType: FileType.pdf,
    ),
    FileItem(
      name: "Screenshot_20251129_204901_com.trim.app.jpg",
      date: "2025/11/29 20:49",
      size: "315.74 KB",
      fileType: FileType.image,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // --- 顶部 AppBar ---
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {}, // 返回逻辑
        ),
        title: const Text(
          "测试",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false, // Android 风格通常靠左，但截图里看起来稍微靠左
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.import_export), // 排序图标类似物
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add_circle_outline), // 加号图标
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),

      // --- 主体内容 ---
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

          // 2. 列表内容区域（白色背景，顶部圆角效果）
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
                  // 2.1 筛选/排序头 (按文件名, 视图切换, 多选)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: Row(
                      children: [
                        const Text(
                          "按文件名",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_upward, size: 16, color: Colors.grey),
                        const Spacer(),
                        const Icon(Icons.grid_view, color: Colors.black54), // 宫格视图
                        const SizedBox(width: 16),
                        const Icon(Icons.check_box_outlined, color: Colors.black54), // 多选
                      ],
                    ),
                  ),

                  // 2.2 文件列表 ListView
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      itemCount: _files.length,
                      itemBuilder: (context, index) {
                        return _buildFileItem(_files[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),



    );
  }

  // --- 构建单个文件列表项 ---
  Widget _buildFileItem(FileItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // 图标区域
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              // 如果是图片，这里可以放图片缩略图，这里简单用Icon代替
              borderRadius: BorderRadius.circular(8),
            ),
            child: _getFileIcon(item),
          ),
          const SizedBox(width: 16),

          // 文字区域
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
                    Text(
                      item.date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    if (item.size != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        item.size!,
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),

          // 更多操作按钮
          IconButton(
            icon: Icon(Icons.more_horiz, color: Colors.grey[400]),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 根据文件类型返回不同的图标
  Widget _getFileIcon(FileItem item) {
    if (item.isFolder) {
      return const Icon(Icons.folder, size: 48, color: Color(0xFF42A5F5)); // 蓝色文件夹
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
      // 模拟图片缩略图
        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(6),
              // image: const DecorationImage(
              //   // 实际开发中这里用 NetworkImage 或 FileImage
              //     image: NetworkImage("https://via.placeholder.com/150"),
              //     fit: BoxFit.cover
              // )
          ),
          child: const Icon(Icons.image_outlined, size: 32, color: Colors.redAccent),
        );
      default:
        return const Icon(Icons.insert_drive_file, size: 48, color: Colors.grey);
    }
  }
}

// --- 数据模型 ---
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
