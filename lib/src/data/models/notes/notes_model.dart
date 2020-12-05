class NotesModel {
  String status;
  List<Data> data;

  NotesModel({this.status, this.data});

  NotesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      if (json['data'] != null) {
        json['data'].forEach((v) {
          data.add(new Data.fromJson(v));
        });
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String id;
  String userId;
  String title;
  String description;
  String date;
  String file;

  Data(
      {this.id,
      this.userId,
      this.title,
      this.description,
      this.date,
      this.file});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['file'] = this.file;
    return data;
  }
}
