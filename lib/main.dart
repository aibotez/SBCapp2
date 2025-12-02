import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/files_page.dart';
import 'pages/my_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _currentIndex = 0;

  final List<BottomNavigationBarItem> bottomTabs = <BottomNavigationBarItem>[
    //图标列表
    const BottomNavigationBarItem(
      backgroundColor: Colors.white70,
      icon: Icon(Icons.home),
      label: '首页'),
    const BottomNavigationBarItem(
      backgroundColor: Colors.white70,
      icon: Icon(Icons.folder),
      label: '文件'),
    const BottomNavigationBarItem(
      backgroundColor: Colors.white70,
      icon: Icon(Icons.person),
      label: '我的'),
  ];

  final List<Widget> _pages = const [
    HomePage(),
    FilesPage(),
    MyPage(),
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 14,
        unselectedFontSize: 13,
        elevation: 8,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,//if more than 4
        items: bottomTabs,

        onTap: (index) {setState(() {_currentIndex = index;});},

      ),

    );
  }
}
