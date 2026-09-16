class Paginated<T> {
  const Paginated({
    required this.count,
    required this.results,
    this.next,
    this.previous,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  bool get hasMore => next != null && next!.isNotEmpty;

  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> item) parse,
  ) {
    final raw = json['results'];
    final items = raw is List
        ? raw
              .whereType<Map>()
              .map((item) => parse(Map<String, dynamic>.from(item)))
              .toList()
        : <T>[];
    return Paginated(
      count: json['count'] is num
          ? (json['count'] as num).toInt()
          : items.length,
      next: json['next']?.toString(),
      previous: json['previous']?.toString(),
      results: items,
    );
  }
}
