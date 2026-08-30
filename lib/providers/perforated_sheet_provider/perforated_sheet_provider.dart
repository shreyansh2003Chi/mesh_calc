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

import '../../pages/perforated_sheet/weight_per_roll/weight_per_roll.dart';
import '../../pages/perforated_sheet/weight_per_od/weight_per_od.dart';
import '../../pages/perforated_sheet/weight_per_od_less_id/weight_per_od_less_id.dart';

class PerforatedSheetProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.openAreaCalculation, image: AppAssets.openAreaCalculation),
    MeshItem(title: AppString.weightPerRoll, image: AppAssets.weightPerRoll),
    MeshItem(title: AppString.weightPerOd, image: AppAssets.weightPerOd),
    MeshItem(title: AppString.weightPerOdLessId, image: AppAssets.weightPerOdLessId),
  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.openAreaCalculation:
        Navigator.push(context, MaterialPageRoute(builder: (_) => OpenAreaCalculation()));
        break;
      case AppString.weightPerRoll:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRoll()));
        break;
      case AppString.weightPerOd:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerOd()));
        break;
      case AppString.weightPerOdLessId:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerOdLessId()));
        break;
    }
  }
}
