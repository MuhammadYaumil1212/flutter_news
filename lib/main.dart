import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/config/theme/app_themes.dart';
import 'package:news_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news_flutter/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news_flutter/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:news_flutter/injection_container.dart';

Future<void>main()async{
  await initialDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticleBloc>(
        create: (context)=> sl()..add(const GetArticles()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter News',
          theme: theme(),
          home: const DailyNews(),
        ),
    );
  }
}
