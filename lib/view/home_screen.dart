import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quotes_app_db_miner/controller/home_page_controller.dart';
import '../controller/random_quote_controller.dart';
import '../controller/second_page_controller.dart';
import '../modal/db_helper.dart';
import '../modal/quote_model.dart';

class QuoteHome extends StatefulWidget {
  const QuoteHome({super.key});

  @override
  State<QuoteHome> createState() => _QuoteHomeState();
}

RandomQuoteController randomQuoteController = Get.put(RandomQuoteController());
HomeController homeController = Get.put(HomeController());
SecondPageController secondPageController = Get.put(SecondPageController());

class _QuoteHomeState extends State<QuoteHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "InspireMe",
          style: GoogleFonts.lobster(color: Colors.black, fontSize: 28),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {
              homeController.goToFavoritePage();
            },
            icon: Icon(Icons.favorite, color: Colors.redAccent),
          )
        ],
      ),
      body: Stack(
        children: [
          Image.network(
            "https://img.freepik.com/free-photo/2d-graphic-wallpaper-with-colorful-grainy-gradients_23-2151001558.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Random Quote",
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2937)),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      randomQuoteController.getApiData();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        height: 250,
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [Color(0xFFEDE574), Color(0xFFE1F5C4)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 10,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Obx(() => Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    randomQuoteController.quote.value,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xFF1F2937)),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "- ${randomQuoteController.author.value}",
                                    style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1F2937)),
                                    textAlign: TextAlign.right,
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Categories",
                      style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  Obx(
                    () => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 100 / 50,
                          crossAxisCount: 1,
                        ),
                        itemCount: homeController.allQuote.value.length,
                        itemBuilder: (context, index) {
                          if (index < homeController.bgImages.length) {
                            return GestureDetector(
                              onTap: () {
                                secondPageController.sel_index.value = index;
                                secondPageController.currentCategory.value =
                                    homeController.categories[
                                        secondPageController.sel_index.value];
                                homeController.goToSecondPage();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      homeController.bgImages[index],
                                      height: 150,
                                    ),
                                    Center(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        color: Colors.black54,
                                        child: Text(
                                          homeController.categories[index],
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> getAllCategories(List<QuoteModel> allQuote) {
    Set<String> categoriesSet = <String>{};
    for (var quoteModel in allQuote) {
      categoriesSet.addAll(quoteModel.categories ?? []);
    }
    return categoriesSet.toList();
  }

  List<String> getAllBackgroundImages(List<QuoteModel> allQuote) {
    List<String> backgroundImages = [];
    for (var quoteModel in allQuote) {
      backgroundImages.addAll(quoteModel.bgImages ?? []);
    }
    return backgroundImages;
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
