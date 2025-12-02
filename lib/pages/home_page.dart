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
        backgroundColor: const Color.fromARGB(255, 232, 237, 255),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
              child: Container(
                color: const Color.fromARGB(255, 232, 237, 255),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: const Color(0x00e8edff),
                        child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('基本状态', style: TextStyle(fontSize: 18)),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text('已连接'),
                                      SizedBox(width: 10),
                                      Text('P2P连接 | ****'),
                                    ],
                                  ),
                                ],
                              ),
                              Image(image: AssetImage('assets/images/NASicon1.png'), width: 100, height: 100),
                            ]
                        ),
                      ),
                      const SizedBox(height: 20),
                      //图标网格
                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 1,
                          crossAxisSpacing: 0,
                          childAspectRatio: 1,
                        ),
                        children: [
                          _buildIcon(Icons.folder, '文件管理'),
                          // _buildIcon(Icons.movie, '影视'),
                          _buildIcon(Icons.photo, '相册'),
                          _buildIcon(Icons.downloading, '传输任务'),
                          _buildIcon(Icons.backup, '备份'),
                          _buildIcon(Icons.settings, '系统设置'),
                          _buildIcon(Icons.show_chart, '资源监控'),
                          _buildIcon(Icons.list_alt, '日志'),
                          _buildIcon(Icons.store, '应用中心'),
                          _buildIcon(Icons.apps, '更多'),
                        ],

                      ),
                      const SizedBox(height: 20),
                      Container(

                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255), // 背景颜色
                          borderRadius: BorderRadius.circular(20.0), // 圆角半径
                        ),
                        // color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: const Text('资源监控', style: TextStyle(fontSize: 18)),
                            ),

                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildCircleStat('CPU', '1%'),
                                _buildCircleStat('内存', '60%'),

                              ],
                            ),
                            const SizedBox(height: 20),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     _buildInfoBox('网络', '↑ 408 B/s\n↓ 592 B/s'),
                            //     _buildInfoBox('硬盘', '读 0 B/s\n写 0 B/s'),
                            //     _buildInfoBox('温度', 'CPU -'),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      // 资源监控部分

                    ],
                  ),
                ),
              ),
          ),
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
            const SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                backgroundColor:  Color.fromARGB(100, 189, 189, 189),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.indigoAccent),
                // Color.fromARGB(100, 19, 66, 225),
                value: 0.6,
                strokeWidth: 8,
              ),
            ),
            Text(value),
          ],
        ),
        const SizedBox(height: 10),
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