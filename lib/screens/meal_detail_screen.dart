import 'package:flutter/material.dart';

import '../providers/meal.dart';

class MealDetailScreen extends StatelessWidget {
  const MealDetailScreen({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMealData(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Details();
        else if (snapshot.hasData) {
          MealDetails meal = snapshot.data as MealDetails;
          return Details(mealDetails: meal);
        } else {
          return Scaffold(
            appBar: AppBar(title: Text("Meal data not found...")),
          );
        }
      },
    );
  }
}

class Details extends StatelessWidget {
  const Details({
    Key? key,
    this.mealDetails,
  }) : super(key: key);
  final MealDetails? mealDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:
              Text((mealDetails == null ? "Loading..." : mealDetails!.meal))),
      body: ListView(children: [
        FadeInImage(
            placeholder: AssetImage("assets/images/foodplaceholder.jpg"),
            image: NetworkImage(mealDetails == null
                ? "https://image.freepik.com/free-vector/food-doodle-set_160308-239.jpg"
                : mealDetails!.thumb)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            SizedBox(height: 10),
            Text(mealDetails == null
                ? "Category :- Loading... "
                : "Category :- ${mealDetails!.category}"),
            SizedBox(height: 10),
            Text(mealDetails == null
                ? "Area :- Loading... "
                : "Area :- ${mealDetails!.area}"),
            SizedBox(height: 10),
            Text(mealDetails == null
                ? "Instructions :- Loading... "
                : "Instructions :- ${mealDetails!.instructions}"),
            SizedBox(height: 10),
            Text("Ingredients :"),
            if (mealDetails != null)
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: mealDetails!.ingredients.length,
                  itemBuilder: (context, index) => Text(
                      "${index + 1} - ${mealDetails!.ingredients[index]}")),
            SizedBox(height: 10),
            Text("Measure :"),
            if (mealDetails != null)
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: mealDetails!.ingredients.length,
                  itemBuilder: (context, index) =>
                      Text("${index + 1} - ${mealDetails!.measure[index]}")),
            SizedBox(height: 10),
            Text(mealDetails == null
                ? "Youtube link :- Loading... "
                : "Youtube link :- ${mealDetails!.youtubelnk}"),
          ]),
        ),
      ]),
    );
  }
}
