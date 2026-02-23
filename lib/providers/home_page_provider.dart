import 'package:flutter/cupertino.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class HomePageProvider with ChangeNotifier {
  bool isGridView = true;
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [MeshItem(title: AppString.weightPerRole, image: AppAssets.weightPerRole), MeshItem(title: AppString.chainLink, image: AppAssets.chainLink)];
  List<MeshItem> filteredItems = [];

  void init() {
    filteredItems = allItems;
    notifyListeners();
  }

  void changeView() {
    isGridView = !isGridView;
    notifyListeners();
  }

  void clearFilter() {
    searchController.clear();
    filter("");
    notifyListeners();
  }

  void filter(String query) {
    filteredItems = [];

    if (query.isEmpty) {
      filteredItems = List.from(allItems);
    } else {
      for (int i = 0; i < allItems.length; i++) {
        if (allItems[i].title.toLowerCase().contains(query.toLowerCase())) {
          filteredItems.add(allItems[i]);
        }
      }
    }

    notifyListeners();
  }
}
