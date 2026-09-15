enum PointsType { earned, spent }

class PointsEntry {
  const PointsEntry({
    required this.id,
    required this.title,
    required this.points,
    required this.type,
    required this.date,
  });

  final String id;
  final String title;
  final int points;
  final PointsType type;
  final String date;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'points': points,
        'type': type.name,
        'date': date,
      };

  factory PointsEntry.fromJson(Map<String, dynamic> json) {
    return PointsEntry(
      id: json['id'] as String,
      title: json['title'] as String,
      points: json['points'] as int,
      type: json['type'] == 'spent' ? PointsType.spent : PointsType.earned,
      date: json['date'] as String,
    );
  }
}
