class LocationModel {
  final int? id;
  final String city;
  final String country;

  LocationModel({this.id, required this.city, required this.country});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'],
      city: json['city'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'city': city, 'country': country};
  }
}
