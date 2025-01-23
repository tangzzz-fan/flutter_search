import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/enums/sheet_position.dart';

final actionSheetPositionProvider =
    StateProvider<SheetPosition>((ref) => SheetPosition.bottom);

final actionSheetVisibilityProvider = StateProvider<bool>((ref) => false);
