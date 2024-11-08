import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/models/inputfield.dart';

import 'input.dart';
import 'select.dart';

class DynamicForm extends HookWidget {
  const DynamicForm({
    super.key,
    required this.fields,
    required this.onSubmit,
  });

  final List<InputFieldConfig> fields;
  final void Function(Map<String, String>) onSubmit;

  @override
  Widget build(BuildContext context) {
    final Map<String, TextEditingController> controllers = useMemoized(
      () => Map<String, TextEditingController>.fromEntries(
        fields.map(
          (InputFieldConfig field) => MapEntry<String, TextEditingController>(
            field.label,
            TextEditingController(text: field.value),
          ),
        ),
      ),
      <Object?>[fields],
    );

    final ValueNotifier<Map<String, String>> formData =
        useState<Map<String, String>>(
      Map<String, String>.fromEntries(
        fields.map(
          (InputFieldConfig field) =>
              MapEntry<String, String>(field.label, field.value ?? ''),
        ),
      ),
    );

    useEffect(() {
      return () {
        for (final TextEditingController controller in controllers.values) {
          controller.dispose();
        }
      };
    }, <Object?>[controllers]);

    return Column(
      children: <Widget>[
        ...fields.map((InputFieldConfig field) {
          Widget fieldWidget;
          switch (field.type) {
            case 'select':
              fieldWidget = CustomSelect<String>(
                items: field.options ?? <String>[],
                value: field.value,
                hint: field.hintText,
                onChanged: (String? value) {
                  formData.value = <String, String>{
                    ...formData.value,
                    field.label: value ?? '',
                  };
                },
              );
            case 'text':
            default:
              fieldWidget = CustomTextInput(
                controller: controllers[field.label],
                hintText: field.hintText,
                keyboardType: field.keyboardType ?? TextInputType.text,
                obscureText: field.obscureText,
                prefixIcon:
                    field.prefixIcon != null ? Icon(field.prefixIcon) : null,
                onChanged: (String value) {
                  formData.value = <String, String>{
                    ...formData.value,
                    field.label: value,
                  };
                },
              );
              break;
          }
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  field.label,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                fieldWidget,
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => onSubmit(formData.value),
            child: const Text('Submit'),
          ),
        ),
      ],
    );
  }
}
