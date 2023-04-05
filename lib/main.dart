import 'package:flutter/material.dart';
import 'package:flutter_bloc_sample/bloc/domain/login/login_bloc.dart';
import 'package:flutter_bloc_sample/bloc/presentation/home_screen.dart';
import 'package:flutter_bloc_sample/bloc/presentation/splash_screen.dart';
import 'package:flutter_bloc_sample/bloc/presentation/user_details_screen.dart';
import 'package:flutter_bloc_sample/bloc/presentation/widgets/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return LoginBloc();
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
