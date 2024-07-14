import 'package:get/get.dart';
import 'package:quotes_app_db_miner/controller/home_page_controller.dart';
import '../modal/quote_model.dart';
import '../view/detail_page.dart';
import '../view/favorite_page.dart';
import '../view/home_screen.dart';

class SecondPageController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  RxString currentCategory = "".obs;
  RxInt sel_index = 0.obs;

  List<String> images = [];
  List<String> loveQuotes = [];
  List<String> calmQuotes = [];
  List<String> sadQuotes = [];
  List<String> timeQuotes = [];
  List<String> futureQuotes = [];
  List<String> relationshipQuotes = [];
  List<String> bgImages = [];

  @override
  void onInit() {
    super.onInit();

    loadData();
  }

  void loadData() {
    images = getAllImages(homeController.allQuote);
    loveQuotes = getLoveQuotes(homeController.allQuote);
    calmQuotes = getCalmQuotes(homeController.allQuote);
    sadQuotes = getSadQuotes(homeController.allQuote);
    timeQuotes = getTimeQuotes(homeController.allQuote);
    futureQuotes = getFutureQuotes(homeController.allQuote);
    relationshipQuotes = getRelationshipQuotes(homeController.allQuote);
    bgImages = getAllBackgroundImages(homeController.allQuote);
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

  List<String> getQuote(String q) {
    if (q == "Love") {
      return loveQuotes;
    } else if (q == "Calm") {
      return calmQuotes;
    } else if (q == "Sad") {
      return sadQuotes;
    } else if (q == "Time") {
      return timeQuotes;
    } else if (q == "Future") {
      return futureQuotes;
    } else if (q == "Relationship") {
      return relationshipQuotes;
    } else {
      return [];
    }
  }

  void goToHomePage() {
    Get.off(() => const QuoteHome());
  }

  void goToDetailPage(String data, String bg) {
    Get.to(() => DetailPage(), arguments: [data, bg]);
  }

  void goToFavoritePage() {
    Get.to(() => FavoritePage());
  }
}