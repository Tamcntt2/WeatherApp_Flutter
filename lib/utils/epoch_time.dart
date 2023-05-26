class EpochTime {
  static String getWeekDay(int timestamps) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamps * 1000);
    List<String> weekDay = ['MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'];
    return weekDay[date.weekday - 1];
    // return date.weekday.toString();
  }

  static String getMonth(int timestamps) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamps * 1000);
    List<String> month = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC'
    ];
    return month[date.month - 1];
  }

  static DateTime getDateTime(int timestamps) {
    return DateTime.fromMillisecondsSinceEpoch(timestamps * 1000);
  }
}
