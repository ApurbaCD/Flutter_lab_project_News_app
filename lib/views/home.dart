import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_appllication/helper/data.dart';
import 'package:news_appllication/helper/news.dart';
import 'package:news_appllication/models/article_model.dart';
import 'package:news_appllication/models/category_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List<CategoryModel> categories = new List<CategoryModel>();
  List<CategoryModel> categories = [];
  //List<ArticleModel> article = new List<ArticleModel>( );
  List<ArticleModel> articles = [];
  bool _loading=false;


  void initState(){
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews()async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState((){
      _loading=true;
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
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :Container(
        child: Column(
          children: <Widget>[
            //or can use Expanded
            /// Categories
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,//Extra 
                height: 70,//Extra
                child:ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: debugInstrumentationEnabled,
                  itemBuilder:(context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  })
              ),

              //Blogs
              
              Container(
                child: ListView.builder(
                  itemCount: articles.length,
                  shrinkWrap: true,
                  itemBuilder:(context,index){
                    return BlogTile(
                      imageUrl: articles[index].urlToImage,
                       title: articles[index].title, 
                       desc: articles[index].description,
                       );
                  }),
              )
          ],
        ),
      ),
    );
  }
}


class CategoryTile extends StatelessWidget {
  // const CategoryTile({super.key});
  final imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:(){

      },
      child: Container(
        margin: EdgeInsets.only(right: 16),
        child: Stack(
          children: <Widget >[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl,width:120,height:60,fit:BoxFit.cover),
              ),
            Container(
              alignment: Alignment.center,
              width:120,height:60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                 color: Colors.black26,
              ),
              child: Text(categoryName,style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),),
            )
          ],
        ),
      ),
    );
  }
}



class BlogTile extends StatelessWidget {
  
  final String imageUrl,title,desc;
  //BlogTile({@required this.imageUrl,@required this.title,@required this.desc});
  //With null safety, use the 'required' keyword, not the '@required' annotation.
  //Try removing the '@'
  BlogTile({required this.imageUrl,required this.title,required this.desc});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children:<Widget>[
          Image.network(imageUrl),
          Text(title),
          Text(desc),
        ],
      ),
    );
  }
}