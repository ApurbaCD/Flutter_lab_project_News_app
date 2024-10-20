import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_appllication/models/article_model.dart';
import 'package:http/http.dart' as http; 

class News  {
    List<ArticleModel> news=[];

    Future<void> getNews() async{
    String url = "https://newsapi.org/v2/everything?q=tesla&from=2024-09-20&sortBy=publishedAt&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //var response = await http.get(url) 
    // http.get(someString) repalace with  http.get(Uri.parse(someString))
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if(jsonData['status']=="ok"){
        jsonData["article"].forEach((element){
            if(element["urlToimage"]!=null&& element['description'!=null]){

                ArticleModel articleModel = ArticleModel(
                    title: element["title"],
                    auther: element["auther"],
                    description: element["description"],
                    url: element["url"],
                    urlToimage: element["urlToimage"],
                    publishedAt: element['publishedAt'],
                    content: element["content"],
                );
            }
        });
    }
    }

}