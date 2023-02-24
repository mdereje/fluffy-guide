import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class TrackNewStreakForm extends StatefulWidget {
  TrackNewStreakForm({
    Key? key,
  }) : super(key: key);

  @override
  State<TrackNewStreakForm> createState() => _TrackNewStreakFormState();
}

class _TrackNewStreakFormState extends State<TrackNewStreakForm> {
  final form = FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'cheatDaysAllowedBeforeStreakReset':
        FormControl<int>(validators: [Validators.required, Validators.number]),
    'cheatDaysRefreshPeriod': FormControl<int>(validators: [
      Validators.required,
      Validators.number,
      // Compare validator not working so skipping for now.
      // Validates that 'cheatDaysAllowedBeforeStreakReset' is lower than 'cheatDaysRefreshPeriod'
      // Validators.compare('cheatDaysAllowedBeforeStreakReset',
      //     'cheatDaysRefreshPeriod', CompareOption.lower)
    ]),
    'isSessionized': FormControl<bool>(value: false)
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ReactiveForm(
        formGroup: form,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ReactiveTextField(
              onChanged: (control) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText:
                    'What would you like to label the streak? (ex: Exercise, Read)',
                suffixIcon: Icon(Icons.text_fields),
              ),
              formControlName: 'name',
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'Must have an streak name.'
              },
            ),
            ReactiveTextField(
              keyboardType: TextInputType.number,
              onEditingComplete: (control) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: '2 days (reset option below)',
                labelText: 'How many skip days allowed before losing streak?',
                suffixIcon: Icon(Icons.numbers),
              ),
              formControlName: 'cheatDaysAllowedBeforeStreakReset',
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'Must allot skip days (0 is allowed, it means no skip days).',
                ValidationMessage.number: (error) => 'Must be a number'
              },
            ),
            ReactiveTextField(
              keyboardType: TextInputType.number,
              onChanged: (control) {
                setState(() {
                  Validators.compare('cheatDaysAllowedBeforeStreakReset',
                      'cheatDaysRefreshPeriod', CompareOption.lower);
                });
              },
              decoration: InputDecoration(
                hintText: '# of days (ex. every 7 days)',
                labelText:
                    'How frequently should the \'allowed\' skips be refreshed?',
                suffixIcon: Icon(Icons.numbers),
              ),
              formControlName: 'cheatDaysRefreshPeriod',
              validationMessages: {
                ValidationMessage.required: (error) =>
                    'Must allot a period to refill used skip days.',
                ValidationMessage.number: (error) => 'Must be a number',
                ValidationMessage.compare: (error) =>
                    'Refill days must be greater than skip days allowed.'
              },
            ),
            Row(
              children: [
                Text(
                    'Sessonize this streak tracking? (enable duration of activity tracking)'),
                ReactiveCheckbox(
                  onChanged: (control) {
                    setState(() {
                      print(form.rawValue);
                    });
                  },
                  formControlName: 'isSessionized',
                )
              ],
            ),
            Row(
              children: [
                form.valid
                    ? ReactiveFormConsumer(
                        builder: ((context, formGroup, child) {
                        return ElevatedButton(
                          onPressed: (() {
                            showAboutDialog(
                                context: context,
                                applicationLegalese:
                                    formGroup.rawValue.toString());
                            Navigator.of(context).pop();
                          }),
                          child: Text('Streakify Acitvity!'),
                        );
                      }))
                    : SizedBox.shrink(),
                TextButton(
                    onPressed: (() => Navigator.of(context).pop()),
                    child: Text('Cancel')),
              ],
            )
          ],
        ),
      ),
    ]);
  }
}
