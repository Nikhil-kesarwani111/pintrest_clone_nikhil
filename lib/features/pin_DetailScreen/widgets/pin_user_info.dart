import 'package:flutter/material.dart';
import 'package:pintrest_clone_nikhil/core/utils/responsiveness.dart';
import '../../home/domain/entities/pin_entity.dart';

class PinUserInfo extends StatelessWidget {
  final PinEntity pin;

  const PinUserInfo({super.key, required this.pin});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 15.w(context),
        vertical: 20.h(context),
      ),
      child: Text('Data')
    );
  }
}