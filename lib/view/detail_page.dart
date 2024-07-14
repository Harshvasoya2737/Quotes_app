import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/second_page_controller.dart';
import '../modal/db_helper.dart';
import '../controller/detail_controller.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

DetailPageController detailPageController = Get.put(DetailPageController());
SecondPageController secondPageController = Get.find<SecondPageController>();

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    List args = Get.arguments as List;
    String data = args[0];
    String bg = args[1];
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          secondPageController.currentCategory.value,
          style: GoogleFonts.alkalami(fontSize: 24, color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("ADDED TO FAVORITE");
              addToFavorites(data);
            },
            icon: Icon(Icons.favorite_border, color: Colors.redAccent),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/bg-quotes.jpg",
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        spreadRadius: 5,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(30),
                  child: Center(
                    child: Text(
                      "\"${data}\"",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 280),
                  child: Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          addToFavorites(data);
                        },
                        icon: Icon(Icons.favorite_border),
                        label: Text("Add to Favorites"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          textStyle: GoogleFonts.poppins(fontSize: 16),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addToFavorites(String quote) async {
    bool added = await DbHelper.instance.insertData(quote);
    if (added) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quote added to favorites'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Quote is already in favorites'),
        ),
      );
    }
  }
}
