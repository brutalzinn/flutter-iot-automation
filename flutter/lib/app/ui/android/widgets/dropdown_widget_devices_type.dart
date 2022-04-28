import 'package:application/app/data/enum/device_type.dart';
import 'package:application/app/data/enum/device_type_extension.dart';
import 'package:flutter/material.dart'; 
class DropDownDeviceType extends StatelessWidget 
{
  final dynamic onChange;
  final int value;

  const DropDownDeviceType({Key? key, required this.onChange, this.value = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  return DropdownButton<DeviceType>(

    items: DeviceType.values.map((DeviceType classType) {
      return DropdownMenuItem<DeviceType>(
        value: classType,
        child: Text(classType.displayTitle));
    }).toList(),
    onChanged: (newValue) {
      onChange(newValue);
    },
    value: DeviceType?.values[value]

);
}
}