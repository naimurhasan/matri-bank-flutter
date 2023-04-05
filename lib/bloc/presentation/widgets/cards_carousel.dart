import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';

class CardsCarousel extends StatelessWidget {
  final List<AccountCard> cards;
  const CardsCarousel({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cards.length,
        shrinkWrap: true, itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 250,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${cards[index].name}", style: Theme.of(context).textTheme.titleMedium,),
                    SizedBox(height: 8,),
                    Text("Card No: ${cards[index].cardNo.substring(0, 8)} ****"),
                    SizedBox(height: 8,),
                    Text("Validity: ${cards[index].validity}"),
                  ],
                ),
              ),
            ),
          );
      },

      ),
    );
  }
}
