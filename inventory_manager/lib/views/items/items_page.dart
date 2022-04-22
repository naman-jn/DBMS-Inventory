import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_manager/data/json_list_souce.dart';
import 'package:inventory_manager/main.dart';
import 'package:inventory_manager/models/item/item.model.dart';
import 'package:inventory_manager/views/items/providers/item.provider.dart';
import 'package:inventory_manager/widgets/scroll_up_button.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class ItemListPage extends ConsumerStatefulWidget {
  const ItemListPage({Key? key}) : super(key: key);

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends ConsumerState<ItemListPage> {
  List<Item> filteredItemList = [];
  List<Item> itemsList = [];
  final ScrollController _controller = ScrollController();

  _filterItemList(String text) {
    // if (text.isEmpty) {
    //   setState(() {
    //     filteredItemList = questionsList;
    //   });
    // } else {
    //   List<Item> filteredItems = [];
    //   try {
    //     for (Item question in questionsList) {
    //       if (question.title
    //           .toUpperCase()
    //           .contains(text.toString().toUpperCase())) {
    //         filteredItems.add(question);
    //       }
    //     }
    //   } on Exception {
    //     filteredItemList = [];
    //   }
    //   setState(() {
    //     filteredItemList = filteredItems;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    var itemNotifier = ref.watch(item_repository_provider);

    return itemNotifier.when(
        data: (data) => _onDataLoaded(data),
        error: (error, stackTrace) =>
            const Center(child: Text('Some error Occured!')),
        loading: () => const Center(child: CircularProgressIndicator()));
  }

  Widget _onDataLoaded(List<Item> data) {
    //initialize data to `questionsList`
    itemsList = data;

    logger.d(itemsList);

    //add all questions to `filteredItemList` when it's empty
    if (filteredItemList.isEmpty && itemsList.isNotEmpty) {
      filteredItemList = itemsList;
    }

    //show no questions when even `questionsList` is empty
    if (itemsList.isEmpty) {
      return const Center(
        child: Text("No Items"),
      );
    }

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Consumer(
        builder: (_, instance, __) {
          return Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search by question title",
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.indigo.shade900)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.indigo.shade900.withOpacity(0.6),
                      ),
                    ),
                  ),
                  onChanged: (text) {
                    _filterItemList(text);
                  },
                ),
              ),
              Expanded(
                child: Theme(
                  data: Theme.of(context).copyWith(cardColor: Colors.blue[50]),
                  child: Stack(
                    children: [
                      PaginatedDataTable2(
                        scrollController: _controller,
                        rowsPerPage: 20,
                        source: JsonItemData(
                          context: context,
                          filteredItemList: filteredItemList,
                        ),
                        columnSpacing: 12,
                        horizontalMargin: 52,
                        sortColumnIndex: 2,
                        minWidth: 900,
                        columns: const [
                          DataColumn2(
                            label: Text('Id'),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Text('Name'),
                            size: ColumnSize.L,
                          ),
                          DataColumn2(
                            label: Text('Brand'),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Text('Price'),
                            size: ColumnSize.S,
                          ),
                          DataColumn2(
                            label: Text('Category'),
                            size: ColumnSize.S,
                          ),
                        ],
                      ),
                      ScrollUpButton(_controller)
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
