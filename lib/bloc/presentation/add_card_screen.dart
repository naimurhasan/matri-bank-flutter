import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/bloc/data/model/card_model.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../domain/card/card_bloc.dart';

class CardAddEditScreen extends StatefulWidget {
  final AccountCard? editCard;

  CardAddEditScreen({Key? key, this.editCard}) : super(key: key);

  @override
  State<CardAddEditScreen> createState() => _CardAddEditScreenState();
}

class _CardAddEditScreenState extends State<CardAddEditScreen> {
  FormGroup form = FormGroup({
    'name': FormControl<String>(
      validators: [
        Validators.required,
        Validators.pattern(r'^[a-zA-Z\s]{1,30}$')
      ],
      value: 'Naimur',
    ),
    'cardNo': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(9),
        Validators.maxLength(9)
      ],
      value: '958648348',
    ),
    'validity': FormControl<String>(
      validators: [Validators.required, Validators.pattern(r'^[0-9]{4}$')],
      value: '1222',
    ),
    'cvv': FormControl<String>(
      validators: [Validators.required, Validators.pattern(r'^[0-9]{3}$')],
      value: '657',
    ),
  });

  @override
  void initState() {
    if (widget.editCard != null) {
      form.control('name').value = widget.editCard!.name;
      form.control('cardNo').value = widget.editCard!.cardNo;
      form.control('validity').value = widget.editCard!.validity;
      form.control('cvv').value = widget.editCard!.cvv;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => CardBloc(),
        child: BlocBuilder<CardBloc, CardState>(builder: (context, state) {
          if (state is CardAddError) {
            form.control('name').value = state.name;
            form.control('cardNo').value = state.cardNo;
            form.control('validity').value = state.validity;
            form.control('cvv').value = state.cvv;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.editCard == null ? 'Add Card' : 'Edit Card'),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state is CardAddError)
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
                              formControlName: 'name',
                              decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(),
                              ),
                              validationMessages: {
                                'pattern': (error) => 'Invalid name',
                              },
                            ),
                            SizedBox(height: 16),
                            ReactiveTextField(
                              formControlName: 'cardNo',
                              decoration: InputDecoration(
                                labelText: 'Card No',
                                prefixIcon: Icon(Icons.credit_card),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validationMessages: {
                                'minLength': (error) => 'Invalid card number',
                                'maxLength': (error) => 'Invalid card number',
                              },
                            ),
                            SizedBox(height: 16),
                            ReactiveTextField(
                              formControlName: 'validity',
                              decoration: InputDecoration(
                                labelText: 'Validity',
                                prefixIcon: Icon(Icons.date_range),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validationMessages: {
                                'pattern': (error) => 'Invalid validity',
                              },
                            ),
                            SizedBox(height: 16),
                            ReactiveTextField(
                              formControlName: 'cvv',
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                              validationMessages: {
                                'pattern': (error) => 'Invalid CVV',
                              },
                            ),
                            SizedBox(height: 16),
                            state is AddingNewCard || state is CardUpdating
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () {
                                      // hide keyboard
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      if (form.valid) {
                                        if (widget.editCard != null) {
                                          // update
                                          final card =
                                              widget.editCard!.copyWith(
                                            name: form.control('name').value,
                                            cardNo:
                                                form.control('cardNo').value,
                                            validity:
                                                form.control('validity').value,
                                            cvv: form.control('cvv').value,
                                          );
                                          context
                                              .read<CardBloc>()
                                              .add(UpdateCardEvent(
                                                accountCard: card,
                                                context: context,
                                              ));
                                        } else {
                                          // add new
                                          context
                                              .read<CardBloc>()
                                              .add(AddNewCardEvent(
                                                name:
                                                    form.control('name').value,
                                                cardNo: form
                                                    .control('cardNo')
                                                    .value,
                                                validity: form
                                                    .control('validity')
                                                    .value,
                                                cvv: form.control('cvv').value,
                                                context: context,
                                              ));
                                        }
                                      } else {
                                        Flushbar(
                                          flushbarPosition: FlushbarPosition.BOTTOM,
                                          message: "Invalid form",
                                          duration: Duration(seconds: 2),
                                        )..show(context);
                                      }
                                    },
                                    child: Text(widget.editCard == null ? 'Add Card' : "Update Card"),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
