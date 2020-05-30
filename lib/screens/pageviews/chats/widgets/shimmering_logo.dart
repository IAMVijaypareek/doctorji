import 'package:doctorji/utils/universal_variable.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      width: 50.0,
      child: Shimmer.fromColors(
        baseColor: UniversalVariables.blackColor,
        highlightColor: Colors.white,
        child: Image.asset("images/stethoscope.png"),
        period: Duration(seconds: 1),
      ),
    );
  }
}
