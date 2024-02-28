import 'package:news_flutter/features/daily_news/domain/entities/article.dart';
import 'package:news_flutter/features/daily_news/domain/usecases/usecase.dart';

import '../repository/article_repository.dart';

class SavedArticleUseCase implements UseCase<void,ArticleEntity>{

  final ArticleRepository _articleRepository;

  SavedArticleUseCase(this._articleRepository);

  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticle();
  }

}