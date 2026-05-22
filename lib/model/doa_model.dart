class DoaModel {
  final int? id;
  final String category;
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  DoaModel({
    this.id,
    required this.category,
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory DoaModel.fromJson(Map<String, dynamic> json) {
    return DoaModel(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      arabic: json['arabic'],
      latin: json['latin'],
      translation: json['translation'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'arabic': arabic,
      'latin': latin,
      'translation': translation,
    };
  }
}
