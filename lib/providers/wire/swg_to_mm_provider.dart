import 'package:flutter/material.dart';

class SwgToMmProvider with ChangeNotifier {
  final Map<String, double> swgToMmMap = {
    '7/0 Gauge': 12.700,
    '6/0 Gauge': 11.786,
    '5/0 Gauge': 10.973,
    '4/0 Gauge': 10.160,
    '3/0 Gauge': 9.449,
    '2/0 Gauge': 8.839,
    '0 Gauge': 8.230,
    '1 Gauge': 7.620,
    '2 Gauge': 7.010,
    '3 Gauge': 6.401,
    '4 Gauge': 5.893,
    '5 Gauge': 5.385,
    '6 Gauge': 4.877,
    '7 Gauge': 4.470,
    '8 Gauge': 4.064,
    '9 Gauge': 3.658,
    '10 Gauge': 3.251,
    '11 Gauge': 2.946,
    '12 Gauge': 2.642,
    '13 Gauge': 2.337,
    '14 Gauge': 2.032,
    '15 Gauge': 1.829,
    '16 Gauge': 1.626,
    '17 Gauge': 1.422,
    '18 Gauge': 1.219,
    '19 Gauge': 1.016,
    '20 Gauge': 0.914,
    '21 Gauge': 0.813,
    '22 Gauge': 0.711,
    '23 Gauge': 0.610,
    '24 Gauge': 0.559,
    '25 Gauge': 0.508,
    '26 Gauge': 0.457,
    '27 Gauge': 0.417,
    '28 Gauge': 0.376,
    '29 Gauge': 0.345,
    '30 Gauge': 0.315,
    '31 Gauge': 0.295,
    '32 Gauge': 0.274,
    '33 Gauge': 0.254,
    '34 Gauge': 0.234,
    '35 Gauge': 0.213,
    '36 Gauge': 0.193,
    '37 Gauge': 0.173,
    '38 Gauge': 0.152,
    '39 Gauge': 0.132,
    '40 Gauge': 0.122,
    '41 Gauge': 0.112,
    '42 Gauge': 0.102,
    '43 Gauge': 0.091,
    '44 Gauge': 0.081,
    '45 Gauge': 0.071,
    '46 Gauge': 0.061,
    '47 Gauge': 0.051,
    '48 Gauge': 0.041,
    '49 Gauge': 0.031,
    '50 Gauge': 0.025,
  };

  String selectedGauge = '7/0 Gauge';

  void setSelectedGauge(String gauge) {
    selectedGauge = gauge;
    notifyListeners();
  }

  double get mmValue {
    return swgToMmMap[selectedGauge] ?? 0.0;
  }
}
