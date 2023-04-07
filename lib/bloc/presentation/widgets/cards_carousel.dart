import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';
import 'package:flutter_bloc_sample/bloc/presentation/widgets/card_carousel_item.dart';

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
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return CardCarouselItem(
            card:  cards[index],
          );
        },
      ),
    );
  }
}
