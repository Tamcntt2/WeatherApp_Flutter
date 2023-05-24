class SettingUtits {
  static String getDegreeUnit(double cel, bool hint) {
    int check = 1; // 1: C, 2: F, 3: K
    if (check == 1) {
      return '${cel.round().toString()}°' + (hint ? 'C' : '');
    } else if (check == 2) {
      double fah = cel * 9 / 5 + 32;
      return '${fah.round().toString()}°' + (hint ? 'F' : '');
    } else {
      double kel = cel + 273.15;
      return '${kel.round().toString()}°' + (hint ? 'K' : '');
    }
  }

  static String getSpeedUnit(double ms) {
    int check = 1; // 1: m/s, 2: km/h, 3: mph
    if (check == 1) {
      return '${ms.toStringAsFixed(2)} m/s';
    } else if (check == 2) {
      double kmh = ms * 3.6;
      return '${kmh.toStringAsFixed(2)} km/h';
    } else {
      double mph = ms * 2.23694;
      return '${mph.toStringAsFixed(2)} mph';
    }
  }

  static String getDistanceUnit(double distance) {
    int check = 2; // 1: m, 2: km
    if (check == 1) {
      return '$distance m';
    } else {
      return '${distance / 1000} km';
    }
  }
}
