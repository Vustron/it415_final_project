import 'package:babysitterapp/core/constants/styles.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/models/inputfield.dart';

import 'select.dart';
import 'input.dart';

class DynamicForm extends HookWidget {
  const DynamicForm({
    super.key,
    required this.fields,
    required this.onSubmit,
    this.isLoading,
  });

  final List<InputFieldConfig> fields;
  final void Function(Map<String, String>) onSubmit;
  final ValueNotifier<bool>? isLoading;

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

    final ValueNotifier<Map<String, String?>> errors =
        useState<Map<String, String?>>(
      Map<String, String?>.fromEntries(
        fields.map(
          (InputFieldConfig field) =>
              MapEntry<String, String?>(field.label, null),
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

    final ValueNotifier<bool> defaultLoading = useState(false);

    bool validateForm() {
      bool isValid = true;
      final Map<String, String?> newErrors = {};
      for (final InputFieldConfig field in fields) {
        final String value = formData.value[field.label] ?? '';
        if (field.isRequired && value.isEmpty) {
          newErrors[field.label] = '${field.label} is required';
          isValid = false;
        } else {
          newErrors[field.label] = null;
        }
      }
      errors.value = newErrors;
      return isValid;
    }

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
                validator: (String? value) {
                  if (field.isRequired && (value == null || value.isEmpty)) {
                    return '${field.label} is required';
                  }
                  return null;
                },
                errorText: errors.value[field.label],
                enabled: !(isLoading ?? defaultLoading).value,
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
                errorText: errors.value[field.label],
                enabled: !(isLoading ?? defaultLoading).value,
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
                if (errors.value[field.label] != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      errors.value[field.label]!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          );
        }),
        const SizedBox(height: 16),
        ValueListenableBuilder<bool>(
          valueListenable: isLoading ?? defaultLoading,
          builder: (BuildContext context, bool loading, Widget? child) {
            return SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: loading
                    ? null
                    : () {
                        if (validateForm()) {
                          (isLoading ?? defaultLoading).value = true;
                          onSubmit(formData.value);
                        }
                      },
                child: loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: GlobalStyles.primaryButtonColor,
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Text('Submit'),
              ),
            );
          },
        ),
      ],
    );
  }
}
