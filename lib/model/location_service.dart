import 'database_helper.dart';
import 'location_model.dart';

class LocationService {
  Future<int> insertLocation(LocationModel location) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('location', location.toMap());
  }

  Future<LocationModel?> getLastLocation() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('location', orderBy: 'id DESC', limit: 1);
    if (result.isNotEmpty) {
      return LocationModel.fromJson(result.first);
    }
    return null;
  }

  Future<int> updateLocation(LocationModel location) async {
    final db = await DatabaseHelper.instance.database;
    return await db.update(
      'location',
      location.toMap(),
      where: 'id = ?',
      whereArgs: [location.id],
    );
  }
}
