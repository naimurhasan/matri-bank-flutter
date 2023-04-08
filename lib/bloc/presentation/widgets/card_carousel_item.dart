import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';
import 'package:flutter_bloc_sample/bloc/domain/card/card_bloc.dart';
import 'package:flutter_bloc_sample/bloc/presentation/add_card_screen.dart';

class CardCarouselItem extends StatelessWidget {
  final AccountCard card;

  const CardCarouselItem({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CardBloc(),
      child: BlocBuilder<CardBloc, CardState>(
          builder: (BuildContext context, state) {
        return Container(
          width: 250,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${card.name}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Card No: ${card.cardNo.substring(0, 8)} ****"),
                  SizedBox(
                    height: 8,
                  ),
                  Text("Validity: ${card.validity}"),
                  SizedBox(
                    height: 8,
                  ),
                  state is CardDeleting
                      ? CircularProgressIndicator()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  // BlocProvider.of<CardBloc>(context).add(
                                  //     DeleteCardEvent(
                                  //         accountCard: card, context: context));
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CardAddEditScreen(editCard: card,))).then((value){
                                    if(value == true){
                                      Flushbar(
                                        flushbarPosition: FlushbarPosition.BOTTOM,
                                        message: "Card updated successfully",
                                        duration: Duration(seconds: 2),
                                      )..show(context);
                                    }
                                  });

                                }),
                            IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  BlocProvider.of<CardBloc>(context).add(
                                      DeleteCardEvent(
                                          accountCard: card, context: context));
                                })
                          ],),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
