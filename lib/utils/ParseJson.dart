
class ParseData {
  int eTime;
  String date;
  String time;
  String day;

  ParseData(this.eTime, this.date, this.time, this.day);

  factory ParseData.fromJson(dynamic parsedJson) {
    return ParseData(
      parsedJson['eTime'] as int,
      parsedJson['date'].toString(),
      parsedJson['time'].toString(),
      parsedJson['day'].toString(),
    );
  }
}

class PieData {
  String day;
  double avg;
  String percent;

  PieData(this.day, this.avg, this.percent);

}

class LineData {
  String date;
  int eTime;

  LineData(this.date, this.eTime);
}