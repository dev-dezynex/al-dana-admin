class TimeSlotResult {
  late String status, message;
  late List<TimeSlot> timeSlotList;
  TimeSlot? timeSlot;

  TimeSlotResult(
      {this.status = '',
      this.message = '',
      this.timeSlotList = const [],
      this.timeSlot});

  TimeSlotResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    timeSlot =
        json['data'] != null ? TimeSlot.fromJson(json['data']) : TimeSlot();
  }
  TimeSlotResult.listFromJson(Map<String, dynamic> json) {
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
  late String id, day, date, createdBy, createdAt;
  late List<Slot> slotes;
  late bool status;

  TimeSlot(
      {this.id = '',
      this.day = '',
      this.date = '',
      this.slotes = const [],
      this.status = false,
      this.createdBy = '',
      this.createdAt = ''});

  TimeSlot.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    day = json['day'] ?? '';
    day = json['date'] ?? '';
    if (json['timeSlot'] != null) {
      slotes = <Slot>[];
      json['timeSlot'].forEach((v) {
        slotes.add(Slot.fromJson(v));
      });
    }
    status = json['status'] ?? false;
    createdBy = json['created_by'] ?? '';
    createdAt = json['created_at'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['day'] = day;
    data['date'] = date;
    data['slotes'] = slotes;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    return data;
  }
}

class Slot {
  late String id, startTime, endTime;
  late int maxBooking, currentBooking;
  late bool status;

  Slot({
    this.id = '',
    this.startTime = '',
    this.endTime = '',
    this.maxBooking = 0,
    this.currentBooking = 0,
    this.status = false,
  });

  Slot.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    startTime = json['startTime'] ?? '';
    endTime = json['endTime'] ?? '';
    maxBooking = json['maxBooking'];
    currentBooking = json['currentBooking'];
    status = json['status'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['maxBooking'] = maxBooking;
    data['currentBooking'] = currentBooking;
    data['status'] = status;
    return data;
  }
}
