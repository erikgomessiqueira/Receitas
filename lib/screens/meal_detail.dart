import 'package:flutter/material.dart';
import 'package:receitas/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;
  const MealDetailScreen({
    super.key,
    required this.onToggleFavorite,
    required this.isFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context)!.settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            _createSectionTitle(
              context,
              title: 'Ingredientes',
            ),
            _createSectionContainer(
              context,
              child: ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = meal.ingredients[index];
                  return Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child: Text(ingredient),
                    ),
                  );
                },
              ),
            ),
            _createSectionTitle(
              context,
              title: 'Passos',
            ),
            _createSectionContainer(
              context,
              child: ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (context, index) {
                  final step = meal.steps[index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text("${index + 1}"),
                        ),
                        title: Text(step),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onToggleFavorite(meal);
        },
        child: isFavorite(meal)
            ? const Icon(Icons.star_rounded)
            : const Icon(Icons.star_border_rounded),
      ),
    );
  }

  Widget _createSectionTitle(BuildContext context, {required String title}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _createSectionContainer(BuildContext context,
      {required Widget? child}) {
    return Container(
      height: 320,
      width: 350,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}
