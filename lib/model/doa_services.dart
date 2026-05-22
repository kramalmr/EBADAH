import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'doa_model.dart';

class DoaService {
  Future<int> insertDoa(DoaModel doa) async {
    final db = await DatabaseHelper.instance.database;
    return await db.insert('doa', doa.toMap());
  }

  Future<List<DoaModel>> getAllDoa() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('doa');
    return result.map((json) => DoaModel.fromJson(json)).toList();
  }

  Future<void> seedDoaData() async {
    final db = await DatabaseHelper.instance.database;
    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM doa'),
    );

    if (count == 0) {
      final String response = await rootBundle.loadString(
        'assets/doa_input.json',
      );
      final List<dynamic> data = jsonDecode(response);

      for (var item in data) {
        await insertDoa(DoaModel.fromJson(item));
      }
    }
  }

  Future<void> reloadDoaData() async {
    await DatabaseHelper.instance.resetDatabase();
    await seedDoaData();
  }

}
