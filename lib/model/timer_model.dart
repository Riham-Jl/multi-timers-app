class TimerModel {
  final int? id;
  final String label;
  final int duration;


  TimerModel({
    this.id,
    required this.label,
    required this.duration,

  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'label': label,
      'duration': duration,
    };
  }

  factory TimerModel.fromMap(Map<String, dynamic> map) {
    return TimerModel(
      id: map['id'],
      label: map['label'],
      duration: map['duration'],
    );
  }
}
