import 'package:dio/dio.dart';
import '../core/http_client.dart';
import '../models/file_node.dart';

class FileService {
  static Future<List<FileNode>> listFiles({int? ID}) async {
    Response response = await HttpClient.dio.get(
      "/files/list/",
      queryParameters: {
        "id": ID,
      },
    );

    List data = response.data;

    return data.map((e) => FileNode.fromJson(e)).toList();
  }
}