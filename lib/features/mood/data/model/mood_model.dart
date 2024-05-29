import 'package:them/features/mood/domain/entities/mood.dart';

class MoodModel extends Mood {
  const MoodModel({
    super.mood,
    super.note,
    super.date,
  });

  factory MoodModel.fromJson(Map<String, dynamic> json) {
    return MoodModel(
      mood: json['data']['mood'] ?? '',
      note: json['data']['note'] ?? '',
      date: json['data']['date'] ?? '',
    );
  }

  factory MoodModel.fromEntity(Mood mood) {
    return MoodModel(
      mood: mood.mood,
      note: mood.note,
      date: mood.date,
    );
  }
}

class MoodGetModel extends MoodlGet {
  const MoodGetModel({
    super.mood,
    super.date,
  });

  factory MoodGetModel.fromJson(Map<String, dynamic> json) {
  final mood = json['data']['mood'] ?? '';
  return MoodGetModel(
    mood: mood.toString(),
    date: json['data']['date'] ?? '',
  );
}

  factory MoodGetModel.fromEntity(MoodlGet mood) {
    return MoodGetModel(
      mood: mood.mood,
      date: mood.date,
    );
  }

}