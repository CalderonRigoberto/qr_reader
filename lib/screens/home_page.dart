import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/providers/scan_provider.dart';
import 'package:qr_reader/providers/ui_state.dart';

import 'package:qr_reader/screens/screens.dart';
import 'package:qr_reader/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title:
            const Center(child: Text('Historial', textAlign: TextAlign.center)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              scanListProvider.borrarTodos();
            },
          )
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const FloatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      extendBody: true,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiState = Provider.of<UIstate>(context);
    final currentIndex = uiState.selectedMenuOpt;

    //TODO temporal leer la base de datos

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansTipo('geo');
        return const MapasPages();
      case 1:
        scanListProvider.cargarScansTipo('http');
        return const DireccionesPages();
      default:
        return const MapasPages();
    }
  }
}
