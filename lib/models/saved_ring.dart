class SavedRing {
  SavedRing({
    required this.size,
    required this.date,
  });

  final String? size;
  final DateTime? date;

  factory SavedRing.fromJson(Map<String, dynamic> json) {
    return SavedRing(
      size: json["size"],
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "size": size,
        "date": date?.toIso8601String(),
      };
}
