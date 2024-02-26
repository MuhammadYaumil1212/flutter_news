import 'package:news_flutter/core/resources/data_state.dart';
import 'package:news_flutter/features/daily_news/domain/repository/article_repository.dart';
import 'package:news_flutter/features/daily_news/domain/usecases/usecase.dart';

import '../entities/article.dart';

class GetArticleUseCase implements UseCase<DataState<List<ArticleEntity>>,void>{
  final ArticleRepository _articleRepository;
  GetArticleUseCase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    // TODO: implement call
    return _articleRepository.getNewsArticle();
  }

}