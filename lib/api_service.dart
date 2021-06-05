import 'dart:convert';
import 'package:news2_app/article_model.dart';
import 'package:http/http.dart';


class ApiService {

  final endPointUrl =
      "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=3c24d57a1d3c46f8b0b32418da746112";


  Future<List<Article>> getArticle() async {
    Response res = await get(endPointUrl);

    //first of all let's check that we got a 200 statu code: this mean that the request was a succes
    if (res.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(res.body);

      List<dynamic> body = json['articles'];

      //this line will allow us to get the different articles from the json file and putting them into a list
      List<Article> articles =
      body.map((dynamic item) => Article.fromJson(item)).toList();

      return articles;
    } else {
      throw ("Can't get the Articles");
    }
  }

  gettwentyarticles() async {
    for( int i=0 ; i<20 ; i++){
      getArticle();
    }
  }


}