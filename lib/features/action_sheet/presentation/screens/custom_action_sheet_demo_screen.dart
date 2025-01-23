import 'package:flutter/material.dart';
import '../../domain/entities/action_sheet_config.dart';
import '../../domain/enums/sheet_position.dart';
import '../services/action_sheet_service.dart';

class CustomActionSheetDemoScreen extends StatelessWidget {
  const CustomActionSheetDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Custom Action Sheet Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 示例1：从按钮位置弹出的菜单
            Builder(
              builder: (context) => ElevatedButton(
                onPressed: () => _showButtonActionSheet(context),
                child: const Text('从按钮弹出'),
              ),
            ),

            const SizedBox(height: 20),

            // 示例2：自定义内容的中心弹窗
            ElevatedButton(
              onPressed: () => _showCustomContentSheet(context),
              child: const Text('自定义内容'),
            ),

            const SizedBox(height: 20),

            // 示例3：自定义样式的底部菜单
            ElevatedButton(
              onPressed: () => _showStyledBottomSheet(context),
              child: const Text('自定义样式'),
            ),
          ],
        ),
      ),
    );
  }

  void _showButtonActionSheet(BuildContext context) {
    // 获取按钮的位置和大小
    final RenderBox button = context.findRenderObject() as RenderBox;
    final position = button.localToGlobal(Offset.zero);
    final size = button.size;

    ActionSheetService.showCustomSheet(
      context: context,
      config: ActionSheetConfig(
        position: SheetPosition.top,
        origin: Offset(position.dx, position.dy + size.height),
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('编辑'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('删除'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  void _showCustomContentSheet(BuildContext context) {
    ActionSheetService.showCustomSheet(
      context: context,
      config: ActionSheetConfig(
        position: SheetPosition.center,
        width: 300,
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      builder: (context) => Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '自定义内容示例',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) => ListTile(
                title: Text('Item $index'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('关闭'),
            ),
          ),
        ],
      ),
    );
  }

  void _showStyledBottomSheet(BuildContext context) {
    ActionSheetService.showCustomSheet(
      context: context,
      config: const ActionSheetConfig(
        position: SheetPosition.bottom,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '自定义样式示例',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
              ),
              onPressed: () => Navigator.pop(context),
              child: const Text('关闭'),
            ),
          ],
        ),
      ),
    );
  }
}
