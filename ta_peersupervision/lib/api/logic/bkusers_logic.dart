class BKUsers {
  int? bkid;
  String? bkname;
  int? bknpm;
  late String bkusername;
  String? bkpasswordhash;
  String? inviteCode;

  BKUsers({
    this.bkid, this.bkname, this.bknpm, required this.bkusername, this.bkpasswordhash, this.inviteCode
  });

  BKUsers.fromJson(Map<String, dynamic> json) {
    bkid = json['bkid'];
    bkname = json['bkname'];
    bknpm = json['bknpm'];
    bkusername = json['bkusername'];
    bkpasswordhash = json['bkpasswordhash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bkid'] = bkid;
    data['bkname'] = bkname;
    data['bknpm'] = bknpm;
    data['bkusername'] = bkusername;
    data['bkpasswordhash'] = bkpasswordhash;
    data['inviteCode'] = inviteCode;

    return data;
  }
}