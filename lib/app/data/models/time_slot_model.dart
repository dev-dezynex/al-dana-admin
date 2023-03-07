class TimeSlotResult {
  late String status, message;
  late List<TimeSlot> timeSlotList;

  TimeSlotResult({this.status='', this.message='', this.timeSlotList=const[]});

  TimeSlotResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      timeSlotList = <TimeSlot>[];
      json['data'].forEach((v) {
        timeSlotList.add(TimeSlot.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = timeSlotList.map((v) => v.toJson()).toList();
    return data;
  }
}

class TimeSlot {
  late String id, day, createdBy, createdAt;
  late List<String> slotes;
  late bool status;

  TimeSlot(
      {this.id = '',
      this.day = '',
      this.slotes = const [],
      this.status = false,
      this.createdBy = '',
      this.createdAt = ''});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    day = json['day'] ?? '';
    slotes = json['slotes'] != null ? json['slotes'].cast<String>() : [];
    status = json['status'] ?? false;
    createdBy = json['created_by'] ?? '';
    createdAt = json['created_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['day'] = day;
    data['slotes'] = slotes;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}
