class ClickPoint {
  final int id;
  final double x;
  final double y;
  final int delay;
  final int interval;
  final int repetitions;

  ClickPoint({
    required this.id,
    required this.x,
    required this.y,
    this.delay = 0,
    this.interval = 1000,
    this.repetitions = 1,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'x': x,
    'y': y,
    'delay': delay,
    'interval': interval,
    'repetitions': repetitions,
  };

  factory ClickPoint.fromJson(Map<String, dynamic> json) => ClickPoint(
    id: json['id'],
    x: json['x'],
    y: json['y'],
    delay: json['delay'],
    interval: json['interval'],
    repetitions: json['repetitions'],
  );
}
