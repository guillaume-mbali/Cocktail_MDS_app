import 'package:cocktail_app_mds/models/random_cocktail.dart';
import 'package:cocktail_app_mds/repository/random_cocktail.dart';
import 'package:cocktail_app_mds/ui/screen/detail_cocktail.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {

  late Future<RandomCocktail> futureRandomCocktail;

  @override
  void initState() {
    super.initState();
    futureRandomCocktail = RandomCocktailRepository().fetchRandomCocktail();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Container(
          margin: const EdgeInsets.all(15.0),
          child:   Column(
            children: [
              FutureBuilder<RandomCocktail>(
                future: futureRandomCocktail,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return
                      Container(
                        child:  Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("In the spotlight 🍸", style: GoogleFonts.istokWeb(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),),
                            Card(
                              child:        InkWell(
                                child:
                                Container(
                                  width: double.infinity,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image:NetworkImage("${snapshot.data!.strDrinkThumb}")
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => const DetailCocktailPage(),
                                    settings: RouteSettings(
                                      arguments:  "${snapshot.data!.idDrink}",
                                    ),
                                  ),
                                  );
                                },
                              ),
                            ),
                            Text(snapshot.data!.strDrink , style: GoogleFonts.ruda(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),),

                           /* Padding(padding: EdgeInsets.all(20.0),
                                child: Text(snapshot.data!.strDrink , style: GoogleFonts.ruda(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),),)*/
                          ],
                        )
                        );
                      } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return const CircularProgressIndicator();
                  },
              ),
            ],
          ),
        )

    );
  }
}
