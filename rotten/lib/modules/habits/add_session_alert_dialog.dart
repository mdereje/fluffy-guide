import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rotten/modules/habits/models/streak.dart';

class SessionAlertDialog extends StatelessWidget {
  final Streak s;

  SessionAlertDialog({
    Key? key,
    required this.s,
  }) : super(key: key);
  FocusNode _focusNode = FocusNode();
  final form = FormGroup({
    'start': FormControl<DateTime>(validators: [Validators.required]),
    'end': FormControl<DateTime>(validators: [Validators.required]),
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
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          ReactiveFormConsumer(builder: (context, formGroup, child) {
            return TextButton(
              onPressed: () {
                Session session = Session(formGroup.value['start'] as DateTime,
                    formGroup.value['end'] as DateTime);
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
        ReactiveDatePicker(
          formControlName: 'start',
          builder: (BuildContext context,
              ReactiveDatePickerDelegate<DateTime> picker, Widget? child) {
            return ReactiveTextField(
                onTap: (_) {
                  if (_focusNode.canRequestFocus) {
                    _focusNode.unfocus();
                    picker.showPicker();
                  }
                },
                valueAccessor: DateTimeValueAccessor(),
                formControlName: 'start',
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Start time',
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
        ReactiveDatePicker(
          formControlName: 'end',
          builder: (BuildContext context,
              ReactiveDatePickerDelegate<DateTime> picker, Widget? child) {
            return ReactiveTextField(
                onTap: (_) {
                  if (_focusNode.canRequestFocus) {
                    _focusNode.unfocus();
                    picker.showPicker();
                  }
                },
                valueAccessor: DateTimeValueAccessor(),
                formControlName: 'end',
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'End time',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                validationMessages: {
                  ValidationMessage.required: (error) => 'Must pick end time'
                });
          },
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 3),
        )
      ],
    );
  }
}
