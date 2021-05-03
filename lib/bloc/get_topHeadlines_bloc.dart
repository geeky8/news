import 'package:news/model/article_response.dart';
import 'package:news/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetTopHeadlinesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
  BehaviorSubject<ArticleResponse>();

  getHeadlines() async {
    ArticleResponse response = await _repository.getTopHeadLine();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;

}
final getTopHeadlinesBloc = GetTopHeadlinesBloc();