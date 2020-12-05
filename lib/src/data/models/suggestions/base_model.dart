class BaseModel {
  String status;
  dynamic data;

  BaseModel({this.status, this.data});

  BaseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;

    return data;
  }
}
