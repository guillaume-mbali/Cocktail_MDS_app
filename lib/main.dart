import 'package:cocktail_app_mds/bloc/cocktail.cubit.dart';
import 'package:cocktail_app_mds/repository/cocktail_repository.dart';
import 'package:cocktail_app_mds/repository/preferences_repository.dart';
import 'package:cocktail_app_mds/repository/repository.dart';
import 'package:cocktail_app_mds/ui/screen/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final PreferencesRepository preferencesRepository = PreferencesRepository();
  final CocktailRepository cocktailRepository = CocktailRepository();
  final Repository repository = Repository(cocktailRepository, preferencesRepository);

  final CocktailCubit cocktailCubit = CocktailCubit(repository);
  cocktailCubit.loadCocktails();

  runApp(MultiProvider(providers: [
  Provider<CocktailCubit>(create: (context) => cocktailCubit),
  Provider<Repository>(create: (context) => repository),
  ],
      child: const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/Home': (context) => const Navigation(),
      //  '/favorite': (context) => const FavoriteCocktailPage(),
      },
      initialRoute: '/',
      home: const Navigation(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text("Home"),
      ),
      body: Center(
        child: Column(

        ),
      ),
    );
  }
}
