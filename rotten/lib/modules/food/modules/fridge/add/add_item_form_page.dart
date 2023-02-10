import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rotten/common/stepper_form_wizard.dart';

class AddFridgeItemFormPage extends StatefulWidget {
  AddFridgeItemFormPage({Key? key}) : super(key: key);

  @override
  State<AddFridgeItemFormPage> createState() => _AddFridgeItemFormPageState();
}

class _AddFridgeItemFormPageState extends State<AddFridgeItemFormPage> {
  FormGroup buildForm() => fb.group(<String, Object>{
        'email': FormControl<String>(
          validators: [Validators.required, Validators.email],
        ),
        'password': ['', Validators.required, Validators.minLength(8)],
        'rememberMe': false,
      });
  String stuff = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add an Item')),
      body: Center(
        child: StepperFormWizard(),
      ),
    );
  }
}
