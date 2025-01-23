import 'package:flutter/material.dart';
import '../../domain/entities/action_sheet_config.dart';
import '../../domain/entities/action_sheet_item.dart';
import '../../domain/enums/sheet_position.dart';
import '../widgets/custom_action_sheet.dart';

class ActionSheetService {
  static Future<T?> showCustomSheet<T>({
    required BuildContext context,
    required WidgetBuilder builder,
    ActionSheetConfig? config,
  }) {
    final effectiveConfig = config ?? const ActionSheetConfig();

    return showGeneralDialog(
      context: context,
      useRootNavigator: effectiveConfig.useRootNavigator,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Material(
          type: MaterialType.transparency,
          child: SafeArea(
            child: GestureDetector(
              onTap: effectiveConfig.dismissOnTapOutside
                  ? () => Navigator.of(context).pop()
                  : null,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: effectiveConfig.barrierColor ?? Colors.black54,
                child: GestureDetector(
                  onTap: () {}, // 防止点击内容区域时关闭
                  child: _buildPositionedDialog(
                    position: effectiveConfig.position,
                    origin: effectiveConfig.origin,
                    animation: animation,
                    config: effectiveConfig,
                    child: builder(context),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      barrierDismissible: effectiveConfig.dismissOnTapOutside,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.transparent,
      transitionDuration: effectiveConfig.animationDuration,
    );
  }

  static Widget _buildPositionedDialog({
    required SheetPosition position,
    required Animation<double> animation,
    required Widget child,
    required ActionSheetConfig config,
    Offset? origin,
  }) {
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: config.animationCurve,
    );

    Widget positionedChild = Container(
      width: config.width,
      height: config.height,
      padding: config.padding,
      decoration: config.decoration,
      child: child,
    );

    // 包装在 Material 中以确保正确的主题和阴影效果
    positionedChild = Material(
      type: MaterialType.transparency,
      child: positionedChild,
    );

    // 添加 Stack 作为根布局
    return Stack(
      children: [
        switch (position) {
          SheetPosition.top =>
            _buildTopSheet(curvedAnimation, positionedChild, origin),
          SheetPosition.center =>
            _buildCenterSheet(curvedAnimation, positionedChild, origin),
          SheetPosition.bottom =>
            _buildBottomSheet(curvedAnimation, positionedChild, origin),
        },
      ],
    );
  }

  static Widget _buildTopSheet(
    Animation<double> animation,
    Widget child,
    Offset? origin,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (origin != null) {
          return Positioned(
            left: origin.dx,
            top: origin.dy,
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.5),
                  end: Offset.zero,
                ).animate(animation),
                child: child!,
              ),
            ),
          );
        }

        return Align(
          alignment: Alignment.topCenter,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(animation),
            child: child!,
          ),
        );
      },
      child: child,
    );
  }

  static Widget _buildCenterSheet(
    Animation<double> animation,
    Widget child,
    Offset? origin,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (origin != null) {
          return Positioned(
            left: origin.dx,
            top: origin.dy,
            child: FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child!,
              ),
            ),
          );
        }

        return Center(
          child: ScaleTransition(
            scale: animation,
            child: FadeTransition(
              opacity: animation,
              child: child!,
            ),
          ),
        );
      },
      child: child,
    );
  }

  static Widget _buildBottomSheet(
    Animation<double> animation,
    Widget child,
    Offset? origin,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        if (origin != null) {
          return Positioned(
            left: origin.dx,
            bottom: origin.dy,
            child: FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(animation),
                child: child!,
              ),
            ),
          );
        }

        return Align(
          alignment: Alignment.bottomCenter,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation),
            child: child!,
          ),
        );
      },
      child: child,
    );
  }

  static Future<T?> show<T>({
    required BuildContext context,
    required List<ActionSheetItem> items,
    required SheetPosition position,
    String? title,
  }) {
    return showCustomSheet(
      context: context,
      config: ActionSheetConfig(
        position: position,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      builder: (context) => CustomActionSheet(
        items: items,
        title: title,
      ),
    );
  }
}
