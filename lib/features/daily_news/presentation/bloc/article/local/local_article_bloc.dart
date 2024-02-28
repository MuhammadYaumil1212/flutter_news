import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:news_flutter/features/daily_news/domain/usecases/save_article.dart';
import 'package:news_flutter/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:news_flutter/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:news_flutter/features/daily_news/domain/usecases/remove_article.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent,LocalArticlesState>{
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SavedArticleUseCase _savedArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticleBloc(
      this._getSavedArticleUseCase,
      this._savedArticleUseCase,
      this._removeArticleUseCase
      ) : super(const LocalArticlesLoading()){
        on <GetSavedArticles> (onGetSavedArticles);
        on <RemoveArticle> (onRemoveArticle);
        on <SaveArticle> (onSaveArticle);
    }

  void onGetSavedArticles(GetSavedArticles event,Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onRemoveArticle(RemoveArticle removeArticle,Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

  void onSaveArticle(SaveArticle saveArticle,Emitter<LocalArticlesState> emit) async {
    await _savedArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDone(articles));
  }

}