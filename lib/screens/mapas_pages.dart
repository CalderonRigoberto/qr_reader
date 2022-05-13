import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_provider.dart';

class MapasPages extends StatelessWidget {
  const MapasPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: true);
    scanListProvider.cargarScansTipo('geo');
    return ListView.builder(
        itemCount: scanListProvider.scans.length,
        itemBuilder: (_, index) => ListTile(
              leading: Icon(
                Icons.map,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scanListProvider.scans[index].valor),
              subtitle: Text(scanListProvider.scans[index].id.toString()),
              trailing: const Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => null,
            ));
  }
}
