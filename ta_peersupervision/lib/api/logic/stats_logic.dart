// models.dart
class SessionPerMonth {
  final String month;
  final int count;

  SessionPerMonth({required this.month, required this.count});

  factory SessionPerMonth.fromJson(Map<String, dynamic> json) {
    return SessionPerMonth(
      month: json['month'],
      count: json['count'],
    );
  }
}

class TopPSDampingan {
  final String psname;
  final int dampingancount;

  TopPSDampingan({required this.psname, required this.dampingancount});

  factory TopPSDampingan.fromJson(Map<String, dynamic> json) {
    return TopPSDampingan(
      psname: json['psname'],
      dampingancount: json['dampingancount'],
    );
  }
}

class TopPSJadwal {
  final String psname;
  final int jadwalcount;

  TopPSJadwal({required this.psname, required this.jadwalcount});

  factory TopPSJadwal.fromJson(Map<String, dynamic> json) {
    return TopPSJadwal(
      psname: json['psname'],
      jadwalcount: json['jadwalcount'],
    );
  }
}

class ClientDistribution {
  final String category;
  final int count;

  ClientDistribution({required this.category, required this.count});

  factory ClientDistribution.fromJson(Map<String, dynamic> json) {
    // Angkatan bersifat INT, konversi menjadi STRING
    return ClientDistribution(
      category: (json['fakultas'] ?? json['kampus'] ?? json['gender'] ?? json['angkatan']?.toString() ?? 'Unknown').toString(),
      count: json['count'] as int,
    );
  }
}


class Topic {
  final String katakunci;
  final int count;

  Topic({required this.katakunci, required this.count});

  factory Topic.fromJson(Map<String, dynamic> json) {
    return Topic(
      katakunci: json['katakunci'],
      count: json['count'],
    );
  }
}

class Recommendation {
  final int isRecommended;
  final int count;

  Recommendation({required this.isRecommended, required this.count});

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      isRecommended: json['isRecommended'],
      count: json['count'],
    );
  }
}
