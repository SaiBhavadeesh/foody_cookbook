import 'package:flutter/material.dart';

import '../global/variables.dart';
import './meal_grid_tile.dart';

class FavouritesTab extends StatefulWidget {
  const FavouritesTab({Key? key}) : super(key: key);

  @override
  _FavouritesTabState createState() => _FavouritesTabState();
}

class _FavouritesTabState extends State<FavouritesTab> {
  Future<void> _onRefersh() {
    setState(() {});
    return Future.delayed(Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefersh,
      child: Container(
        child: GridView.builder(
          itemCount: liked.length,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (context, index) => MealGridTile(meal: liked[index]),
        ),
      ),
    );
  }
}
