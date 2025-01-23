import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/action_sheet_item.dart';
import '../providers/action_sheet_provider.dart';

class CustomActionSheet extends ConsumerWidget {
  final List<ActionSheetItem> items;
  final String? title;

  const CustomActionSheet({
    Key? key,
    required this.items,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final position = ref.watch(actionSheetPositionProvider);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
          ],
          ...items.map((item) => _buildActionItem(context, item)).toList(),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, ActionSheetItem item) {
    return ListTile(
      leading: item.icon != null ? Icon(item.icon) : null,
      title: Text(item.title),
      onTap: () {
        Navigator.of(context).pop();
        item.onTap();
      },
    );
  }
}
