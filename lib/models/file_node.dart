class FileNode {
  final int id;
  final String name;
  final bool isDir;
  final int? parent_id;
  final String? size;
  final String date;
  final String fileType;

  FileNode({
    required this.id,
    required this.name,
    required this.isDir,
    required this.date,
    required this.fileType,
    this.parent_id,
    this.size,
  });

  factory FileNode.fromJson(Map<String, dynamic> json) {
    return FileNode(
      id: json["id"],
      name: json["name"],
      isDir: json["is_dir"],
      parent_id: json["parent_id"],
      size: json["size_str"],
      date: json["date"],
      fileType: json["fileType"],

    );
  }
}