#### 基础用法 - 使用预设样式：

```dart
void showBasicActionSheet(BuildContext context) {
  ActionSheetService.show(
    context: context,
    position: SheetPosition.bottom, // 可选 top, center, bottom
    title: '选择操作',
    items: [
      ActionSheetItem(
        title: '拍照',
        icon: Icons.camera_alt,
        onTap: () => print('拍照'),
      ),
      ActionSheetItem(
        title: '从相册选择',
        icon: Icons.photo_library,
        onTap: () => print('相册'),
      ),
    ],
  );
}
```
#### 自定义内容和样式：
```dart
// 自定义内容和样式
void showCustomActionSheet(BuildContext context) {
  ActionSheetService.showCustomSheet(
    context: context,
    config: ActionSheetConfig(
      position: SheetPosition.bottom,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('自定义内容'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    ),
  );
}
```
#### 从特定位置弹出（比如按钮）：
```dart
// 从按钮位置弹出
Widget buildPopupButton(BuildContext context) {
  return Builder(
    builder: (context) => IconButton(
      icon: const Icon(Icons.more_vert),
      onPressed: () {
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
          builder: (context) => YourCustomContent(),
        );
      },
    ),
  );
}
```
#### 带输入框的表单：
```dart
// 带输入框的表单
Future<String?> showInputActionSheet(BuildContext context) {
  final textController = TextEditingController();
  
  return ActionSheetService.showCustomSheet<String>(
    context: context,
    config: ActionSheetConfig(
      position: SheetPosition.bottom,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: '请输入内容',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, textController.text),
            child: const Text('确定'),
          ),
        ],
      ),
    ),
  );
}

// 使用方式
void onTap() async {
  final result = await showInputActionSheet(context);
  if (result != null) {
    print('输入的内容: $result');
  }
}
```
#### 自适应高度的内容：
```dart
// 自适应高度的内容
void showExpandableActionSheet(BuildContext context) {
  bool isExpanded = false;
  double currentHeight = 0.3;

  ActionSheetService.showCustomSheet(
    context: context,
    config: ActionSheetConfig(
      position: SheetPosition.bottom,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
    ),
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        final screenHeight = MediaQuery.of(context).size.height;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 拖动条
            GestureDetector(
              onVerticalDragUpdate: (details) {
                setState(() {
                  currentHeight = (currentHeight - details.delta.dy / screenHeight)
                      .clamp(0.3, 0.8);
                  isExpanded = currentHeight > 0.5;
                });
              },
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            // 内容
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: currentHeight * screenHeight,
              child: YourScrollableContent(),
            ),
          ],
        );
      },
    ),
  );
}
```

使用 ActionSheetService.show() 显示预设样式的选项列表
使用 ActionSheetService.showCustomSheet() 显示完全自定义的内容
可以通过 ActionSheetConfig 配置各种属性
支持异步操作和返回值
可以结合 StatefulBuilder 实现动态内容