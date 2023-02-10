import 'package:flutter/material.dart';
import 'package:rotten/common/stepper_form_wizard.dart';

class AddFridgeItemFormPage extends StatefulWidget {
  AddFridgeItemFormPage({Key? key}) : super(key: key);

  @override
  State<AddFridgeItemFormPage> createState() => _AddFridgeItemFormPageState();
}

class _AddFridgeItemFormPageState extends State<AddFridgeItemFormPage> {
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
