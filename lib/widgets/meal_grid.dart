import 'package:flutter/material.dart';

import '../providers/meal.dart';
import 'meal_grid_tile.dart';

class MealGrid extends StatefulWidget {
  const MealGrid({
    Key? key,
    required this.height,
    required this.mealsList,
  }) : super(key: key);
  final double height;
  final List<MealDemo> mealsList;

  @override
  _MealGridState createState() => _MealGridState();
}

class _MealGridState extends State<MealGrid> {
  List<MealDemo> currList = [];

  void _updateSearchList(String _val) {
    if (_val.isNotEmpty) {
      currList = widget.mealsList
          .takeWhile((value) => value.meal.toLowerCase().contains(_val))
          .toList();
    } else {
      currList = widget.mealsList;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    currList = widget.mealsList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(6.0),
            height: widget.height * 0.08,
            child: TextField(
                onChanged: _updateSearchList,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                    fillColor: Colors.blue[300],
                    hintText: "Search your favourite food",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))))),
        Expanded(
          flex: 1,
          child: Container(
              child: currList.length == 0
                  ? Center(child: Text("No meals to show for your search"))
                  : GridView.builder(
                      itemCount: currList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) => MealGridTile(
                          key: ValueKey(index), meal: currList[index]))),
        ),
      ],
    );
  }
}
