import 'package:news2_app/api_service.dart';
import 'package:flutter/material.dart';
import 'customListTile.dart';
import 'article_model.dart';
import 'category_card.dart';
import 'category_model.dart';
import 'category_data.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<CategoryModel> categories = List<CategoryModel>();

  ApiService client = ApiService();
  ScrollController _scrollController = new ScrollController();
   @override
  void initState(){
    super.initState();
    categories = getCategories();
    //client.getArticle();
    //_scrollController.addListener(() {
      //if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //client.getArticle();
      //}
   // });
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text("News", style: TextStyle(
              color: Colors.black,
            ),),
            Text("TODAY",
              style: TextStyle(
                color: Colors.red,
              ),)
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 70,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryCard(
                        imageAssetUrl: categories[index].imageAssetUrl,
                        categoryName: categories[index].categorieName,
                      );
                    }),
              ),

              Container(
                child: FutureBuilder(

                  future: client.getArticle(),
                  builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
                    if (snapshot.hasData) {
                      List<Article> articles = snapshot.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: articles.length,
                        itemBuilder: (context, index) =>
                            customListTile(articles[index], context),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
