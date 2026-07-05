import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/wire_mesh/dutch_woven_wire_mesh/weight_per_od.dart';
import 'package:measurements/pages/wire_mesh/dutch_woven_wire_mesh/weight_per_od_less_id.dart';
import 'package:measurements/pages/wire_mesh/dutch_woven_wire_mesh/weight_per_roll.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class DutchWovenWireMeshProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.weightPerRoll, image: AppAssets.weightPerRoll2),
    MeshItem(title: AppString.weightPerOd, image: AppAssets.weightPerOd2),
    MeshItem(title: AppString.weightPerOdLessId, image: AppAssets.weightPerOdLessId2),
  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.weightPerRoll:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRoll(item: meshItem)));
        break;
      case AppString.weightPerOd:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerOd(item: meshItem)));
        break;
      case AppString.weightPerOdLessId:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerOdLessId(item: meshItem)));
        break;
    }
  }
}
