import 'package:flutter/material.dart'; 
class FavoriteWidgetSelector extends StatelessWidget 
{
   //TODO: REFACTOR THIS
  final dynamic onChange;
  final bool isFavorite;

  const FavoriteWidgetSelector({Key? key, required this.onChange, required this.isFavorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: new Icon(Icons.favorite),
        // highlightColor: Colors.pink,
        color: isFavorite ? Colors.pink : Colors.black,
        onPressed: (){
          onChange();
        },
      );
}
}