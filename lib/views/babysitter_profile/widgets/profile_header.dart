import 'package:babysitterapp/core/constants/assets.dart';
import 'package:flutter/material.dart';

Widget profileHeader(Color colors) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              const SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage: AssetImage(avatar1),
                ),
              ),
              Expanded(
                flex: 5,
                child: Column(
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                ),
              ),
            ],
          )
        ],
      ),
    );
