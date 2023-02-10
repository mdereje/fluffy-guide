import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rotten/modules/food/constants.dart';
import 'package:rotten/modules/food/database/fridge_collection.dart';
import 'package:rotten/modules/food/models/fridge_item.dart';

class StepperFormWizard extends StatefulWidget {
  StepperFormWizard({Key? key}) : super(key: key);

  @override
  State<StepperFormWizard> createState() => _StepperFormWizardState();
}

class _StepperFormWizardState extends State<StepperFormWizard> {
  var fridgeOperations = FridgeCollectionOperations();

  int currentStep = 0;
  String finalForm = '';
  late FocusNode _focusNode;

  final form = FormGroup({
    'category': FormControl<String>(validators: [Validators.required]),
    'name': FormControl(validators: [Validators.required]),
    'expiry': FormControl<DateTime>(validators: [Validators.required])
  });

  FridgeItem fridgeItem = FridgeItem('test', 'no-users', '');

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ReactiveForm(
        formGroup: form,
        child: Column(
          children: [
            Stepper(
              currentStep: currentStep,
              onStepTapped: (step) => tapped(step),
              onStepContinue: continued,
              onStepCancel: cancel,
              steps: <Step>[
                Step(
                  title: Text('Category'),
                  content: ReactiveDropdownField<String>(
                      items: categoriesMap.keys
                          .map((String c) =>
                              DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      decoration: InputDecoration(
                        labelText:
                            'Select which category of food you think it belongs to?',
                        suffixIcon: Icon(Icons.category),
                      ),
                      formControlName: 'category',
                      validationMessages: {
                        ValidationMessage.required: (error) =>
                            'Select from exising categories.'
                      }),
                  isActive: currentStep >= 0,
                  state: currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Text('Item Name'),
                  content: ReactiveTextField(
                    decoration: InputDecoration(
                      labelText: 'What would you like to call this item?',
                      suffixIcon: Icon(Icons.text_fields),
                    ),
                    formControlName: 'name',
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          'Must have an item name.'
                    },
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Text('Expiry'),
                  content: Column(children: [
                    ReactiveDatePicker(
                      formControlName: 'expiry',
                      builder: (BuildContext context,
                          ReactiveDatePickerDelegate<DateTime> picker,
                          Widget? child) {
                        return ReactiveTextField(
                            onTap: (_) {
                              if (_focusNode.canRequestFocus) {
                                _focusNode.unfocus();
                                picker.showPicker();
                              }
                            },
                            valueAccessor: DateTimeValueAccessor(),
                            focusNode: _focusNode,
                            formControlName: 'expiry',
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'When do you guess it will expire?',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Must pick a date to get notified about when it will expire.'
                            });
                      },
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 3),
                    ),
                  ]),
                  isActive: currentStep >= 0,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
            form.valid
                ? ReactiveFormConsumer(builder: ((context, formGroup, child) {
                    return ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: ((context) {
                                return AlertDialog(
                                  title: Text('Hello'),
                                  content: Text(form.value.toString()),
                                  actions: [
                                    TextButton(
                                      child: Text('ok'),
                                      onPressed: () {
                                        fridgeItem.category =
                                            form.value['category'] as String;
                                        fridgeItem.name =
                                            form.value['name'] as String;
                                        fridgeItem.expiry =
                                            form.value['expiry'] as DateTime;

                                        fridgeOperations
                                            .upsertFridgeItem(fridgeItem);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }));
                        },
                        child: Text('Submit'));
                  }))
                : TextButton(
                    onPressed: (() => Navigator.of(context).pop()),
                    child: Text('Cancel')),
          ],
        ),
      ),
    ]);
  }

  tapped(int step) {
    setState(() => currentStep = step);
  }

  continued() {
    setState(() {});
    currentStep < 2 ? setState(() => currentStep += 1) : null;
  }

  cancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }
}
