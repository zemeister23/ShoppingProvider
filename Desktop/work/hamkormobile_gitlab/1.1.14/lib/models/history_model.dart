class HistoryModel {
  HistoryModel({
    this.data,
    this.errorCode,
    this.errorNote,
    this.status,
  });

  Data? data;
  num? errorCode;
  String? errorNote;
  String? status;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        data: Data.fromJson(json["data"]),
        errorCode: json["error_code"],
        errorNote: json["error_note"],
        status: json["status"],
      );
}

class Data {
  Data({
    this.operations,
    this.state,
  });

  List<Operation>? operations;
  List<State>? state;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        operations: List<Operation>.from(
            json["operations"].map((x) => Operation.fromJson(x))),
        state: List<State>.from(json["state"].map((x) => State.fromJson(x))),
      );
}

class Operation {
  Operation({
    this.currCode,
    this.isCredit,
    this.pan,
    this.psCode,
    this.sum,
    this.time,
    this.torgAddress,
    this.torgName,
    this.tranType,
  });

  String? currCode;
  bool? isCredit;
  String? pan;
  String? psCode;
  num? sum;
  String? time;
  String? torgAddress;
  String? torgName;
  String? tranType;

  factory Operation.fromJson(Map<String, dynamic> json) => Operation(
        currCode: json["curr_code"],
        isCredit: json["is_credit"],
        pan: json["pan"],
        psCode: json["ps_code"],
        sum: json["sum"],
        time: json["time"],
        torgAddress: json["torg_address"],
        torgName: json["torg_name"],
        tranType: json["tran_type"],
      );
}

class State {
  State({
    this.health,
    this.psCode,
  });

  bool? health;
  String? psCode;

  factory State.fromJson(Map<String, dynamic> json) => State(
        health: json["health"],
        psCode: json["ps_code"],
      );
}
