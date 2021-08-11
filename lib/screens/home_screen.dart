import 'package:flutter/material.dart';
import 'package:foody_cookbook/widgets/favourites_tab.dart';
import 'package:foody_cookbook/widgets/meals_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;

  void _changeFocus(int index) {
    _index == index
        ? null
        : setState(() {
            _index = index;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Foody CookBook')),
      body: _index == 0 ? MealsTab() : FavouritesTab(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favourite')
        ],
        currentIndex: _index,
        onTap: _changeFocus,
      ),
    );
  }
}
