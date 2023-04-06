// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../app/data/Kritik.dart';
// import '../app/modules/home/controllers/home_controller.dart';

// class KritikItem extends StatelessWidget {
//   final Kritik kritik;

//   KritikItem({required this.kritik});

//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.find();
//     return ListTile(
//       title: Text(kritik.isi),
//       subtitle: Text('Dikirim pada ${kritik.createdAt}'),
//       trailing: IconButton(
//         icon: Icon(kritik.isLiked ? Icons.favorite : Icons.favorite_border),
//         onPressed: () async {
//           bool success = await controller.toggleLike(kritik);
//           if (!success) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Gagal menyukai kritik.'),
//                 backgroundColor: Colors.red,
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }
