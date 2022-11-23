import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:newswire/data/i_newswire_service.dart';
import 'package:newswire/data/implementations/newswire_service.dart';
import 'package:newswire/logic/news_cubit.dart';
import 'package:newswire/ui/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  GetIt.I.registerSingleton<INewswireService>(NewswireService());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) =>
              NewsCubit(newsService: GetIt.I<INewswireService>())..getNews(),
        ),
      ],
      child: const NewswireApp(),
    ),
  );
}

class NewswireApp extends StatelessWidget {
  const NewswireApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newswire',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
