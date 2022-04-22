import 'package:freezed_annotation/freezed_annotation.dart';

part 'item.model.freezed.dart';
part 'item.model.g.dart';

@freezed
class Item with _$Item {
  const Item._();

  const factory Item({
    required int id,
    required String name,
    required String brand,
    required double price,
    required String category,
  }) = _Item;

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
