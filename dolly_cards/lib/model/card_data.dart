const String tableCards = 'cards';

class CardFields {
  static const List<String> values = [
    id, name, data, timestamp
  ];

  static const String id = '_id';
  static const String name = '_name';
  static const String data = '_data';
  static const String timestamp = '_timestamp';
}

class CardData {
  final int? id;
  final String name;
  final String data;
  final DateTime timestamp;

  const CardData({
    this.id,
    required this.name,
    required this.data,
    required this.timestamp
  });
  
  CardData copy({
    int? id,
    String? name,
    String? data,
    DateTime? timestamp
  }) => CardData(
    id: id ?? this.id,
    name: name ?? this.name,
    data: data ?? this.data,
    timestamp: timestamp ?? this.timestamp
  );

  factory CardData.fromJson(Map<String, dynamic> json) {
    return CardData(
        id: json[CardFields.id] as int?,
        name: json[CardFields.name] as String,
        data: json[CardFields.data] as String,
        timestamp: DateTime.parse(json[CardFields.timestamp] as String)
    );
  }

  Map<String, dynamic> toJson() => {
    CardFields.id: id,
    CardFields.name: name,
    CardFields.data: data,
    CardFields.timestamp: timestamp.toIso8601String()
  };

}