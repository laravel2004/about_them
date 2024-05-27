// ignore_for_file: non_constant_identifier_names

import 'package:them/features/consulting/domain/entities/consulting.dart';

class ConsultingStatusModel extends ConsultingStatus {

  const ConsultingStatusModel({
    super.id,
    super.problem,
    super.status,
    super.created_at,
  });

  factory ConsultingStatusModel.fromJson(Map<String, dynamic> json) {
    return ConsultingStatusModel(
      id : json['data']['id'] ?? '',
      problem: json['data']['problem'] ?? '',
      status: json['data']['status'] ?? '',
      created_at: json['data']['created_at'] ?? ''
    );
  }

  factory ConsultingStatusModel.fromEntity(ConsultingStatus consult) {
    return ConsultingStatusModel(
      id: consult.id,
      problem: consult.problem,
      status: consult.status,
      created_at: consult.created_at
    );
  }

}

class ConsultingDetailModel extends ConsultingDetail {
  const ConsultingDetailModel({
    super.id,
    super.problem,
    super.appointment_date,
    super.status,
    super.location,
    super.created_at,
    super.updated_at,
    super.user_id
  });

  factory ConsultingDetailModel.fromJson(Map<String, dynamic> json) {
    return ConsultingDetailModel(
      id: json['data']['id'] ?? '',
      problem: json['data']['problem'] ?? '',
      status: json['data']['status'] ?? '',
      location: json['data']['location'] ?? '',
      appointment_date: json['data']['appointment_date'] ?? '',
      user_id: json['data']['user_id'] ?? '',
      created_at: json['data']['created_at'] ?? '',
      updated_at: json['data']['updated_at'] ?? ''
    );
  }

  factory ConsultingDetailModel.fromEntity(ConsultingDetail consult) {
    return ConsultingDetailModel(
      id: consult.id,
      problem: consult.problem,
      status: consult.status,
      appointment_date: consult.appointment_date,
      location: consult.location,
      user_id: consult.user_id,
      created_at: consult.created_at,
      updated_at: consult.updated_at
    );
  }
}