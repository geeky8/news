import 'package:flutter/foundation.dart';
import 'package:news/model/article_response.dart';
import 'package:news/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourceNewsBloc{
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject = BehaviorSubject<ArticleResponse>();

  getSourceNews(String id) async{
    ArticleResponse response = await _repository.getSourceNews(id);
    _subject.sink.add(response);
  }

  void drainStream() {_subject.value;}

  @mustCallSuper
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;

}

final getSourceNewsBloc = GetSourceNewsBloc();