class ResetPassPS {
  int? psnim;
  String? pspasswordhash;

  ResetPassPS({
    this.psnim, this.pspasswordhash
  });

  ResetPassPS.fromJson(Map<String, dynamic> json) {
    psnim = json['psnim'];
    pspasswordhash = json['pspasswordhash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['psnim'] = psnim;
    data['pspasswordhash'] = pspasswordhash;
    return data;
  }
}

class ResetPassBK {
  String? bkusername;
  String? bkpasswordhash;

  ResetPassBK({
    this.bkusername, this.bkpasswordhash
  });

  ResetPassBK.fromJson(Map<String, dynamic> json) {
    bkusername = json['bkusername'];
    bkpasswordhash = json['bkpasswordhash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bkusername'] = bkusername;
    data['bkpasswordhash'] = bkpasswordhash;
    return data;
  }
}