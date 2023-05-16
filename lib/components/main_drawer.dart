import 'package:flutter/material.dart';
import 'package:receitas/utils/app_routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  void _navigateTo(BuildContext context, {required String route}) {
    Navigator.of(context).pushReplacementNamed(route);
  }

  Widget _createItem(
      {required IconData icon,
      required String label,
      VoidCallback? onPressed}) {
    return ListTile(
      onTap: onPressed,
      leading: Icon(icon, size: 26),
      title: Text(
        label,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.secondary,
            child: Text(
              'Vamos cozinhar?',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _createItem(
            icon: Icons.restaurant,
            label: 'Refeições',
            onPressed: () => _navigateTo(context, route: AppRoutes.home),
          ),
          _createItem(
            icon: Icons.settings,
            label: 'Configurações',
            onPressed: () => _navigateTo(context, route: AppRoutes.settings),
          ),
        ],
      ),
    );
  }
}
