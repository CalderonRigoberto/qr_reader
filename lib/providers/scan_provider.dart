import 'package:flutter/material.dart';

import 'package:qr_reader/providers/db_provider.dart';

class ScanListProvider extends ChangeNotifier {
  //Instanciar lista en vacío
  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  nuevoScan(String valor) async {
    final nuevoScan = ScanModel(valor: valor);

    final id = await DBProvider.db.nuevoScan(nuevoScan);
    //asignar id de la base de datos al modelo
    if (tipoSeleccionado == nuevoScan.tipo) {
      nuevoScan.id = id;
      scans.add(nuevoScan);
      notifyListeners();
    }
  }

  cargarScans() async {
    var scans = await DBProvider.db.obtenerTodosScans();
    scans = [...scans!];
    notifyListeners();
  }

  cargarScansTipo(String tipo) async {
    var scans = await DBProvider.db.obtenerScansTipo(tipo);
    tipoSeleccionado = tipo;
    scans = [...scans!];
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.eliminarTodosScans();
    scans = [];
    notifyListeners();
  }

  borrarPorId(int id) async {
    await DBProvider.db.eliminarScans(id);
    cargarScansTipo(tipoSeleccionado);
    notifyListeners();
  }
}
