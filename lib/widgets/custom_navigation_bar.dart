import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_state.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiState = Provider.of<UIstate>(context);
    final currenIndex = uiState.selectedMenuOpt;

    return BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (int i) => uiState.slectedMenuOpt = i,
        currentIndex: currenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: 'Mapa',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.link_rounded),
            label: 'Direcciones',
          )
        ]);
  }
}
