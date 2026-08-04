import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/unit_calculator/area_to_area_screen.dart';
import 'package:measurements/pages/unit_calculator/area_to_running_screen.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class PriceHubProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.areaToArea, image: AppAssets.areaToArea),
    MeshItem(title: AppString.areaToRunningLength, image: AppAssets.areaToRunning),
  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.areaToArea:
        Navigator.push(context, MaterialPageRoute(builder: (_) => AreaToAreaScreen(meshItem: meshItem)));
        break;
      case AppString.areaToRunningLength:
        Navigator.push(context, MaterialPageRoute(builder: (_) => AreaToRunningScreen(meshItem: meshItem)));
        break;
    }
  }
}
