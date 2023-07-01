import 'package:flutter/material.dart';

import 'hero_list_page.dart';

class HeroesListVertical extends StatelessWidget {
  const HeroesListVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,),
      body: SafeArea(
        child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(
            width: 16,
          ),
          padding: const EdgeInsets.all(5),
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (context, index) => ListTile(
            title: Row(
              children: [

                HeroCard(
                    data: HeroData(
                        tag: "tag$index",
                        image: "assets/images/avatar-${index + 1}.png",
                        username: "username",
                        size: 100),
                    onPressCard: (value) {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
