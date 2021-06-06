import 'package:flutter/material.dart';
import 'package:news2_app/api_service.dart';
import 'api_service.dart';
import 'article_model.dart';
import 'customListTile.dart';

class CategoryNews extends StatefulWidget {
  final String newsCategory;

  CategoryNews({this.newsCategory});
  @override
  _CategoryNewsState createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  CategoryApi client = CategoryApi();
  ScrollController _scrollController = new ScrollController();
  @override
  void initState(){
    super.initState();
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
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.red),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 0, 0),
          child: Row(
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
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: FutureBuilder(
                  future: client.getArticle(widget.newsCategory),
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
