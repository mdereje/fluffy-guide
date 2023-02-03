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
        // child: addItemReactiveForm(),
      ),
    );
  }

  ReactiveFormBuilder addItemReactiveForm() {
    return ReactiveFormBuilder(
      form: buildForm,
      builder: (context, form, child) {
        return Column(
          children: [
            ReactiveTextField<String>(
              formControlName: 'email',
              validationMessages: {
                ValidationMessage.required: (_) =>
                    'The email must not be empty',
                ValidationMessage.email: (_) =>
                    'The email value must be a valid email',
                'unique': (_) => 'This email is already in use',
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Email',
                helperText: '',
                helperStyle: TextStyle(height: 0.7),
                errorStyle: TextStyle(height: 0.7),
              ),
            ),
            ReactiveTextField<String>(
              formControlName: 'password',
              obscureText: true,
              validationMessages: {
                ValidationMessage.required: (_) =>
                    'The password must not be empty',
                ValidationMessage.minLength: (_) =>
                    'The password must be at least 8 characters',
              },
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Password',
                helperText: '',
                helperStyle: TextStyle(height: 0.7),
                errorStyle: TextStyle(height: 0.7),
              ),
            ),
            Row(
              children: [
                ReactiveCheckbox(formControlName: 'rememberMe'),
                const Text('Remember me')
              ],
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (form.valid) {
                  // Navigator.pop(context);
                  setState(() {
                    stuff = form.value.toString();
                  });
                } else {
                  form.markAllAsTouched();
                }
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () => form.resetState({
                'email': ControlState<String>(value: null),
                'password': ControlState<String>(value: null),
                'rememberMe': ControlState<bool>(value: false),
              }, removeFocus: true),
              child: const Text('Reset all'),
            ),
            Text(stuff)
          ],
        );
      },
    );
  }
}
