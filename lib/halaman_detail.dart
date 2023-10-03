import 'package:flutter/material.dart';
import 'package:quiz_mobile/disease_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamaDetail extends StatefulWidget {
  final Diseases virus;

  const HalamaDetail({super.key, required this.virus});

  @override
  State<HalamaDetail> createState() => _HalamaDetailState();
}

class _HalamaDetailState extends State<HalamaDetail> {
  late bool _isFavorite = false;

  void showInSnackBar(String value, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Plant Diseases",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
        ),
        backgroundColor: Colors.green[400],
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.white),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              if (_isFavorite == false) {
                showInSnackBar("Berhasil Menghapus Favorite", Colors.red);
              }

              if (_isFavorite == true) {
                showInSnackBar("Berhasil Menambahkan Favorite", Colors.green);
              }
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launcurl(widget.virus.imgUrls);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.green[400],
        elevation: 0,
        child: const Icon(
          Icons.preview,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Hero(
              tag: widget.virus.imgUrls,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  widget.virus.imgUrls,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.green[400],
                        value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                      ),
                    );
                  },
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.virus.name,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text(
                    "Disease Name",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.virus.name,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Plant Name",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.virus.plantName,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Ciri Ciri",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.virus.nutshell.length,
                      (index) => Text(
                        '$index. ${widget.virus.nutshell[index]}',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Disease ID",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.virus.id,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    "Symptom",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    widget.virus.symptom,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launcurl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception("gagal buka link : $uri");
    }
  }
}
