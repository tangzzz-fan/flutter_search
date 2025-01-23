// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/search/presentation/widgets/search_widget.dart';
import 'features/action_sheet/presentation/screens/action_sheet_demo_screen.dart';
import 'features/action_sheet/presentation/screens/custom_action_sheet_demo_screen.dart';

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
        ],
      ),
    );
  }
}
