class NotificationModel {
  String? status;
  String? message;
  List<Notification>? data;

  NotificationModel({this.status, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Notification>[];
      json['data'].forEach((v) {
        data!.add(new Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  String? id;
  String? text;
  int? linkedId;
  String? date;

  Notification({this.id, this.text, this.linkedId, this.date});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    linkedId = json['linked_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['linked_id'] = this.linkedId;
    data['date'] = this.date;
    return data;
  }
}
