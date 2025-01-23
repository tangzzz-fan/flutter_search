// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search/features/auth/presentation/screens/login_screen.dart';
import 'features/search/presentation/widgets/search_widget.dart';
import 'features/action_sheet/presentation/screens/action_sheet_demo_screen.dart';
import 'features/action_sheet/presentation/screens/custom_action_sheet_demo_screen.dart';
import 'features/dio_example/presentation/screens/dio_demo_screen.dart';
import 'features/article/presentation/screens/article_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('功能演示'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.search),
            title: const Text('搜索功能'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SearchWidget()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.menu),
            title: const Text('Action Sheet'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ActionSheetDemoScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard_customize),
            title: const Text('Custom Action Sheet'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => const CustomActionSheetDemoScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.http),
            title: const Text('Dio 示例'),
            subtitle: const Text('网络请求演示'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DioDemoScreen()),
            ),
          ),
          // 在 main.dart 中添加路由
          ListTile(
            leading: const Icon(Icons.login),
            title: const Text('Auth Demo'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => LoginScreen()),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.article),
            title: const Text('Articles'),
            subtitle: const Text('Clean Architecture Demo'),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ArticleListScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
