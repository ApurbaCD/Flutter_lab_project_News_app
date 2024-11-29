import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_appllication/models/article_model.dart';
import 'package:http/http.dart' as http; 

class News  {
    List<ArticleModel> news=[];

    Future<void> getNews() async{
    var all= DateTime.now();
    var year=all.year;
    var date=all.day;
    var month=all.month;
    month--;
    // String url = "https://newsapi.org/v2/everything?q=tesla&from=2024-09-21&sortBy=publishedAt&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //String url = "https://newsapi.org/v2/top-headlines?country=in/sources?country=usapiKey=c93e72ee4f444db7b1a5b56d4c047506";
    String url ="https://newsapi.org/v2/everything?q=tesla&from=$year-$month-$date&sortBy=publishedAt&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //String url="https://newsapi.org/v2/top-headlines?country=bg&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //String url="https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //var response = await http.get(url) 
    // http.get(someString) repalace with  http.get(Uri.parse(someString))
    var response = await http.get(Uri.parse(url));
    //var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData["status"]=="ok"){
      print("decode");
        jsonData["articles"].forEach((element){
          // print(element['title']);
          // print(element['author']);
          // print(element['description']);
          // print(element['url']);
          // print(element['urlToImage']);
          // print(element['content']);
            if(element["urlToImage"]!=null&& element["description"]!=null&&element["author"]!=null&&element["title"]!=null&&element["url"]!=null&&element["content"]!=null){

                ArticleModel articleModel = ArticleModel(
                    title: element["title"],
                    author: element["author"],
                    description: element["description"],
                    url: element["url"],
                    urlToImage: element["urlToImage"],
                    //publishedAt: element['publishedAt'],
                    content: element["content"],
                );

                news.add(articleModel);
            }
        });
    }
    }

}


class CategoryNewsClass  {
    List<ArticleModel> news=[];

    Future<void> getNews(String category ) async{
    // String url = "https://newsapi.org/v2/everything?q=tesla&from=2024-09-21&sortBy=publishedAt&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //String url = "https://newsapi.org/v2/top-headlines?country=in/sources?country=usapiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //String url ="https://newsapi.org/v2/everything?q=tesla&from=2024-09-25&sortBy=publishedAt&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //String url="https://newsapi.org/v2/top-headlines?country=bg&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //https://newsapi.org/v2/top-headlines?country=us&apiKey=c93e72ee4f444db7b1a5b56d4c047506
    String url="https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=c93e72ee4f444db7b1a5b56d4c047506";
    //var response = await http.get(url) 
    // http.get(someString) repalace with  http.get(Uri.parse(someString))
    var response = await http.get(Uri.parse(url));
    //var response = await http.get(url);

    var jsonData = jsonDecode(response.body);

    if(jsonData["status"]=="ok"){
      print("decode");
        jsonData["articles"].forEach((element){
          // print(element['title']);
          // print(element['author']);
          // print(element['description']);
          // print(element['url']);
          // print(element['urlToImage']);
          // print(element['content']);
            if(element["urlToImage"]!=null&& element["description"]!=null&&element["author"]!=null&&element["title"]!=null&&element["url"]!=null&&element["content"]!=null){

                ArticleModel articleModel = ArticleModel(
                    title: element["title"],
                    author: element["author"],
                    description: element["description"],
                    url: element["url"],
                    urlToImage: element["urlToImage"],
                    //publishedAt: element['publishedAt'],
                    content: element["content"],
                );

                news.add(articleModel);
            }
        });
    }
    }

}
