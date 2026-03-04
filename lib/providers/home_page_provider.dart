import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/chain_link/chain_link.dart';
import 'package:measurements/pages/expanded_metal/expanded_metal.dart';
import 'package:measurements/pages/hexagonal_wiremesh/hexagonal_wiremesh.dart';
import 'package:measurements/pages/welded_wiremesh/weight_per_role.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class HomePageProvider with ChangeNotifier {
  bool isGridView = true;
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.weightPerRole, image: AppAssets.weightPerRole),
    MeshItem(title: AppString.chainLink, image: AppAssets.chainLink),
    MeshItem(title: AppString.expandedMetal, image: AppAssets.expandedMetal),
    MeshItem(title: AppString.hexagonalWiremesh, image: AppAssets.hexagonalWiremesh),
  ];
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

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.chainLink:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ChainLinkScreen(item: meshItem)));
        break;
      case AppString.weightPerRole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRole(meshItem: meshItem)));
        break;
      case AppString.expandedMetal:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ExpandedMetal(item: meshItem)));
        break;
      case AppString.hexagonalWiremesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HexagonalWiremesh(item: meshItem)));
        break;
    }
  }
}
