import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/domain/login/login_bloc.dart';
import 'package:flutter_bloc_sample/bloc/presentation/add_card_screen.dart';
import 'package:flutter_bloc_sample/bloc/presentation/login_screen.dart';
import 'package:flutter_bloc_sample/bloc/presentation/widgets/cards_carousel.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Matir Bank'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    BlocProvider.of<AccountBloc>(context)
                        .add(LogoutButtonPressed());
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                    ),
                    Text(
                      'Welcome, ${state.accountDetails.name}',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Your account balance is, ${state.accountDetails.balance}',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Your cards',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        CircleAvatar(
                          child: IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_) => CardAddEditScreen())).then((value){
                              if(value == true){
                                Flushbar(
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  message: "Card added successfully",
                                  duration: Duration(seconds: 2),
                                )..show(context);
                              }
                            });
                          }, icon: Icon(Icons.add),),
                        )
                      ],
                    ),
                    SizedBox(height: 16),
                    CardsCarousel(cards: state.accountDetails.cards),
                  ],
                ),
              ),
            ),
          );
        }
        return LoginScreen();
      },
    );
  }
}
