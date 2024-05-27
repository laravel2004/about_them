// ignore_for_file: non_constant_identifier_names

import 'package:them/features/journal/domain/entities/journal.dart';

class JournalDetailModel extends JournalDetail {
  const JournalDetailModel ({
    super.id,
    super.title,
    super.note,
    super.user_id,
    super.created_at,
    super.updated_at
  });

  factory JournalDetailModel.fromJson(Map<String, dynamic> json) {
    return JournalDetailModel(
      id: json['data']['id'] ?? '',
      title: json['data']['title'] ?? '',
      note: json['data']['note'] ?? '',
      user_id: json['data']['user_id'] ?? '',
      created_at: json['data']['created_at'] ?? '',
      updated_at: json['data']['updated_at'] ?? ''
    );
  }

  factory JournalDetailModel.fromEntity(JournalDetail journal) {
    return JournalDetailModel(
      id: journal.id,
      title: journal.title,
      note: journal.note,
      user_id: journal.user_id,
      created_at: journal.created_at,
      updated_at: journal.updated_at
    );
  }
}

class JournalAllModel extends JournalAll {
  const JournalAllModel({
    super.id,
    super.title,
    super.updated_at
  });

  factory JournalAllModel.fromJson(Map<String, dynamic> json) {
    return JournalAllModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      updated_at: json['updated_at'] ?? ''
    );
  }

  factory JournalAllModel.fromEntity(JournalAll journal) {
    return JournalAllModel(
      id: journal.id,
      title: journal.title,
      updated_at: journal.updated_at
    );
  }
}