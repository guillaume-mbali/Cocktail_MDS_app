import 'package:cocktail_app_mds/bloc/cocktail.cubit.dart';
import 'package:cocktail_app_mds/models/cocktail.dart';
import 'package:cocktail_app_mds/repository/cocktail_repository.dart';
import 'package:cocktail_app_mds/repository/preferences_repository.dart';
import 'package:cocktail_app_mds/repository/repository.dart';
import 'package:cocktail_app_mds/ui/screen/detail_cocktail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CocktailPage extends StatefulWidget {
  CocktailPage({Key? key}) : super(key: key);
  final PreferencesRepository preferencesRepository = PreferencesRepository();

  @override
  _CocktailPageState createState() => _CocktailPageState();
}

class _CocktailPageState extends State<CocktailPage> {
  late Future<List<Cocktail>> _allCocktails;
  List<Cocktail> filteredCocktails = [];
  final String _category = "Alcoholic";
  bool alcool = true;
  bool nonAlcool = false;
  List<String> savedCocktails = <String>[];

  final bool? _isSaved = null;

  List<Cocktail> _cocktails = [];
  List<Cocktail> _favoritecocktails = [];

  final Repository repository = Repository(CocktailRepository(),PreferencesRepository());

  @override
  void initState() {
    // TODO: implement initState
    widget.preferencesRepository.loadCocktails().then((cocktails) {
      _setCocktails(cocktails);
    });
    super.initState();
    _allCocktails = repository.fetchCocktailByCategory(_category);
  }

  void _setCocktails(List<Cocktail> cocktails) {
    setState(() {
      _cocktails  = cocktails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cocktails'),
        ),
        body:
        Center(
            child: SingleChildScrollView(
              child: Container(
                margin: const  EdgeInsets.all(15.0),
                child: Column(
                  children: [
                            TextField(decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter a cocktail name (margarita...)',
                                ),
                              onChanged: (value) async {
                                if(value.isNotEmpty) {
                                  late Future<List<Cocktail>> cocktailsByName;
                                  cocktailsByName = repository.fetchCocktailByName(value);
                                  setState(() {
                                    _allCocktails = cocktailsByName;
                                  });
                                }
                              }
                          ),
                          Padding(padding: const EdgeInsets.symmetric(vertical: 15),child:
                          Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                TextButton
                                  (onPressed: () async {
                                  alcool = true;
                                  nonAlcool = false;
                                  late Future<List<Cocktail>> allCocktails;
                                  allCocktails = repository.fetchCocktailByCategory("Alcoholic");
                                  setState(() {
                                    _allCocktails = allCocktails;
                                  });
                                }, child: const Text('Alcool'),style: TextButton.styleFrom(
                                  primary: alcool ? Colors.blue : Colors.black,
                                  backgroundColor: alcool ? Colors.grey[200] : Colors.grey[50],

                                ),),
                                TextButton(onPressed: () {
                                  nonAlcool = true;
                                  alcool = false;
                                  late Future<List<Cocktail>> allCocktails;
                                  allCocktails = repository.fetchCocktailByCategory("Non_Alcoholic");
                                  setState(() {
                                    _allCocktails = allCocktails;
                                  });
                                }, child: Text('Sans Alcool'),style: TextButton.styleFrom(
                                  primary: nonAlcool ? Colors.blue : Colors.black,
                                  backgroundColor: nonAlcool ? Colors.grey[200] : Colors.grey[50],
                                ),),
                              ],

                            ),
                            Padding(padding: const EdgeInsets.fromLTRB(0, 10, 0, 5), child:     Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)
                              ),

                            ) ,)


                          ],)

                          ),



                    FutureBuilder<List<Cocktail>>(
                      future: _allCocktails,
                      builder: (context, snapshot) {

                        if (snapshot.hasData) {
                          return ListView.builder(
                              shrinkWrap: true,

                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, index) {

                                final Cocktail cocktail = snapshot.data![index];
                               // bool isFavorite = savedCocktail.contains(cocktail);
                                String name = "${snapshot.data![index].name}";
                               // bool isSaved = _favoritecocktails.contains(cocktail);

                               // bool isSaved = false;
                               bool _isAlreadySaved = Provider.of<CocktailCubit>(context, listen: false).state.contains(cocktail);

                               bool isSaved = savedCocktails.contains(cocktail.name);
                             /*   final List<Cocktail> MyFavCocktail =  Provider.of<CocktailCubit>(context, listen: false).state;
                                for(var cocktail in MyFavCocktail){
                                  if(cocktail.isFavorite == true){
                                   savedCocktails.add(cocktail.name);
                                  }
                                }

                                bool isSaved;
                                if(isAlreadySaved){
                                  isSaved = true;
                                }else{
                                  isSaved = false;
                                }
*/

                               // String isFavourite = "${snapshot.data![index].isFavorite}";

                            //    print(filteredCocktails);

                             //   if(isFavourite== 'true'){
                               //   isSaved = true;
                                //}else{
                                  //isSaved = false;
                                //}


                                // bool isSaved = FavoriteCocktailrepository().savedCocktails.contains(name);
                               //bool isSaved = FavoriteCocktailrepository().IsSaved(name);

                                return Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 10), child:       ListTile(
                                  title: Text("${snapshot.data![index].name}"),
                                  leading:    ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                    child:
                                    Image.network(
                                      "${snapshot.data![index].img}",
                                      width: 120,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),


                                  // CircleAvatar(backgroundImage: NetworkImage("${snapshot.data![index].img}"),radius: 50,),

                                  trailing: const Icon(Icons.arrow_forward_ios_rounded),

                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => const DetailCocktailPage(),
                                      // Pass the arguments as part of the RouteSettings. The
                                      // DetailScreen reads the arguments from these settings.
                                      settings: RouteSettings(
                                        arguments:  "${snapshot.data![index].id}",
                                      ),
                                    ),
                                    );
                                    //print("${snapshot.data![index].idDrink}");
                                  },
                                ),);


                              }
                          );
                        } else {
                          return const Center(child: CircularProgressIndicator());

                        }
                      },
                    ),
                  ],
                ),
              ),
            )
        )

    );
  }
}
