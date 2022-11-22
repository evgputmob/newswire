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
      home: const HomeScreen(),
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   bool _isLoaded = false;
//   List<NewsItem> _news = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Times Newswire'),
//         centerTitle: true,
//       ),
//       body: (!_isLoaded)
//           ? const Center(
//               child: Text('press load data'),
//             )
//           : ListView.separated(
//               itemCount: _news.length,
//               itemBuilder: (_, index) => NewsItemTile(newsItem: _news[index]),
//               separatorBuilder: (_, __) =>
//                   // Container(color: Colors.grey[350], height: 2),
//                   // Лучше использовать const SizedBox вместо контейнера,
//                   // т.к. у контейнера нет const-конструктора
//                   const SizedBox(
//                 height: 2,
//                 child: DecoratedBox(
//                   decoration: BoxDecoration(
//                     color: Color(clrListTileSeparator),
//                   ),
//                 ),
//               ),
//             ),
//       floatingActionButton: ElevatedButton(
//         onPressed: () async {
//           final apiKey = dotenv.env['NewswireApiKey'];
//           try {
//             var response = await Dio().get(
//                 'https://api.nytimes.com/svc/news/v3/content/all/all.json?api-key=$apiKey');
//             final newsJsonArr = response.data['results'] as List<dynamic>;
//             _news = newsJsonArr.map((item) => NewsItem.fromJson(item)).toList();
//             setState(() {
//               _isLoaded = true;
//             });
//           } catch (e) {
//             print(e);
//           }
//         },
//         child: const Text('load data'),
//       ),
//     );
//   }
// }
