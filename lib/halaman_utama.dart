import 'package:flutter/material.dart';
import 'package:quiz_mobile/disease_data.dart';
import 'package:quiz_mobile/halaman_detail.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

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
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: GridView.builder(
            itemCount: listDisease.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Jumlah kolom yang diinginkan
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 200,
            ),
            itemBuilder: (context, index) {
              final Diseases virus = listDisease[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                color: Colors.white,
                margin: EdgeInsets.zero,
                child: InkWell(
                  borderRadius: BorderRadius.circular(4.0),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HalamaDetail(virus: virus)));
                  },
                  child: Column(
                    children: [
                      Hero(
                        tag: virus.imgUrls,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
                          child: SizedBox(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              virus.imgUrls,
                              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green[400],
                                    value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                                  ),
                                );
                              },
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          virus.name,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
