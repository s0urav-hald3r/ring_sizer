class SavedRing {
  SavedRing({
    required this.size,
    required this.description,
    required this.date,
  });

  final String? size;
  final String? description;
  final DateTime? date;

  factory SavedRing.fromJson(Map<String, dynamic> json) {
    return SavedRing(
      size: json["size"],
      description: json["description"],
      date: DateTime.tryParse(json["date"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
        "size": size,
        "description": description,
        "date": date?.toIso8601String(),
      };
}
