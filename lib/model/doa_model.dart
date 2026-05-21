class DoaModel {
  final int? id;
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  DoaModel({
    this.id,
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory DoaModel.fromMap(Map<String, dynamic> map) {
    return DoaModel(
      id: map['id'],
      title: map['title'],
      arabic: map['arabic'],
      latin: map['latin'],
      translation: map['translation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'arabic': arabic,
      'latin': latin,
      'translation': translation,
    };
  }
}
