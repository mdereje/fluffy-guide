import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:rotten/common/utils.dart';
import 'package:rotten/modules/habits/config.dart';
import 'package:rotten/modules/habits/models/streak.dart';

class SessionAlertDialog extends StatefulWidget {
  final Streak s;

  SessionAlertDialog({
    Key? key,
    required this.s,
  }) : super(key: key);

  @override
  State<SessionAlertDialog> createState() => _SessionAlertDialogState();
}

class _SessionAlertDialogState extends State<SessionAlertDialog> {
  FocusNode _focusNode = FocusNode();
  bool displayCustom = timeSelectionRadio['custom']!['selected'] as bool;
  var selectedKey = '';

  final form = FormGroup({
    'start': FormControl<TimeOfDay>(
        validators: [Validators.required], value: TimeOfDay.now()),
    'end': FormControl<TimeOfDay>(
        validators: [Validators.required], value: TimeOfDay.now()),
    'quick': FormControl<String>()
  });

  List<Widget> quickSettings = timeSelectionRadio.values.map((item) {
    return Text(item['label'] as String);
  }).toList();

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: AlertDialog(
        title: Text('Add streak for ${widget.s.title}'),
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
                var endTime =
                    dateTimeFromTimeOfDay(formGroup.value['end'] as TimeOfDay);

                if (!displayCustom) {
                  var selection = timeSelectionRadio[selectedKey];
                  endTime = DateTime.now().add(selection!['value'] as Duration);
                }

                Session session =
                    Session(dateTimeFromTimeOfDay(startTime), endTime);

                widget.s.sessions ??= <Session>[];
                widget.s.sessions!.add(session);
                Navigator.pop(context, widget.s);
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
        displayCustom
            ? ReactiveTimePicker(
                formControlName: 'start',
                builder: (BuildContext context,
                    ReactiveTimePickerDelegate picker, Widget? child) {
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
              )
            : SizedBox.shrink(),
        displayCustom
            ? ReactiveTimePicker(
                formControlName: 'end',
                builder: (BuildContext context,
                    ReactiveTimePickerDelegate picker, Widget? child) {
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
                        ValidationMessage.required: (error) =>
                            'Must pick end time.'
                      });
                },
              )
            : SizedBox.shrink(),
        const SizedBox(height: 5),
        // Row(
        //   children: [
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            setState(() {
              displayCustom = index == 0;
              selectedKey = timeSelectionRadio.keys.elementAt(index);

              // The button that is tapped is set to true, and the others to false.
              for (int i = 0; i < timeSelectionRadio.length; i++) {
                timeSelectionRadio[timeSelectionRadio.keys.elementAt(i)]![
                    'selected'] = i == index;
              }
            });
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          isSelected: timeSelectionRadio.values.map((item) {
            return item['selected'] as bool;
          }).toList(),
          children: quickSettings,
        ),
      ],
      //   )
      // ],
    );
  }
}
