// To parse this JSON data, do
//
//     final wilaya = wilayaFromJson(jsonString);

class Wilaya {
  int id;
  String label;

  Wilaya({
    required this.id,
    required this.label,
  });

  factory Wilaya.fromJson(Map<String, dynamic> json) => Wilaya(
        id: json['id'],
        label: json['label'],
      );
}

class Town {
  int id;
  int wilayaId;

  String label;

  Town({
    required this.id,
    required this.wilayaId,
    required this.label,
  });

  factory Town.fromJson(Map<String, dynamic> json) => Town(
        id: json['id'],
        wilayaId: json['wilayaId'],
        label: json['label'],
      );

  Map<String, dynamic> toJson() => {
        'label': label,
        'id': id,
      };
}
