import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rotten/dummy_data.dart';
import 'package:rotten/modules/habits/database/streaks_collection.dart';
import 'package:rotten/modules/habits/models/streak.dart';

class TrackNewStreakForm extends StatefulWidget {
  TrackNewStreakForm({
    Key? key,
  }) : super(key: key);

  @override
  State<TrackNewStreakForm> createState() => _TrackNewStreakFormState();
}

class _TrackNewStreakFormState extends State<TrackNewStreakForm> {
  Streak newStreak = Streak('title', 0, 0, false, DateTime.now());
  StreakCollectionOperation streakDb = StreakCollectionOperation();

  final form = FormGroup({
    'title': FormControl<String>(validators: [Validators.required]),
    'cheatDaysAllowedBeforeStreakReset':
        FormControl<int>(validators: [Validators.required, Validators.number]),
    'cheatDaysRefreshPeriod': FormControl<int>(validators: [
      Validators.required,
      Validators.number,
      // Compare validator not working so skipping for now.
      // Validates that 'cheatDaysAllowedBeforeStreakReset' is lower than 'cheatDaysRefreshPeriod'
    ]),
    'isSessionized': FormControl<bool>(value: false)
  }, validators: [
    Validators.compare('cheatDaysAllowedBeforeStreakReset',
        'cheatDaysRefreshPeriod', CompareOption.lower)
  ]);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ReactiveForm(
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
                    formControlName: 'title',
                    validationMessages: {
                      ValidationMessage.required: (error) =>
                          'Must have an streak name.'
                    },
                  ),
                  ReactiveTextField(
                    keyboardType: TextInputType.number,
                    onChanged: (control) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      hintText: '2 days (reset option below)',
                      labelText:
                          'How many skip days allowed before losing streak?',
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
                      setState(() {});
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
                          setState(() {});
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
                                  var title =
                                      formGroup.value['title'] as String;
                                  newStreak.title = title;
                                  newStreak.cheatDaysAllowedBeforeStreakReset =
                                      formGroup.value[
                                              'cheatDaysAllowedBeforeStreakReset']
                                          as int;
                                  newStreak.cheatDaysRefreshPeriod = formGroup
                                      .value['cheatDaysRefreshPeriod'] as int;
                                  newStreak.isSessionized =
                                      formGroup.value['isSessionized'] as bool;
                                  newStreak.currentStreak = 0;
                                  newStreak.createdAt = DateTime.now();
                                  newStreak.imageUrl = faker.image.unsplash
                                      .image(keyword: title);
                                  streakDb.addOrUpdateStreak(
                                      'test', null, newStreak);

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
          ),
        ]);
  }
}
