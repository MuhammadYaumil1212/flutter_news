import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_flutter/core/constants/constants.dart';
import 'package:news_flutter/core/resources/data_state.dart';
import 'package:news_flutter/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:news_flutter/features/daily_news/data/models/article_model.dart';
import 'package:news_flutter/features/daily_news/data/remote/news_api_service.dart';
import 'package:news_flutter/features/daily_news/domain/entities/article.dart';
import 'package:news_flutter/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    // TODO: implement getNewsArticle
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        country: countryKey,
        apiKey: newsApikey,
        category: categoryQuery,
      );
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
            DioError(
                error: httpResponse.response.statusMessage,
                response: httpResponse.response,
                type: DioErrorType.badResponse,
                requestOptions: httpResponse.response.requestOptions
            )
        );
      }
    } on DioError catch (e) {
      print("dio error ${e.toString()}");
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticle() {
    // TODO: implement getSavedArticle
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    throw _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    // TODO: implement saveArticle
    throw _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}
