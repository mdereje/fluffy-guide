import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rotten/common/utils.dart';
import 'package:rotten/modules/habits/models/streak.dart';

class SessionAlertDialog extends StatelessWidget {
  final Streak s;

  SessionAlertDialog({
    Key? key,
    required this.s,
  }) : super(key: key);

  FocusNode _focusNode = FocusNode();
  final form = FormGroup({
    'start': FormControl<TimeOfDay>(
        validators: [Validators.required], value: TimeOfDay.now()),
    'end': FormControl<TimeOfDay>(
        validators: [Validators.required], value: TimeOfDay.now()),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: AlertDialog(
        title: Text('Add streak for ${s.title}'),
        content: sessonized(),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: const Text('Cancel'),
          ),
          ReactiveFormConsumer(builder: (context, formGroup, child) {
            return TextButton(
              onPressed: () {
                final startTime = formGroup.value['start'] as TimeOfDay;
                final endTime = formGroup.value['end'] as TimeOfDay;

                Session session = Session(dateTimeFromTimeOfDay(startTime),
                    dateTimeFromTimeOfDay(endTime));

                s.sessions ??= <Session>[];
                s.sessions!.add(session);
                Navigator.pop(context, s);
              },
              child: const Text('Add'),
            );
          }),
        ],
      ),
    );
  }

  Widget sessonized() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        ReactiveTimePicker(
          formControlName: 'start',
          builder: (BuildContext context, ReactiveTimePickerDelegate picker,
              Widget? child) {
            return ReactiveTextField(
                onTap: (_) {
                  if (_focusNode.canRequestFocus) {
                    _focusNode.unfocus();
                    picker.showPicker();
                  }
                },
                valueAccessor: TimeOfDayValueAccessor(),
                formControlName: 'start',
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start time',
                  suffixIcon: Icon(Icons.timelapse),
                ),
                validationMessages: {
                  ValidationMessage.required: (error) =>
                      'Must pick a start time.'
                });
          },
        ),
        ReactiveTimePicker(
          formControlName: 'end',
          builder: (BuildContext context, ReactiveTimePickerDelegate picker,
              Widget? child) {
            return ReactiveTextField(
                onTap: (_) {
                  if (_focusNode.canRequestFocus) {
                    _focusNode.unfocus();
                    picker.showPicker();
                  }
                },
                valueAccessor: TimeOfDayValueAccessor(),
                formControlName: 'end',
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End time',
                  suffixIcon: Icon(Icons.timelapse),
                ),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Must pick end time.'
                });
          },
        )
      ],
    );
  }
}
