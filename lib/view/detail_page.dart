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
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        actions: [ IconButton(
          onPressed: () {
            print("ADDED TO FAVORITE");
            addToFavorites(data);
          },
          icon: Icon(Icons.favorite_border, color: Colors.black),
        ),],
        backgroundColor: Colors.transparent,
        title:  Text(secondPageController.currentCategory.value,
            style: GoogleFonts.alkalami(fontSize: 20)),
        centerTitle: true,
        elevation: 0.1,
      ),
      body: Column(
        children: [
          Container(
            height: 650,
            width: double.infinity,

            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Center(
                child: Text(
                  "\"${data}\"",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
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