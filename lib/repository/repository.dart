import 'package:dio/dio.dart';
import 'package:news/model/article_response.dart';
import 'package:news/model/source_response.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2/";
  final String apikey = "c337e1a24f9c41938b1e70f0809a7f4d";
  final Dio _dio = Dio();
  var getSourceUrl = "$mainUrl/sources";
  var getTopheadlinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  Future<SourceResponse> getSource() async{
    var params = {
      "apiKey": apikey,
      "language": "en",
      "country" : "in",
    };

    try{
      Response response = await _dio.get(getSourceUrl,queryParameters: params);
      return SourceResponse.fromJson(response.data);
    }catch(error,stacktrace){
      print("Exception occured : $error StackTrace : $stacktrace");
      return SourceResponse.withError(error);
    }

  }

  Future<ArticleResponse> getTopHeadLine() async{
    var params = {
      "apiKey" : apikey,
      "country" : "in",
    };
    try{
      Response response = await _dio.get(getTopheadlinesUrl,queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error,stacktrace){
      print("Exception occured : $error StackTrace : $stacktrace");
      return ArticleResponse.withError(error);
    }
  }

  Future<ArticleResponse> getHotNews() async{
    var params = {
      "apiKey" : apikey,
      "q" : "google",
      "sortBy" : "popularity",
    };

    try{
      Response response = await _dio.get(everythingUrl,queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error,stacktrace){
      print("Exception occured : $error StackTrace : $stacktrace");
      return ArticleResponse.withError(error);
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async{
    var params = {
      "apiKey" : apikey,
      "sources" : sourceId,
    };

    try{
      Response response = await _dio.get(getTopheadlinesUrl,queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch(error,stacktrace){
      print("Exception occured : $error StackTrace : $stacktrace");
      return ArticleResponse.withError(error);
    }
  }

  Future<ArticleResponse> search(String SearchValue) async {
    var params = {
      "apiKey": apikey,
      "q" : "$SearchValue"
    };
    try {
      Response response = await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    }catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

}