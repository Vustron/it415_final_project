import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

class ValidIdUpload extends HookWidget {
  const ValidIdUpload({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isImageListVisible = useState(false);
    const List<String> images = <String>[avatar1, avatar2];

    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            isImageListVisible.value = !isImageListVisible.value;
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.file_download_outlined,
                      color: GlobalStyles.primaryButtonColor,
                      size: 35,
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Valid ID',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'List of all your valid ID',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          height: isImageListVisible.value ? 100 : 0,
          child: isImageListVisible.value
              ? ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        images[index],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                )
              : null,
        ),
      ],
    );
  }
}
