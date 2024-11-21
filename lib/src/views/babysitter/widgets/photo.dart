import 'package:flutter/material.dart';

Widget photoRow(
  BuildContext context,
  List<String> photos,
  void Function() fn,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        photos.length > 4 ? 4 : photos.length,
        (int index) {
          if (index == 3 && photos.length > 4) {
            return Stack(
              children: <Widget>[
                // The last image
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    photos[index],
                    width: MediaQuery.of(context).size.width * 0.20,
                    height: MediaQuery.of(context).size.height * 0.10,
                    fit: BoxFit.cover,
                  ),
                ),
                // Overlay with icon
                Positioned.fill(
                  child: InkWell(
                    onTap: fn,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Display the photo
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  photos[index],
                  width: MediaQuery.of(context).size.width * 0.20,
                  height: MediaQuery.of(context).size.height * 0.10,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
        },
      ),
    );
