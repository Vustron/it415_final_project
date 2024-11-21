import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:dartz/dartz.dart';
import 'dart:io';

import 'package:babysitterapp/src/controllers.dart';
import 'package:babysitterapp/src/constants.dart';
import 'package:babysitterapp/src/providers.dart';
import 'package:babysitterapp/src/services.dart';

class ImageField extends HookConsumerWidget {
  const ImageField({
    super.key,
    required this.name,
    required this.decoration,
    required this.userId,
    this.initialValue,
    this.onChanged,
  });

  final String name;
  final InputDecoration decoration;
  final String userId;
  final String? initialValue;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ValueNotifier<String?> imageUrl = useState<String?>(initialValue);
    final ValueNotifier<bool> isLoading = useState(false);
    final ValueNotifier<String?> error = useState<String?>(null);
    final AuthRepository authRepository = ref.watch(authRepositoryProvider);
    final AuthController authController =
        ref.watch(authControllerProvider.notifier);

    return FormBuilderField<String>(
      name: name,
      initialValue: initialValue,
      validator: (String? value) {
        if (error.value != null) {
          return error.value;
        }
        return null;
      },
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (decoration.labelText != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  decoration.labelText!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            Card(
              elevation: 1,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: field.hasError ? Colors.red : Colors.grey.shade300,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: () async {
                          if (isLoading.value) {
                            return;
                          }
                          try {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              maxWidth: 1024,
                              maxHeight: 1024,
                              imageQuality: 85,
                            );

                            if (image != null) {
                              isLoading.value = true;
                              error.value = null;

                              final Either<AuthFailure, String> result =
                                  await authRepository.uploadImages(
                                      userId, File(image.path));

                              result.fold(
                                (AuthFailure failure) {
                                  error.value = failure.message;
                                  field.validate();
                                },
                                (String url) {
                                  imageUrl.value = url;
                                  field.didChange(url);
                                  if (onChanged != null) {
                                    onChanged!(url);
                                  }
                                },
                              );
                            }
                          } catch (e) {
                            error.value = e.toString();
                            field.validate();
                          } finally {
                            isLoading.value = false;
                          }
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildPreview(
                            imageUrl.value,
                            isLoading.value,
                            field,
                            authController,
                            context,
                            imageUrl,
                            error,
                          ),
                        ),
                      ),
                    ),
                    if (isLoading.value)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: GlobalStyles.primaryButtonColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  field.errorText!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPreview(
    String? url,
    bool isLoading,
    FormFieldState<String> field,
    AuthController authController,
    BuildContext context,
    ValueNotifier<String?> imageUrl,
    ValueNotifier<String?> error,
  ) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: GlobalStyles.primaryButtonColor,
        ),
      );
    }

    if (url == null || url.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(FluentIcons.image_add_20_regular, size: 40),
            SizedBox(height: 8),
            Text('Select Image'),
          ],
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          placeholder: (BuildContext context, String url) => const Center(
            child: CircularProgressIndicator(
              color: GlobalStyles.primaryButtonColor,
            ),
          ),
          errorWidget: (BuildContext context, String url, Object error) =>
              const Center(
            child: Icon(
              FluentIcons.error_circle_20_regular,
              color: Colors.red,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                FluentIcons.delete_20_regular,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () async {
                try {
                  await authController.deleteProfileImage(userId, url, name);
                  imageUrl.value = null;
                  field.didChange(null);
                  if (onChanged != null) {
                    onChanged!(null);
                  }
                } catch (e) {
                  error.value = e.toString();
                  field.validate();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
