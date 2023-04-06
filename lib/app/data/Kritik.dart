// class Kritik {
//   String id;
//   String isi;
//   DateTime createdAt;
//   bool isLiked; // tambahkan field ini

//   Kritik({required this.id, required this.isi, required this.createdAt, this.isLiked = false});

//   factory Kritik.fromJson(Map<String, dynamic> json) {
//     return Kritik(
//       id: json['id'] ?? '',
//       isi: json['isi'] ?? '',
//       createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
//       isLiked: json['isLiked'] ?? false, // inisialisasi dengan false
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'isi': isi,
//       'createdAt': createdAt.toIso8601String(),
//       'isLiked': isLiked,
//     };
//   }
// }
