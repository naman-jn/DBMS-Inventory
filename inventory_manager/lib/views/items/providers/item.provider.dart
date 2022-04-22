import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventory_manager/apiHelper.dart';
import 'package:inventory_manager/models/item/item.model.dart';

final item_repository_provider =
    StateNotifierProvider<Items, AsyncValue<List<Item>>>((ref) {
  return Items(
    read: ref.read,
  );
});

class Items extends StateNotifier<AsyncValue<List<Item>>> {
  final Reader read;

  Items({
    required this.read,
  }) : super(
          const AsyncLoading(),
        ) {
    _initDB();
  }

  Future<void> _initDB() async {
    List<Item> items = await _fetchItem();
    state = AsyncData(items);
  }

  Future<void> refresh() async {
    List<Item> items = await _fetchItem();
    state = AsyncData(items);
  }

  _fetchItem() async {
    final responseJson =
        // await ApiHelper.getRequestWithoutToken('items/$itemsSlug');
        await ApiHelper.getRequest('items');

    final List _itemsRaw = responseJson;
    final _items = _itemsRaw.map((e) => Item.fromJson(e)).toList();

    return _items;
  }
}
