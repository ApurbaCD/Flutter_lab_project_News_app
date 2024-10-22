
// // to fatch data from api

// class ArticleModel{
//   //late used because  "Non-nullable instance field 'auther' must be initialized."
//     String auther;
//     String title;
//     String description;
//     String url;
//     String urlToimage;
//     String content;
//     DateTime publishedAt;
    
//     ArticleModel({this.auther='',this.content='',this.description='',this.url='',this.urlToimage='',this.title='',this.publishedAt=});
// }



class ArticleModel{
  //late used because  "Non-nullable instance field 'auther' must be initialized."
    String author;
    String title;
    String description;
    String url;
    String urlToImage;
    String content;
    //DateTime publishedAt;
    
    //required extra used
    //ArticleModel({required this.auther,required this.content,required this.description,required this.url,required this.urlToimage,required this.title,required this.publishedAt});
    ArticleModel({required this.author,required this.content,required this.description,required this.url,required this.urlToImage,required this.title});

}
