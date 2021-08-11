import 'package:flutter/material.dart';

import '../providers/meal.dart';
import 'meal_grid_tile.dart';
import 'meal_grid.dart';

class MealsTab extends StatefulWidget {
  const MealsTab({Key? key}) : super(key: key);

  @override
  _MealsTabState createState() => _MealsTabState();
}

class _MealsTabState extends State<MealsTab> {
  static List<MealDemo> mealsList = [];

  Future<void> _onRefersh() {
    mealsList = [];
    setState(() {});
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: _onRefersh,
      child: mealsList.isEmpty
          ? FutureBuilder(
              future: getMealItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Container(
                    child: GridView.builder(
                        itemCount: 10,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) => MealGridTile(
                            meal: MealDemo(
                                meal: "Loading...",
                                thumb:
                                    "https://image.freepik.com/free-vector/food-doodle-set_160308-239.jpg",
                                mealId: ""))),
                  );
                else if (snapshot.hasData) {
                  mealsList = snapshot.data as List<MealDemo>;
                  return MealGrid(height: height, mealsList: mealsList);
                } else
                  return Center(child: Text('Something went wrong'));
              },
            )
          : MealGrid(height: height, mealsList: mealsList),
    );
  }
}
