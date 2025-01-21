import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timers/controller/home_controller.dart';
import 'package:timers/widgets/timer_list_item.dart';

class HomeScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Multi Timers"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          controller.addTimer();
        },
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          if (controller.timers.isEmpty) {
            return const Center(child: Text('No timers added yet.'));
          }
          return ListView.builder(
            itemCount: controller.timers.length,
            itemBuilder: (context, index) {
              final timer = controller.timers[index];
              return TimerListItem(
                timer: timer,
                onPressEdit: () {
                  controller.editTimer(timer);
                },
              );
            },
          );
        },
      ),
    );
  }
}
