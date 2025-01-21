import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timers/widgets/time_picker.dart';
import '../controller/timer_controller.dart';
import '../core/functions/valid_input.dart';

class TimerFormScreen extends StatelessWidget {
  final TimerController controller = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: true, //When false, blocks the current route from being popped.
        onPopInvoked: (didPop) {
          Get.delete<TimerController>();
        },
        child: GetBuilder<TimerController>(builder: (controller) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                  title: Text(controller.isAdd ? 'Add Timer' : 'Update Timer')),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: controller.formKey,
                      child: TextFormField(
                        controller: controller.labelController,
                        validator: (val) {
                          return validInput(val!, 3, 15);
                        },
                        decoration: const InputDecoration(
                          labelText: 'Timer Label',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "minutes",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "seconds",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TimePicker(
                          value: controller.minutes,
                          onChanged: (value) {
                            controller.changeDuration(true, value);
                          },
                        ),
                        const Text(
                          ":",
                          style: TextStyle(fontSize: 25),
                        ),
                        TimePicker(
                          value: controller.seconds,
                          onChanged: (value) {
                            controller.changeDuration(false, value);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          controller.editTimer();
                        },
                        child:
                            Text(controller.isAdd ? 'Add Timer' : 'Edit timer'),
                      ),
                    ),
                  ],
                ),
              ));
        }));
  }
}
