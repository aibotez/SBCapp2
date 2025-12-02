import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Text('Z'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: '搜索',
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () {},
            ),
          ],
        ),
        backgroundColor: Colors.blue[50],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // P2P信息
            Row(
              children: const [
                Text('基础版'),
                SizedBox(width: 10),
                Text('P2P连接 | ****'),
              ],
            ),
            const SizedBox(height: 10),
            const Text('ZZ', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            // 图标网格
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              children: [
                _buildIcon(Icons.folder, '文件管理'),
                _buildIcon(Icons.movie, '影视'),
                _buildIcon(Icons.photo, '相册'),
                _buildIcon(Icons.download, '下载'),
                _buildIcon(Icons.backup, '备份'),
                _buildIcon(Icons.settings, '系统设置'),
                _buildIcon(Icons.show_chart, '资源监控'),
                _buildIcon(Icons.list_alt, '日志'),
                _buildIcon(Icons.store, '应用中心'),
                _buildIcon(Icons.apps, '更多'),
              ],
            ),
            const SizedBox(height: 20),
            // 资源监控部分
            const Text('资源监控', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCircleStat('CPU', '1%'),
                _buildCircleStat('内存', '996.68 MB'),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoBox('网络', '↑ 408 B/s\n↓ 592 B/s'),
                _buildInfoBox('硬盘', '读 0 B/s\n写 0 B/s'),
                _buildInfoBox('温度', 'CPU -'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'FN'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: '文件'),
          BottomNavigationBarItem(icon: Icon(Icons.download), label: '下载'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: '影视'),
          BottomNavigationBarItem(icon: Icon(Icons.photo), label: '相册'),
        ],
      ),
    );
  }

  Widget _buildIcon(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildCircleStat(String label, String value) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: label == 'CPU' ? 0.01 : 0.7,
                strokeWidth: 6,
              ),
            ),
            Text(value),
          ],
        ),
        const SizedBox(height: 5),
        Text(label),
      ],
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title),
          const SizedBox(height: 5),
          Text(value, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
