import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timers/model/timer_model.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:timers/model/timer_status.dart';
import '../controller/home_controller.dart';
import '../core/functions/duration_functions.dart';
import '../notification_services.dart';

class TimerListItem extends StatefulWidget {
  final TimerModel timer;
  void Function()? onPressEdit;

  TimerListItem({required this.timer, required this.onPressEdit});

  @override
  _TimerListItemState createState() => _TimerListItemState();
}

class _TimerListItemState extends State<TimerListItem> {
  HomeController homeController = Get.find();
  late CountDownController
      _countdownController; // Controller for the circular countdown timer.
  TimerStatus status = TimerStatus
      .reset; // Current status of the timer (reset, running, paused).

  @override
  void initState() {
    super.initState();
    _countdownController =
        CountDownController(); // Initialize the countdown controller.
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: widget.onPressEdit),
                Text(
                  "${widget.timer.label} - ${formatDuration(widget.timer.duration)}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      homeController.deleteTimer(widget.timer
                          .id!); // Replace with an edit function as needed.
                    }),
              ],
            ),
            const SizedBox(height: 10),

            CircularCountDownTimer(
              duration: widget.timer.duration,
              initialDuration: 0,
              controller: _countdownController,
              width: 80,
              height: 80,
              ringColor: Colors.grey[300]!,
              fillColor: Colors.blueAccent,
              backgroundColor: Colors.white,
              strokeWidth: 8.0,
              textStyle: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.MM_SS,
              isReverse: true,
              isReverseAnimation: true,
              autoStart: false,
              onComplete: () {
                // When the timer completes, show a notification if it wasn't reset manually.
                if (status != TimerStatus.reset) {
                  NotificationService.showNotification(
                      timerName: widget.timer.label);
                }
                // Reset the timer status.
                setState(() {
                  status = TimerStatus.reset;
                });
              },
            ),
            // Row with play/pause and reset buttons.
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center align the buttons.
              children: [
                // Play/Pause button.
                IconButton(
                  onPressed: () {
                    if (status == TimerStatus.reset) {
                      // Start the timer if it is reset.
                      _countdownController.start();
                      setState(() {
                        status =
                            TimerStatus.running; // Update status to "running".
                      });
                    } else if (status == TimerStatus.running) {
                      // Pause the timer if it is running.
                      _countdownController.pause();
                      setState(() {
                        status =
                            TimerStatus.paused; // Update status to "paused".
                      });
                    } else {
                      // Resume the timer if it is paused.
                      _countdownController.resume();
                      setState(() {
                        status =
                            TimerStatus.running; // Update status to "running".
                      });
                    }
                  },
                  // Change the icon based on the timer status.
                  icon: Icon(status == TimerStatus.running
                      ? Icons.pause
                      : Icons.play_circle),
                ),
                const SizedBox(width: 3), // Add spacing between buttons.

                // Reset button.
                IconButton(
                  onPressed: () async {
                    setState(() {
                      status = TimerStatus.reset; // Update status to "reset".
                    });
                    _countdownController.reset(); // Reset the timer.
                  },
                  icon: const Icon(Icons.stop), // Icon for reset action.
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
