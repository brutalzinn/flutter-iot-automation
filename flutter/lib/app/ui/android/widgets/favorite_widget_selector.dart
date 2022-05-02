import 'package:application/app/data/enum/device_type.dart';
import 'package:application/app/data/enum/device_type_extension.dart';
import 'package:flutter/material.dart'; 
class FavoriteWidgetSelector extends StatelessWidget 
{
  final dynamic onChange;

  const FavoriteWidgetSelector({Key? key, required this.onChange, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: new Icon(Icons.favorite),
        highlightColor: Colors.pink,
        onPressed: (){onChange();},
      );
}
}