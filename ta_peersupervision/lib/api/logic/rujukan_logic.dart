class Rujukan {
  int? reqid;
  String? initial;
  int? isRujukanNeed;

  Rujukan({
    this.reqid,
    this.initial,
    this.isRujukanNeed,
  });

  factory Rujukan.fromJson(Map<String, dynamic> json) {

    return Rujukan(
      reqid: json['reqid'],
      initial: json['initial'],
      isRujukanNeed: json['isRujukanNeed']
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reqid'] = reqid;
    data['initial'] = initial;
    data['isRujukanNeed'] = isRujukanNeed;

    return data;
  }
}