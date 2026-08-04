import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/wire/hexagonal_wire.dart';
import 'package:measurements/pages/wire/octagonal_wire.dart';
import 'package:measurements/pages/wire/re_enforced_bar.dart';
import 'package:measurements/pages/wire/rectangle_wire.dart';
import 'package:measurements/pages/wire/round_wire.dart';
import 'package:measurements/pages/wire/square_wire.dart';
import 'package:measurements/pages/wire/swg_to_mm_screen.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class WireProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.hexagonalWire, image: AppAssets.hexagonalWire),
    MeshItem(title: AppString.octagonalWire, image: AppAssets.octagonalWire),
    MeshItem(title: AppString.reEnforcedBar, image: AppAssets.reEnforcedBar),
    MeshItem(title: AppString.rectangleWire, image: AppAssets.rectangleWire),
    MeshItem(title: AppString.roundWire, image: AppAssets.roundWire),
    MeshItem(title: AppString.squareWire, image: AppAssets.squareWire),
    MeshItem(title: AppString.swgToMm, image: AppAssets.swgToMm),
  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.hexagonalWire:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HexagonalWireScreen(meshItem: meshItem)));
        break;
      case AppString.octagonalWire:
        Navigator.push(context, MaterialPageRoute(builder: (_) => OctagonalWireScreen(meshItem: meshItem)));
        break;
      case AppString.reEnforcedBar:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ReEnforcedBarScreen(meshItem: meshItem)));
        break;
      case AppString.rectangleWire:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangleWireScreen(meshItem: meshItem)));
        break;
      case AppString.roundWire:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RoundWireScreen(meshItem: meshItem)));
        break;
      case AppString.squareWire:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SquareWireScreen(meshItem: meshItem)));
        break;
      case AppString.swgToMm:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SwgToMmScreen(meshItem: meshItem)));
        break;
    }
  }
}
