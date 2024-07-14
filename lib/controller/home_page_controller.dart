import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../modal/quote_model.dart';
import '../view/favorite_page.dart';
import '../view/random_quote.dart';
import '../view/second_page.dart';

class HomeController extends GetxController {
  RxList<QuoteModel> allQuote = <QuoteModel>[].obs;
  List<String> categories = [];
  List<String> bgImages = [];

  @override
  void onInit() {
    super.onInit();
    loadJson();
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

  List<String> getAllImages(List<QuoteModel> allQuote) {
    List<String> images = [];
    for (var quoteModel in allQuote) {
      images.addAll(quoteModel.images ?? []);
    }
    return images;
  }

  List<String> getLoveQuotes(List<QuoteModel> allQuote) {
    List<String> loveQuotes = [];
    for (var quoteModel in allQuote) {
      if (quoteModel.love != null) {
        loveQuotes.addAll(quoteModel.love!);
      }
    }
    return loveQuotes;
  }

  List<String> getCalmQuotes(List<QuoteModel> allQuote) {
    List<String> calmQuotes = [];
    for (var quoteModel in allQuote) {
      if (quoteModel.calm != null) {
        calmQuotes.addAll(quoteModel.calm!);
      }
    }
    return calmQuotes;
  }

  List<String> getSadQuotes(List<QuoteModel> allQuote) {
    List<String> sadQuotes = [];
    for (var quoteModel in allQuote) {
      if (quoteModel.sad != null) {
        sadQuotes.addAll(quoteModel.sad!);
      }
    }
    return sadQuotes;
  }

  List<String> getTimeQuotes(List<QuoteModel> allQuote) {
    List<String> timeQuotes = [];
    for (var quoteModel in allQuote) {
      if (quoteModel.time != null) {
        timeQuotes.addAll(quoteModel.time!);
      }
    }
    return timeQuotes;
  }

  List<String> getFutureQuotes(List<QuoteModel> allQuote) {
    List<String> futureQuotes = [];
    for (var quoteModel in allQuote) {
      if (quoteModel.future != null) {
        futureQuotes.addAll(quoteModel.future!);
      }
    }
    return futureQuotes;
  }

  List<String> getRelationshipQuotes(List<QuoteModel> allQuote) {
    List<String> relationshipQuotes = [];
    for (var quoteModel in allQuote) {
      if (quoteModel.relationship != null) {
        relationshipQuotes.addAll(quoteModel.relationship!);
      }
    }
    return relationshipQuotes;
  }

  Future<void> loadJson() async {
    try {
      var fileData = await rootBundle.loadString("assets/quotes.json");
      var jsonData = jsonDecode(fileData);
      print("JSON Data: $jsonData");
      allQuote.assignAll(quoteModelFromJson(jsonEncode(jsonData)));
      categories = getAllCategories(allQuote);
      bgImages = getAllBackgroundImages(allQuote);
      print("Legnth : ${categories.length}");
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  void goToSecondPage() {
    Get.off(() => const SecondPage());
  }

  void goToFavoritePage() {
    Get.to(() => FavoritePage());
  }

  void goToRandomQuotePage() {
    Get.to(() => RandomQuotePage());
  }
}
