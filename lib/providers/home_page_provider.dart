import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/chain_link/chain_link.dart';
import 'package:measurements/pages/expanded_metal/expanded_metal.dart';
import 'package:measurements/pages/hexagonal_wiremesh/hexagonal_wiremesh.dart';
import 'package:measurements/pages/welded_wiremesh/weight_per_role.dart';
import 'package:measurements/pages/wire_mesh/wire_mesh.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

import '../pages/perforated_sheet/perforated_sheet.dart';
import 'package:measurements/pages/wire/wire_screen.dart';
import 'package:measurements/pages/unit_calculator/unit_calculator_screen.dart';

class HomePageProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.chainLink, image: AppAssets.chainLink),
    MeshItem(title: AppString.expandedMetal, image: AppAssets.expandedMetal),
    MeshItem(title: AppString.hexagonalWiremesh, image: AppAssets.hexagonalWiremesh),
    MeshItem(title: AppString.perforatedSheet, image: AppAssets.perforatedSheet),
    MeshItem(title: AppString.wireMesh, image: AppAssets.wireMesh2),
    MeshItem(title: AppString.wireWire, image: AppAssets.wire),
    MeshItem(title: AppString.unitCalculator, image: AppAssets.unitConverter),
  ];


  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.chainLink:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ChainLinkScreen(item: meshItem)));
        break;
      case AppString.expandedMetal:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ExpandedMetal(item: meshItem)));
        break;
      case AppString.hexagonalWiremesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HexagonalWiremesh(item: meshItem)));
        break;
        case AppString.perforatedSheet:
        Navigator.push(context, MaterialPageRoute(builder: (_) => PerforatedSheet()));
        break;
    case AppString.wireMesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WireMesh()));
        break;
    case AppString.wireWire:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WireScreen()));
        break;
    case AppString.unitCalculator:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const UnitCalculatorScreen()));
        break;
    }
  }
}
