import 'package:get/get.dart';
import 'package:timers/core/functions/duration_functions.dart';
import 'package:timers/model/timer_model.dart';
import 'package:timers/data/sql_db.dart';

import '../screens/timer_form_screen.dart';

class HomeController extends GetxController {
  final List<TimerModel> timers = [];

  @override
  void onInit() {
    getTimers();
    super.onInit();
  }

  Future getTimers() async {
    final loadedTimers = await TimerDatabase.instance.getTimers();
    timers.clear();
    timers.addAll(loadedTimers);
    update();
  }

  Future<void> deleteTimer(int id) async {
    await TimerDatabase.instance.deleteTimer(id);
    timers.removeWhere((item) => item.id == id);
    update();
  }

  addTimer() {
    Get.to(() => TimerFormScreen(), arguments: {
      'timerId': null,
      'label': '',
      'minutes': 0,
      'seconds': 0,
      'isAdd': true
    });
  }

  editTimer(TimerModel timer) {
    Get.to(() => TimerFormScreen(), arguments: {
      'timerId': timer.id,
      'label': timer.label,
      'minutes': getMinutesFromDuration(timer.duration),
      'seconds': getSecondsFromDuration(timer.duration),
      'isAdd': false
    });
  }


}
