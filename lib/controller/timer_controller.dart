import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timers/controller/home_controller.dart';
import 'package:timers/model/timer_model.dart';
import 'package:timers/screens/home_screen.dart';

import '../data/sql_db.dart';

class TimerController extends GetxController {
  HomeController homeController = Get.find();

  late bool isAdd;
  late int minutes;
  late int seconds;
  late int? timerId ;
  late String label;

  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController labelController ;

  @override
  void onInit() {
    var data = Get.arguments;
    labelController= TextEditingController();
    isAdd = data['isAdd'];
    timerId = data['timerId'];
    minutes = data['minutes'];
    seconds = data['seconds'];
    label = data['label'];
    labelController.text=label;
    super.onInit();
  }


  changeDuration(bool isMinutes , int value){
    if(isMinutes){
      minutes=value;
    }else {
      seconds=value;
    }
    update();
  }



  void editTimer() async{
    if (formKey.currentState!.validate()) {
      final totalDuration = (minutes * 60) + seconds;

      if (totalDuration <= 0) {
        Get.rawSnackbar(message: 'Duration must be greater than zero!');
        return;
      }

      isAdd? await addTimer( totalDuration):await updateTimer( totalDuration);
      Get.off(HomeScreen());
    } // Close the current screen
  }


  Future<void> addTimer( int duration) async {
    final timer = TimerModel(
        label: labelController.text,
        duration: duration
    );
    await TimerDatabase.instance.createTimer(timer);
    await homeController.getTimers();
  }

  Future<void> updateTimer( int duration) async {
    final timer = TimerModel(
      id:timerId,
        label: labelController.text,
        duration: duration
    );
    await TimerDatabase.instance.updateTimer(timer);
    await homeController.getTimers();
  }





}
