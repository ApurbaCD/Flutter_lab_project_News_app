import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  bool _loading = true;


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
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) :SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              //or can use Expanded
              /// Categories
                Container(
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
              child: CachedNetworkImage(
                imageUrl:imageUrl,width:120,height:60,fit:BoxFit.cover),
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                  imageUrl,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'Something wrong!',
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
    );
  }
}