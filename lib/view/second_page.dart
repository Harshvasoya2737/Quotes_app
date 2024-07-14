// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app_db_miner/controller/second_page_controller.dart';
import 'package:quotes_app_db_miner/controller/home_page_controller.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

HomeController homeController = Get.find<HomeController>();
SecondPageController secondPageController = Get.find<SecondPageController>();

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F4F6),
      appBar: AppBar(
        title: Text(
          secondPageController.currentCategory.value,
          style: GoogleFonts.lobster(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1F2937),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            secondPageController.goToHomePage();
          },
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              secondPageController.goToFavoritePage();
            },
            icon: Icon(
              Icons.favorite_border,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => ListView.builder(
            itemCount: secondPageController
                .getQuote(secondPageController.currentCategory.value)
                .length,
            itemBuilder: (context, index) {
              var quote = secondPageController
                  .getQuote(secondPageController.currentCategory.value)[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: GestureDetector(
                  onTap: () {
                    secondPageController.goToDetailPage(
                      quote ?? "",
                      secondPageController
                          .bgImages[secondPageController.sel_index.value],
                    );
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(
                            Icons.format_quote,
                            size: 40,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                quote,
                                style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.share),
                                    color: Colors.blueAccent,
                                    onPressed: () {

                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
