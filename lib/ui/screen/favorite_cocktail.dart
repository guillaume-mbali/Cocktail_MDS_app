import 'package:cocktail_app_mds/bloc/cocktail.cubit.dart';
import 'package:cocktail_app_mds/models/cocktail.dart';
import 'package:cocktail_app_mds/repository/cocktail_repository.dart';
import 'package:cocktail_app_mds/ui/screen/detail_cocktail.dart';
import 'package:flutter/material.dart';
import 'package:cocktail_app_mds/repository/favorite_cocktail_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FavoriteCocktailPage extends StatefulWidget {
  const FavoriteCocktailPage({Key? key}) : super(key: key);

  @override
  _FavoriteCocktailPageState createState() => _FavoriteCocktailPageState();
}

class _FavoriteCocktailPageState extends State<FavoriteCocktailPage> {

  late Future<List<Cocktail>> futureCocktail;
  List<String> savedCocktails = FavoriteCocktailrepository().savedCocktails;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCocktail = CocktailRepository().fetchAllCocktail();
    //List<String> savedCocktails = FavoriteCocktailrepository().savedCocktails;
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorite(s)'),
        ),
        body: BlocBuilder<CocktailCubit, List<Cocktail>>(
gi
          builder: (context, List<Cocktail> state) {
              return ListView.separated(
                itemCount: state.length,
                itemBuilder: (context, index) {
                  final Cocktail cocktail = state[index];
                  return Padding(padding: const EdgeInsets.symmetric(vertical: 15), child:   ListTile(
                    title: Text(cocktail.name),
                    leading:   ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      child:
                      Image.network(
                        cocktail.img,
                        width: 120,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        bool isAlreadySaved = await Provider.of<CocktailCubit>(context, listen: false).state.contains(cocktail);
                        print(isAlreadySaved);
                        if(isAlreadySaved){
                          Provider.of<CocktailCubit>(context, listen: false).removeCocktail(cocktail);
                        }
                      },
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const DetailCocktailPage(),
                        // Pass the arguments as part of the RouteSettings. The
                        // DetailScreen reads the arguments from these settings.
                        settings: RouteSettings(
                          arguments: cocktail.id,
                        ),
                      ),
                      );
                      //print("${snapshot.data![index].idDrink}");
                    },
                  ),);


                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },);
          },
        ),
    );
  }
}
