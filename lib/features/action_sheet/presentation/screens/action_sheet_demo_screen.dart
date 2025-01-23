import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/action_sheet_item.dart';
import '../../domain/entities/action_sheet_config.dart';
import '../../domain/enums/sheet_position.dart';
import '../services/action_sheet_service.dart';

class ActionSheetDemoScreen extends ConsumerWidget {
  const ActionSheetDemoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Action Sheet Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: '基础示例',
            children: [
              ElevatedButton(
                onPressed: () => _showTopActionSheet(context),
                child: const Text('Show Top Sheet'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showCenterActionSheet(context),
                child: const Text('Show Center Sheet'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showBottomActionSheet(context),
                child: const Text('Show Bottom Sheet'),
              ),
            ],
          ),
          const Divider(height: 32),
          _buildSection(
            title: '自定义示例',
            children: [
              Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () => _showButtonActionSheet(context),
                  child: const Text('从按钮弹出菜单'),
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showInputActionSheet(context),
                child: const Text('带输入框的 Sheet'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showMultiButtonActionSheet(context),
                child: const Text('多按钮 Sheet'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showExpandableSheet(context),
                child: const Text('自适应高度 Sheet'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showMultiStepSheet(context),
                child: const Text('多步骤 Sheet'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
      {required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  void _showTopActionSheet(BuildContext context) {
    ActionSheetService.show(
      context: context,
      position: SheetPosition.top,
      title: '顶部菜单',
      items: _getActionItems(context),
    );
  }

  void _showCenterActionSheet(BuildContext context) {
    ActionSheetService.show(
      context: context,
      position: SheetPosition.center,
      title: '中部菜单',
      items: _getActionItems(context),
    );
  }

  void _showBottomActionSheet(BuildContext context) {
    ActionSheetService.show(
      context: context,
      position: SheetPosition.bottom,
      title: '底部菜单',
      items: _getActionItems(context),
    );
  }

  List<ActionSheetItem> _getActionItems(BuildContext context) {
    return [
      ActionSheetItem(
        title: '选项 1',
        icon: Icons.photo,
        onTap: () => _handleAction(context, '选项 1'),
      ),
      ActionSheetItem(
        title: '选项 2',
        icon: Icons.camera,
        onTap: () => _handleAction(context, '选项 2'),
      ),
      ActionSheetItem(
        title: '选项 3',
        icon: Icons.delete,
        onTap: () => _handleAction(context, '选项 3'),
      ),
    ];
  }

  void _handleAction(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('点击了: $action')),
    );
  }

  void _showButtonActionSheet(BuildContext context) {
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

  void _showInputActionSheet(BuildContext context) {
    final textController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    ActionSheetService.showCustomSheet(
      context: context,
      config: ActionSheetConfig(
        position: SheetPosition.bottom,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '添加备注',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: textController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: '请输入备注内容',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return '请输入内容';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('取消'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() ?? false) {
                          Navigator.pop(context, textController.text);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('提交的内容: ${textController.text}')),
                          );
                        }
                      },
                      child: const Text('确定'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showMultiButtonActionSheet(BuildContext context) {
    ActionSheetService.showCustomSheet(
      context: context,
      config: ActionSheetConfig(
        position: SheetPosition.center,
        width: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.info_outline,
              size: 48,
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              '确认删除该项目？',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '删除后将无法恢复，请谨慎操作',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _showMultiButtonActionSheetStep2(context);
                  },
                  child: const Text('再想想'),
                ),
                FilledButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('已确认删除')),
                    );
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('确定删除'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showMultiButtonActionSheetStep2(BuildContext context) {
    ActionSheetService.showCustomSheet(
      context: context,
      config: const ActionSheetConfig(
        position: SheetPosition.bottom,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '需要帮助吗？',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('查看操作指南'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('联系客服'),
              ),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('关闭'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showExpandableSheet(BuildContext context) {
    final List<String> items = List.generate(30, (index) => '项目 ${index + 1}');
    bool isExpanded = false;
    double currentHeight = 0.3;
    double dragStartHeight = 0.3;

    ActionSheetService.showCustomSheet(
      context: context,
      config: ActionSheetConfig(
        position: SheetPosition.bottom,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
      ),
      builder: (context) {
        final screenHeight = MediaQuery.of(context).size.height;
        final maxHeight = screenHeight * 0.8;
        final minHeight = screenHeight * 0.3;
        final expandThreshold = screenHeight * 0.5; // 展开阈值为屏幕高度的50%

        return StatefulBuilder(
          builder: (context, setState) {
            // 计算当前实际高度
            final currentActualHeight = currentHeight * screenHeight;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 顶部拖动区域
                GestureDetector(
                  onVerticalDragStart: (details) {
                    dragStartHeight = currentHeight;
                  },
                  onVerticalDragUpdate: (details) {
                    final newHeight = currentActualHeight - details.delta.dy;
                    setState(() {
                      // 实时更新高度，实现跟手效果
                      currentHeight =
                          (newHeight / screenHeight).clamp(0.2, 0.8);
                    });
                  },
                  onVerticalDragEnd: (details) {
                    final velocity = details.primaryVelocity ?? 0;
                    final currentActualHeight = currentHeight * screenHeight;

                    setState(() {
                      if (velocity < -500) {
                        // 快速上滑，直接展开
                        currentHeight = 0.8;
                        isExpanded = true;
                      } else if (velocity > 500) {
                        // 快速下滑，直接收起
                        currentHeight = 0.3;
                        isExpanded = false;
                      } else {
                        // 根据当前高度和阈值判断
                        if (currentActualHeight > expandThreshold) {
                          // 超过阈值，展开
                          currentHeight = 0.8;
                          isExpanded = true;
                        } else {
                          // 未超过阈值，收起
                          currentHeight = 0.3;
                          isExpanded = false;
                        }
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isExpanded ? '下滑收起' : '上滑展开',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 内容区域
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  height: currentHeight * screenHeight,
                  child: SingleChildScrollView(
                    physics: isExpanded
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // 固定内容
                        Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.blue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '手势操作说明',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                '• 向上滑动展开全部内容\n'
                                '• 向下滑动收起部分内容\n'
                                '• 快速向下滑动关闭面板\n'
                                '• 点击箭头按钮切换状态',
                              ),
                            ],
                          ),
                        ),
                        // 可滚动列表
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: items.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(items[index]),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('选择了: ${items[index]}')),
                              );
                            },
                          ),
                        ),
                        // 底部留白，确保内容完全滚动
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showMultiStepSheet(BuildContext context) {
    // 1. 声明所有方法
    late final void Function(BuildContext) showStep1;
    late final void Function(BuildContext, String) showStep2;
    late final void Function(BuildContext, String, String) showStep3;

    // 2. 辅助方法实现
    Widget _buildSheetHeader(String title,
        {required int currentStep, required int totalSteps}) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Text(
                  '$currentStep/$totalSteps',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: currentStep / totalSteps,
              backgroundColor: Colors.grey[200],
              color: Colors.blue,
            ),
          ],
        ),
      );
    }

    Widget _buildOptionButton(
      BuildContext context, {
      required IconData icon,
      required String title,
      required String subtitle,
      required VoidCallback onTap,
    }) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.3)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(icon, size: 32, color: Colors.blue),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
      );
    }

    Widget _buildTemplateItem(
      BuildContext context, {
      required String title,
      required VoidCallback onTap,
    }) {
      return ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.description, color: Colors.blue),
        ),
        title: Text(title),
        subtitle: Text('模板描述 $title'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      );
    }

    // 3. 实现步骤方法
    showStep3 = (context, selectedOption, selectedTemplate) {
      ActionSheetService.showCustomSheet(
        context: context,
        config: ActionSheetConfig(
          position: SheetPosition.bottom,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
        ),
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSheetHeader('步骤 3', currentStep: 3, totalSteps: 3),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.7,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '已选择: $selectedOption - $selectedTemplate',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        '设置文档属性',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: '文档名称',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: '文档描述',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('创建成功！')),
                          );
                        },
                        child: const Text('完成'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showStep2(context, selectedOption);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('返回上一步'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    };

    showStep2 = (context, selectedOption) {
      ActionSheetService.showCustomSheet(
        context: context,
        config: ActionSheetConfig(
          position: SheetPosition.bottom,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
        ),
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSheetHeader('步骤 2', currentStep: 2, totalSteps: 3),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '已选择: $selectedOption',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '选择模板',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...List.generate(
                        5,
                        (index) => _buildTemplateItem(
                          context,
                          title: '模板 ${index + 1}',
                          onTap: () {
                            Navigator.pop(context);
                            showStep3(
                                context, selectedOption, '模板 ${index + 1}');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showStep1(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('返回上一步'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    };

    showStep1 = (context) {
      ActionSheetService.showCustomSheet(
        context: context,
        config: ActionSheetConfig(
          position: SheetPosition.bottom,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
        ),
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSheetHeader('步骤 1', currentStep: 1, totalSteps: 3),
            Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        '请选择操作类型',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildOptionButton(
                        context,
                        icon: Icons.edit_document,
                        title: '创建新文档',
                        subtitle: '从空白文档开始',
                        onTap: () {
                          Navigator.pop(context);
                          showStep2(context, '创建新文档');
                        },
                      ),
                      const SizedBox(height: 12),
                      _buildOptionButton(
                        context,
                        icon: Icons.file_upload,
                        title: '导入现有文档',
                        subtitle: '从本地文件导入',
                        onTap: () {
                          Navigator.pop(context);
                          showStep2(context, '导入文档');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    };

    // 4. 启动第一个步骤
    showStep1(context);
  }
}
