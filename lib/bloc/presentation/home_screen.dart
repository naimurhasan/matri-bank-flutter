import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/domain/login/login_bloc.dart';
import 'package:flutter_bloc_sample/bloc/presentation/widgets/login_screen.dart';

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
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Matri Bank'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(LogoutButtonPressed());
                  },
                ),
              ],
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Your account balance is',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    child: Text('View Transactions'),
                    onPressed: () {
                      // Navigate to transactions screen
                    },
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Navigate to transfer screen
              },
              child: Icon(Icons.send),
            ),
          );
        }
        return LoginScreen();
      },
    );
  }
}
