import 'package:cocktail_app_mds/models/detail_cocktail.dart';
import 'package:cocktail_app_mds/repository/detail_cocktail_repository.dart';
import 'package:cocktail_app_mds/models/cocktail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../bloc/cocktail.cubit.dart';
import '../../models/cocktail.dart';


class DetailCocktailPage extends StatefulWidget {
  const DetailCocktailPage({Key? key}) : super(key: key);

  @override
  State<DetailCocktailPage> createState() => _DetailCocktailPageState();
}

class _DetailCocktailPageState extends State<DetailCocktailPage> {

  late Future<DetailCocktail> futureDetailCocktail;
  late Cocktail _cocktail;
  bool _isAlreadySaved = false;

  @override
  Widget build(BuildContext context) {

    final cocktailId = ModalRoute.of(context)!.settings.arguments;
    futureDetailCocktail = CocktailDetailRepository().fetchDetailCocktail(cocktailId.toString());


    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body:
      FutureBuilder<DetailCocktail>(
        future: futureDetailCocktail,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return  FutureBuilder<DetailCocktail>(
              future: futureDetailCocktail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                  //  mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Container(
                          width: double.infinity,
                          height: 200,
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:NetworkImage(snapshot.data!.strDrinkThumb)
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                      ),
                      Container(
                        child:  Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Column(
                            children: [
                              Padding(padding: const EdgeInsets.symmetric(vertical: 15) , child:   Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(padding: const EdgeInsets.fromLTRB(0, 0, 7, 0), child:     Text(snapshot.data!.strDrink, style: GoogleFonts.ruda(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),),),
                                      Text("(" + snapshot.data!.strGlass + ")", style: GoogleFonts.ruda(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300,
                                      ),),
                                    ],
                                  ),
                                  TextButton.icon(
                                    icon: Icon( _isAlreadySaved ? Icons.favorite : Icons.favorite_border),
                                    label: const Text('Like'),
                                    onPressed: () async {
                                      late Cocktail cocktail;
                                      cocktail = Cocktail(snapshot.data!.idDrink, snapshot.data!.strDrink, snapshot.data!.strDrinkThumb, true);
                                      bool isAlreadySaved =  Provider.of<CocktailCubit>(context, listen: false).state.contains(cocktail);
                                      if(!isAlreadySaved){
                                        Provider.of<CocktailCubit>(context, listen: false).addCocktail(cocktail);
                                        isAlreadySaved = true;
                                      }
                                      setState(() {
                                        _isAlreadySaved = isAlreadySaved;
                                      });
                                    },
                                  )

                                ],
                              ),),
                              Padding(padding: const EdgeInsets.symmetric(vertical: 15),child:  Text("Type : " + snapshot.data!.strCategory, style: GoogleFonts.ruda(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),),),
                              Text(snapshot.data!.strInstructions, style: GoogleFonts.ruda(
                                fontSize: 15,
                                fontWeight: FontWeight.w300,
                              ),),
                            ]

                        )
                          ,)
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
