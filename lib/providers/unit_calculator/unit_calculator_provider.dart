import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/unit_calculator/length_converter_screen.dart';
import 'package:measurements/pages/unit_calculator/area_converter_screen.dart';
import 'package:measurements/pages/unit_calculator/price_hub_screen.dart';
import 'package:measurements/pages/unit_calculator/weight_converter_screen.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class UnitCalculatorProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.area, image: AppAssets.areaConverter),
    MeshItem(title: AppString.length, image: AppAssets.lengthConverter),
    MeshItem(title: AppString.weight, image: AppAssets.weightConverter),
    MeshItem(title: AppString.price, image: AppAssets.priceConverter),
  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.area:
        Navigator.push(context, MaterialPageRoute(builder: (_) => AreaConverterScreen(meshItem: meshItem)));
        break;
      case AppString.length:
        Navigator.push(context, MaterialPageRoute(builder: (_) => LengthConverterScreen(meshItem: meshItem)));
        break;
      case AppString.weight:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightConverterScreen(meshItem: meshItem)));
        break;
      case AppString.price:
        Navigator.push(context, MaterialPageRoute(builder: (_) => PriceHubScreen(meshItem: meshItem)));
        break;
    }
  }
}
