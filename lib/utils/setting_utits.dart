class SettingUtits {
  static String getDegreeUnit(double cel, bool hint, int check) {
    // 0: C, 1: F, 2: K
    if (check == 0) {
      return '${cel.round().toString()}°${hint ? 'C' : ''}';
    } else if (check == 1) {
      double fah = cel * 9 / 5 + 32;
      return '${fah.round().toString()}°${hint ? 'F' : ''}';
    } else {
      double kel = cel + 273.15;
      return '${kel.round().toString()}°${hint ? 'K' : ''}';
    }
  }

  static String getSpeedUnit(double ms, int check) {
    // 0: m/s, 1: km/h, 2: mph
    if (check == 0) {
      return '${ms.toStringAsFixed(2)} m/s';
    } else if (check == 1) {
      double kmh = ms * 3.6;
      return '${kmh.toStringAsFixed(2)} km/h';
    } else {
      double mph = ms * 2.23694;
      return '${mph.toStringAsFixed(2)} mph';
    }
  }

  static String getDistanceUnit(double distance, int check) {
    // 0: m, 1: km
    if (check == 0) {
      return '$distance m';
    } else {
      return '${distance / 1000} km';
    }
  }
}
