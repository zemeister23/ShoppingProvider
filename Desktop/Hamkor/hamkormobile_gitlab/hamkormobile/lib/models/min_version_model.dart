class MinVersionModel {
  List<Data>? data;
  int? errorCode;
  String? errorNote;
  String? status;

  MinVersionModel({this.data, this.errorCode, this.errorNote, this.status});

  MinVersionModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    errorCode = json['error_code'];
    errorNote = json['error_note'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error_code'] = this.errorCode;
    data['error_note'] = this.errorNote;
    data['status'] = this.status;
    return data;
  }
}

class Data {
  String? appMinVersion;
  String? deviceOs;

  Data({this.appMinVersion, this.deviceOs});

  Data.fromJson(Map<String, dynamic> json) {
    appMinVersion = json['app_min_version'];
    deviceOs = json['device_os'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_min_version'] = this.appMinVersion;
    data['device_os'] = this.deviceOs;
    return data;
  }
}
