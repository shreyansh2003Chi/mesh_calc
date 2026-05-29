import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/open_area_calculation.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class DutchWovenWireMeshProvider with ChangeNotifier{
  bool isGridView = true;
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.weightPerRoll, image: AppAssets.weightPerRoll2),
    MeshItem(title: AppString.weightPerOd, image: AppAssets.weightPerOd2),
    MeshItem(title: AppString.weightPerOdLessId, image: AppAssets.weightPerOdLessId2),

  ];

  void changeView() {
    isGridView = !isGridView;
    notifyListeners();
  }

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.openAreaCalculation:
        Navigator.push(context, MaterialPageRoute(builder: (_) => OpenAreaCalculation()));
        break;
    }
  }
}