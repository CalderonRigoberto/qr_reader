import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
export 'package:qr_reader/models/scan_model.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDb();

    return _database!;
  }

  Future<Database> initDb() async {
    //Donde se almacenara la base de datos

    Directory documentDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentDirectory.path, 'scansdb.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
    });
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;
    //verifica la base de datos
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans (idm tipo, valor)
        VALUES($id,'$tipo', '$valor' )
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {
    //verifica la base de datos
    final db = await database;
    //id del ultimo registro insertado
    final res = await db.insert('Scans', nuevoScan.toJson());

    return res;
  }

  Future<ScanModel?> obtenerScan(int i) async {
    final db = await database;

    final res = await db.query('Scans', where: 'id = ?', whereArgs: [i]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>?> obtenerTodosScans() async {
    final db = await database;

    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  Future<List<ScanModel>?> obtenerScansTipo(String tipo) async {
    final db = await database;

    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
        ? res.map((scan) => ScanModel.fromJson(scan)).toList()
        : [];
  }

  Future<int> actualizarScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update('Scans', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> eliminarScans(int id) async {
    final db = await database;

    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
    
  }

  Future<int> eliminarTodosScans() async {
    final db = await database;

    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');
    return res;
    
  }
}
