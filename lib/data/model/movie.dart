class Genere {
  final int id;
  final String name;
  Genere({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Genere.fromMap(Map<String, dynamic> map) {
    return Genere(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}