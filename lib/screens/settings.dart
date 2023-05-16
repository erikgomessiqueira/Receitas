import 'package:flutter/material.dart';
import 'package:receitas/components/main_drawer.dart';
import 'package:receitas/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  final Settings settings;
  final Function(Settings) onSettingsChange;

  const SettingsScreen({
    super.key,
    required this.onSettingsChange,
    required this.settings,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Settings settings;

  @override
  void initState() {
    super.initState();
    settings = widget.settings;
  }

  Widget _createSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile.adaptive(
      title: Text(title),
      value: value,
      subtitle: Text(subtitle),
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChange(settings);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Filtros',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
              child: ListView(
            children: <Widget>[
              _createSwitch(
                title: 'Sem Glútem',
                subtitle: 'Somente refeições sem Glútem',
                value: settings.isGlutenFree,
                onChanged: (value) {
                  setState(() => settings.isGlutenFree = value);
                },
              ),
              _createSwitch(
                title: 'Sem Lactose',
                subtitle: 'Somente refeições sem Lactose',
                value: settings.isLactoseFree,
                onChanged: (value) {
                  setState(() => settings.isLactoseFree = value);
                },
              ),
              _createSwitch(
                title: 'Vegana',
                subtitle: 'Somente refeições Veganas',
                value: settings.isVegan,
                onChanged: (value) {
                  setState(() => settings.isVegan = value);
                },
              ),
              _createSwitch(
                title: 'Vegetariana',
                subtitle: 'Somente refeições Vegetarianas',
                value: settings.isVegetarian,
                onChanged: (value) {
                  setState(() => settings.isVegetarian = value);
                },
              ),
            ],
          ))
        ],
      ),
    );
  }
}
