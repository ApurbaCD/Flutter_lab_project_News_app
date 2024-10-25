import 'package:flutter/material.dart';
import 'package:news_appllication/helper/news.dart';
import 'package:news_appllication/models/article_model.dart';
import 'package:news_appllication/views/article.dart';
import 'package:news_appllication/views/home.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  CategoryNews({required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  //List<CategoryModel> category =new List<CategoryModel>();
  //List<CategoryModel> category =[];
  //List<ArticleModel>articles = List<ArticleModel>();
  List<ArticleModel>articles = [];
  bool _loading=true;
  void initState(){
    super.initState();
    getCategoryNews();
  }
  getCategoryNews()async{
    CategoryNewsClass newsClass = CategoryNewsClass();
     await newsClass.getNews(widget.category);
    articles = newsClass.news;
     setState((){
       _loading=false;
        print('Done');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('News',style: TextStyle(
              color: Colors.blue,
            ),),
            Text('App'),
          ],
        ),
        actions:<Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.save)),
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
                  
                  
                  //Blogs 
                  Container(
                    padding: EdgeInsets.only(top:16),
                    child: ListView.builder(
                      itemCount: articles.length,
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder:(context,index){
                        return BlogTile(
                          imageUrl: articles[index].urlToImage,
                           title: articles[index].title, 
                           desc: articles[index].description,
                           url: articles[index].url,
                           );
                      }
                      ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
class BlogTile extends StatelessWidget {
  
  final String imageUrl,title,desc,url;
  //BlogTile({@required this.imageUrl,@required this.title,@required this.desc});
  //With null safety, use the 'required' keyword, not the '@required' annotation.
  //Try removing the '@'
  BlogTile({required this.imageUrl,required this.title,required this.desc,required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) =>ArticleView(
            blogUrl: url,
            )
          ));
      },
      child: Container(
        child: Column(
          children:<Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                    imageUrl,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text(
                          'Error in loading image!',
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                    ),
                  ),
            //Image.network(imageUrl),
            //  Image.network(
            //         imageUrl,
            //         errorBuilder: (context, error, stackTrace) {
            //           return const Center(
            //             child: Text(
            //               'Something wrong!',
            //               textAlign: TextAlign.center,
            //             ),
            //           );
            //         },
            //         ),
            SizedBox(height:8,),
            Text(title,
            style: TextStyle(
              fontSize: 19,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
            ),
            SizedBox(height:8,),
            Text(desc,
            style: TextStyle(
              color: Colors.black26,
            ),
            ),
          ],
        ),
      ),
    );
  }
}