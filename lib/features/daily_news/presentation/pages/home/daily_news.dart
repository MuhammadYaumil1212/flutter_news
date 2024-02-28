import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/features/daily_news/domain/entities/article.dart';
import 'package:news_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../widgets/article_tile.dart';
class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }
  _buildAppBar(BuildContext context){
    return AppBar(
      title: const Text(
          "Daily News",
        style: TextStyle(
          color: Colors.black
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onShowSavedArticlesViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.bookmark, color: Colors.black),
          ),
        ),
      ],
    );
  }
  _buildBody(){
    return BlocBuilder<RemoteArticleBloc,RemoteArticleState>(
        builder: (_,state){
          if(state is RemoteArticleLoading){
            return const Center(child: CupertinoActivityIndicator(),);
          }
          if(state is RemoteArticleError){
            return const Center(child: Icon(Icons.refresh),);
          }
          if(state is RemoteArticleDone){
            return ListView.builder(
                itemCount: state.articles!.length,
                itemBuilder: (context,index){
                  return ArticleWidget(
                      article: state.articles![index],
                      onArticlePressed:(article) => _onArticlePressed(context,article),
                  );
                },
            );
          }
          return const SizedBox();
        }
    );
  }
  void _onArticlePressed(BuildContext context, ArticleEntity articles){
    Navigator.pushNamed(context,'/articleDetails',arguments:articles);
  }
  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/SavedArticles');
  }
}
