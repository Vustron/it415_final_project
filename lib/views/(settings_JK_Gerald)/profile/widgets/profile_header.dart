import 'package:flutter/material.dart';

import 'package:babysitterapp/core/constants.dart';

Widget profileHeader(Color colors) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  // border color
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: <Widget>[
                    const CircleAvatar(
                      backgroundImage: AssetImage(avatar1),
                      radius: 100 / 2,
                    ),
                    Positioned(
                      top: 70,
                      left: 70,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3.0),
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        width: 10,
                        height: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Carole Howell',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: quickSandBold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on_sharp,
                          color: colors,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Davao City',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            fontFamily: nexaExtraLight,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text('0956-625-2536'),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'carolehowell@gmail.com',
                      style: TextStyle(color: colors),
                    )
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  color: Colors.red,
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
              ),
            ],
          )
        ],
      ),
    );
