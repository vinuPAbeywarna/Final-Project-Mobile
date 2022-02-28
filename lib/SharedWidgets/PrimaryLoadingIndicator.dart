import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

Widget primaryLoadingIndicator(){
  return SizedBox(
    width: Get.width * 0.075,
    child: const LoadingIndicator(
      indicatorType: Indicator.ballPulse,
      colors: [Colors.white],
    ),
  );
}
