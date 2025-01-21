
String formatDuration(int seconds) {
  final int minutes = seconds ~/ 60;
  final int remainingSeconds = seconds % 60;

  return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
}


int getMinutesFromDuration(int seconds) {
  final int minutes = seconds ~/ 60;

  return minutes;
}


int getSecondsFromDuration(int seconds) {
  final int remainingSeconds = seconds % 60;

  return remainingSeconds;
}