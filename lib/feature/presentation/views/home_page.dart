import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_app/feature/presentation/views/search_page.dart';
import 'package:marvel_app/feature/presentation/widgets/character_list_view.dart';


enum Route { characters, comics }

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 13),
          child: Image.asset(
            "assets/images/logo.png",
            height: 30,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const SearchPage()));
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset('assets/icons/search.png', width: 25),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 25, top: 10, right: 25),
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                    ),
                  ),
                  child: const Text('Popular'),
                ),
                TextButton(onPressed: () {}, child: const Text('A - Z')),
                TextButton(onPressed: () {}, child: const Text('Last viewed')),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: CharacterListView(),
            ),
          ],
        ),
      ),
    );
  }
}
