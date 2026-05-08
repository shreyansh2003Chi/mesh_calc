import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/chain_link/chain_link.dart';
import 'package:measurements/pages/expanded_metal/expanded_metal.dart';
import 'package:measurements/pages/hexagonal_wiremesh/hexagonal_wiremesh.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/capsule_center_to_center_hall.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/open_area_calculation.dart';
import 'package:measurements/pages/welded_wiremesh/weight_per_role.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class PerforatedSheetProvider with ChangeNotifier {
  bool isGridView = true;
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.openAreaCalculation, image: AppAssets.openAreaCalculation),
    MeshItem(title: AppString.weightPerRoll, image: AppAssets.weightPerRoll),
    MeshItem(title: AppString.weightPerOd, image: AppAssets.weightPerOd),
    MeshItem(title: AppString.weightPerOdLessId, image: AppAssets.weightPerOdLessId),
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
