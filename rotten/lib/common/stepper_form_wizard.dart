import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rotten/modules/food/constants.dart';

class StepperFormWizard extends StatefulWidget {
  StepperFormWizard({Key? key}) : super(key: key);

  @override
  State<StepperFormWizard> createState() => _StepperFormWizardState();
}

class _StepperFormWizardState extends State<StepperFormWizard> {
  // List<String> categories = categoriesMap.keys.toList();

  int currentStep = 0;
  String finalForm = '';

  final form = FormGroup({
    'category': FormControl(value: ''),
    'name': FormControl(validators: [Validators.required]),
    'expiry': FormControl()
  });
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
              onStepContinue: continued(form),
              onStepCancel: cancel,
              steps: <Step>[
                Step(
                  title: Text('Category'),
                  content: ReactiveTextField(
                    formControlName: 'category',
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 0
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Text('Item Name'),
                  content: ReactiveTextField(
                    formControlName: 'name',
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          'Item name is required you fool'
                    },
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: Text('Expiry'),
                  content: ReactiveTextField(
                    formControlName: 'expiry',
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
            ReactiveFormConsumer(builder: ((context, formGroup, child) {
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
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }));
                  },
                  child: Text('submit'));
            }))
          ],
        ),
      ),
    ]);
  }

  tapped(int step) {
    setState(() => currentStep = step);
  }

  continued(FormGroup fg) {
    if (currentStep == 2) {
      setState(() {
        finalForm = fg.value.toString();
      });
    }
    currentStep < 2 ? setState(() => currentStep += 1) : null;
  }

  cancel() {
    currentStep > 0 ? setState(() => currentStep -= 1) : null;
  }
}
