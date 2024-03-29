import 'package:news_flutter/features/daily_news/domain/entities/article.dart';

import 'package:news_flutter/core/resources/data_state.dart';

abstract class ArticleRepository{
  Future<DataState<List<ArticleEntity>>> getNewsArticle();
  Future<List<ArticleEntity>> getSavedArticle();
  Future<void>removeArticle(ArticleEntity article);
  Future<void>saveArticle(ArticleEntity article);
}