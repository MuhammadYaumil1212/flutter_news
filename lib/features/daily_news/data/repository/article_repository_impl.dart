import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news_flutter/features/core/constants/constants.dart';
import 'package:news_flutter/features/core/resources/data_state.dart';
import 'package:news_flutter/features/daily_news/data/models/article_model.dart';
import 'package:news_flutter/features/daily_news/data/remote/news_api_service.dart';
import 'package:news_flutter/features/daily_news/domain/repository/article_repository.dart';

class ArticleRepositoryImpl extends ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

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
      return DataFailed(e);
    }
  }
}
