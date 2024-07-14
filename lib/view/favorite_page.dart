import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/favorite_page_controller.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final FavoritePageController favoritePageController =
      Get.put(FavoritePageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Favorite Quotes",
          style: GoogleFonts.alegreyaSc(fontSize: 24, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          Image.network(
            "https://img.freepik.com/free-photo/vertical-graphic-illustration-blue-purple-circles-light-blue-background_181624-27651.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              return favoritePageController.favoriteQuotes.isEmpty
                  ? Center(
                      child: Text(
                        "No Favorite Quotes",
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.black54),
                      ),
                    )
                  : ListView.builder(
                      itemCount: favoritePageController.favoriteQuotes.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          color: Colors.transparent,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            title: Text(
                              favoritePageController.favoriteQuotes[index],
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.black87),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent),
                              onPressed: () async {
                                await favoritePageController
                                    .removeFromFavorites(favoritePageController
                                        .favoriteQuotes[index]);
                              },
                            ),
                            onTap: () {},
                          ),
                        );
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }
}
