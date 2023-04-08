import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/domain/login/login_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginScreen extends StatelessWidget {
  FormGroup form = FormGroup({
    'phone': FormControl<String>(
      validators: [Validators.required, Validators.pattern(r'^01\d{9}$')],
      value: '01737959836',
    ),
    'password': FormControl<String>(
      validators: [Validators.required, Validators.minLength(4)],
      value: 'Naimur',
    ),
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, LoginState>(builder: (context, state) {
      if (state is LoginSuccess) {
        form.reset();
      } else if (state is LoginError) {
        form.control('phone').value = state.phone;
        form.control('password').value = state.password;
      }
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              if (state is LoginError)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${state.message}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 16),
              ReactiveForm(
                formGroup: form,
                child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: 'phone',
                      decoration: InputDecoration(
                        labelText: 'Phone',
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validationMessages: {
                        'pattern': (error) => 'Invalid phone number',
                      },
                    ),
                    SizedBox(height: 16),
                    ReactiveTextField(
                      formControlName: 'password',
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    state is SubmittingLogin
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            child: Text('Login'),
                            onPressed: () {
                              if (form.valid) {
                                BlocProvider.of<AccountBloc>(context)
                                    .add(LoginButtonPressed(
                                  phone: form.control('phone').value,
                                  password: form.control('password').value,
                                  context: context,
                                ));
                              } else {
                                Flushbar(
                                  flushbarPosition: FlushbarPosition.BOTTOM,
                                  message: "Invalid form",
                                  duration: Duration(seconds: 2),
                                )..show(context);
                              }
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
