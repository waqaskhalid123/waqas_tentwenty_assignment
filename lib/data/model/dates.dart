class Dates {
  final String maximum;
  final String minimum;
  Dates({
    required this.maximum,
    required this.minimum,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'maximum': maximum,
      'minimum': minimum,
    };
  }

  factory Dates.fromMap(Map<String, dynamic> map) {
    return Dates(
      maximum: map['maximum'] as String,
      minimum: map['minimum'] as String,
    );
  }
}