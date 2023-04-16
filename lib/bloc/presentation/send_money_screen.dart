import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/domain/login/login_bloc.dart';
import 'package:flutter_bloc_sample/bloc/domain/send_money/send_money_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

class SendMoneyScreen extends StatefulWidget {
  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> with SingleTickerProviderStateMixin{
  final FormGroup form = FormGroup({
    'amount': FormControl<String>(
      validators: [Validators.required, Validators.pattern(r'^\d+\.?\d*$')],
      value: '20',
    ),
    'destination': FormControl<String>(
      validators: [Validators.required, Validators.minLength(4)],
      value: '01737959837',
    ),
  });

  late AnimationController anmController;
  late Animation<double> animation;

  @override
  void initState() {
    anmController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = Tween<double>(begin: 0, end: 1).animate(anmController);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendMoneyBloc, SendMoneyState>(builder: (context, state) {
      if (state is LoginSuccess) {
        form.reset();
      } else if (state is SendMoneyFailure) {
        form.control('amount').value = state.amount;
        form.control('destination').value = state.destination;
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Send Money"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is SendMoneyFailure)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${state.error}",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 16),
              ReactiveForm(
                formGroup: form,
                child: Column(
                  children: [
                    ReactiveTextField(
                      formControlName: 'destination',
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Destination',
                        prefixIcon: Icon(Icons.perm_identity),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    ReactiveTextField(
                      formControlName: 'amount',
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validationMessages: {
                        'pattern': (error) => 'Invalid phone number',
                      },
                    ),
                    SizedBox(height: 16),
                    state is SubmittingSendMoney
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                      child: Text('Send Money'),
                      onPressed: () {
                        if (form.valid) {
                          BlocProvider.of<SendMoneyBloc>(context)
                              .add(SendMoneyButtonPressed(context: context, amount: form.control('amount').value, destination: destination));
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
