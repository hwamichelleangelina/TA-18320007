class PSUsers {
  int? psid;
  String? psname;
  late int psnim;
  String? pspasswordhash;
  int? psisActive;
  int? psisAdmin;

  PSUsers({
    this.psid, this.psname, required this.psnim, this.pspasswordhash, this.psisActive, this.psisAdmin
  });

  PSUsers.fromJson(Map<String, dynamic> json) {
    psid = json['psid'];
    psname = json['psname'];
    psnim = json['psnim'];
    pspasswordhash = json['pspasswordhash'];
    psisActive = json['psisActive'];
    psisAdmin = json['psisAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['psid'] = psid;
    data['psname'] = psname;
    data['psnim'] = psnim;
    data['pspasswordhash'] = pspasswordhash;
    data['psisActive'] = psisActive;
    data['psisAdmin'] = psisAdmin;

    return data;
  }
}

class Activate {
  int? psnim;

  Activate({
    this.psnim
  });

  Activate.fromJson(Map<String, dynamic> json) {
    psnim = json['psnim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['psnim'] = psnim;

    return data;
  }
}

class NonActivate {
  int? psnim;

  NonActivate({
    this.psnim
  });

  NonActivate.fromJson(Map<String, dynamic> json) {
    psnim = json['psnim'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['psnim'] = psnim;

    return data;
  }
}

class FreqPS {
  int? psnim;
  int? count;

  FreqPS({
    this.psnim,
    this.count,
  });

  factory FreqPS.fromJson(Map<String, dynamic> json) {
    return FreqPS(
      psnim: json['psnim'],
      count: json['count']
    );
  }

  String get nimAsString => psnim.toString();
  String get countAsString => count.toString();
}

class FreqDampingan {
  int? psnim;
  int? count;

  FreqDampingan({
    this.psnim,
    this.count,
  });

  factory FreqDampingan.fromJson(Map<String, dynamic> json) {
    return FreqDampingan(
      psnim: json['psnim'],
      count: json['count']
    );
  }

  String get nimAsString => psnim.toString();
  String get countAsString => count.toString();
}

class PSUser {
  final String name;
  final int nim;
  final String role;

  PSUser({
    required this.name,
    required this.nim,
    required this.role,
  });

  factory PSUser.fromJson(Map<String, dynamic> json) {
    return PSUser(
      name: json['Nama'],
      nim: json['NIM'],
      role: json['Role'],
    );
  }

  String get nimAsString => nim.toString();
}

class NonActiveUser {
  final String name;
  final int nanim;
  final String role;
  final int year;

  NonActiveUser({
    required this.name,
    required this.nanim,
    required this.role,
    required this.year
  });

  factory NonActiveUser.fromJson(Map<String, dynamic> json) {
    return NonActiveUser(
      name: json['Nama'],
      nanim: json['NIM'],
      role: json['Role'],
      year: json['Tahun']
    );
  }

  String get nanimAsString => nanim.toString();
  String get yearAsString => year.toString();
}

class ActiveUser {
  final String psname;

  ActiveUser({
    required this.psname,
  });

  factory ActiveUser.fromJson(Map<String, dynamic> json) {
    return ActiveUser(
      psname: json['psname'],
    );
  }
}