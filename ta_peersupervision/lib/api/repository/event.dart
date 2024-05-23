// event_model.dart
class MyJadwal {
  DateTime tanggal;
  String reqid;
  String mediapendampingan;
  String psname;
  String initial;

  MyJadwal({
    required this.tanggal,
    required this.reqid,
    required this.mediapendampingan,
    required this.psname,
    required this.initial});

  factory MyJadwal.fromJson(Map<String, dynamic> json) {
    return MyJadwal(
      tanggal: DateTime.parse(json['tanggal']),
      reqid: json['reqid'],
      mediapendampingan: json['mediapendampingan'],
      psname: json['psname'],
      initial: json['initial']
    );
  }
}
