import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:talk_s_a_r/res/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

// list kritik versi 2
class ListKritik extends StatefulWidget {
  const ListKritik({
    required this.listAllDocs,
    required this.category,
    Key? key,
  }) : super(key: key);

  final List<QueryDocumentSnapshot<Object?>> listAllDocs;
  final String category;

  @override
  State<ListKritik> createState() => _ListKritikState();
}

class _ListKritikState extends State<ListKritik> {
  // Harus pakai Map bukan List
  final Map<String, bool> _isLiked = new Map();

  // Future<void> _toggleLike(Kritik kritik) async {
  //   await HomeController().toggleLike(kritik);
  // }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.listAllDocs.length; i++) {
      final docId = widget.listAllDocs[i].id;
      _isLiked[docId] = false;
      _restoreLikeStatus(docId);
    }
  }

  void _restoreLikeStatus(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final isLiked = prefs.getBool('like_$id');
    if (isLiked != null) {
      setState(() {
        _isLiked[id] = isLiked;
      });
    }
  }

  void _updateLikeCount(int index, bool isLiked) {
    final docId = widget.listAllDocs[index].id;
    final docRef = FirebaseFirestore.instance.collection('kritik').doc(docId);
    docRef.update({'like': FieldValue.increment(isLiked ? 1 : -1)});
  }

  Future<void> _saveLikeStatus(String id, bool isLiked) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('like_$id', isLiked);
  }

  // Apakah Di Like atau Tidak ?
  bool isLiked(String id) {
    final liked = _isLiked[id];
    return liked == null ? false : liked;
  }

  @override
  Widget build(BuildContext context) {
    var filteredDocs = widget.listAllDocs;
    if (widget.category != "Semua") {
      filteredDocs = filteredDocs
          .where((doc) => doc["kategori"] == widget.category)
          .toList();
    }

    return ListView.builder(
      key: Key(filteredDocs.length.toString()),
      itemCount: filteredDocs.length,
      itemBuilder: (context, index) => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: greyBorder, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    "${filteredDocs[index]["gambar"]}",
                    width: double.infinity,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLiked[filteredDocs[index].id] = isLiked(filteredDocs[index].id) ? false : true;
                        });

                        _updateLikeCount(index, isLiked(filteredDocs[index].id));
                        _saveLikeStatus(filteredDocs[index].id, isLiked(filteredDocs[index].id));
                      },
                      child: Icon(
                        isLiked(filteredDocs[index].id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: isLiked(filteredDocs[index].id) ? Colors.red : null,
                        size: 32,
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "${filteredDocs[index]["judul"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "${filteredDocs[index]["kategori"]}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: filteredDocs[index]["kategori"] == "Dosen"
                        ? Colors.yellow
                        : filteredDocs[index]["kategori"] == "Pegawai"
                            ? Colors.green
                            : filteredDocs[index]["kategori"] == "Fasilitas"
                                ? Colors.red
                                : filteredDocs[index]["kategori"] == "Pelayanan"
                                    ? Colors.blue
                                    : Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Text(
                  "${filteredDocs[index]["deskripsi"]}",
                  style: TextStyle(fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
