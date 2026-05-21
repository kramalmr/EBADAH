import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'doa_model.dart';

class DoaService {
  final dbHelper = DatabaseHelper.instance;

  Future<void> insertDummyData() async {
    final db = await dbHelper.database;

    // cek apakah data sudah ada
    final result = await db.query('doa');

    if (result.isNotEmpty) {
      return;
    }

    // load json
    final String response = await rootBundle.loadString(
      'assets/doa_input.json',
    );

    final List<dynamic> data = json.decode(response);

    for (var item in data) {
      final doa = DoaModel(
        title: item['title'],
        arabic: item['arabic'],
        latin: item['latin'],
        translation: item['translation'],
      );

      await db.insert(
        'doa',
        doa.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<DoaModel>> getAllDoa() async {
    final db = await dbHelper.database;

    final result = await db.query('doa');

    return result.map((e) => DoaModel.fromMap(e)).toList();
  }
}
