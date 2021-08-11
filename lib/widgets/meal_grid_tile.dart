import 'package:flutter/material.dart';
import 'package:foody_cookbook/screens/meal_detail_screen.dart';

import '../providers/meal.dart';
import '../global/variables.dart';

class MealGridTile extends StatefulWidget {
  const MealGridTile({Key? key, required this.meal}) : super(key: key);
  final MealDemo meal;

  @override
  _MealGridTileState createState() => _MealGridTileState();
}

class _MealGridTileState extends State<MealGridTile> {
  void _alterFav() {
    widget.meal.isFav ? widget.meal.isFav = false : widget.meal.isFav = true;
    liked.contains(widget.meal)
        ? liked.remove(widget.meal)
        : liked.add(widget.meal);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
        padding: const EdgeInsets.all(6.0),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => MealDetailScreen(id: widget.meal.mealId))),
          child: GridTile(
              child: Container(
                width: size.width * 0.5 - 12,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                      placeholder:
                          AssetImage("assets/images/foodplaceholder.jpg"),
                      image: NetworkImage(widget.meal.thumb),
                      fit: BoxFit.cover),
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
              ),
              footer: Container(
                  width: size.width * 0.5 - 12,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(15)),
                      color: Colors.black45),
                  child: FittedBox(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                                widget.meal.meal.length > 10
                                    ? widget.meal.meal.substring(0, 7) + "..."
                                    : widget.meal.meal,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24)),
                          ),
                          IconButton(
                              onPressed: widget.meal.meal == "Loading..."
                                  ? null
                                  : _alterFav,
                              icon: Icon(
                                Icons.favorite,
                                color: widget.meal.isFav
                                    ? Colors.red
                                    : Colors.white,
                              ))
                        ]),
                  ))),
        ));
  }
}
