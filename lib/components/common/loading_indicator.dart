import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, this.size = 30.0});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(color: Colors.orange, size: size);
  }
}
