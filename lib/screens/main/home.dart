// utils
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        leading: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/placeholder_logo.png'),
          ),
        ),
        centerTitle: false,
        title: const Text(
          'Hello Arvin Sison!',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Nexa-Heavy'),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              FluentIcons.alert_12_regular,
              color: Colors.black,
              size: 31,
            ),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: <Widget>[
                  titleBabySitterNearby(),
                  scrollHorizontal(),
                  titleTopRatedBabySitter(),
                  topRatedBabySitterCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//widgets
Widget titleBabySitterNearby() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'BabySitters nearby',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'See all',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );

Widget titleTopRatedBabySitter() => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            'Top Rated',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'See all',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );

Widget babySitterCardHeader() => const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1631947430066-48c30d57b943?q=80&w=1432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          radius: 30,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Ms. Jen Mea',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text('₱ 210/hr'),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(FluentIcons.location_12_filled, size: 14),
                Text('Panabo City'),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.yellow,
            ),
            Text('4.5')
          ],
        )
      ],
    );

Widget babySitterCardBio() => Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      width: 300,
      child: const Text(
        'A really long text string that will not fit within its box A really long text string that will not fit within its box',
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        maxLines: 2,
        style: TextStyle(fontSize: 16),
      ),
    );

Widget babySitterCardButton() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: Colors.lightBlue,
            foregroundColor: Colors.white,
          ),
          child: const Text('View profile'),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.lightBlue),
            foregroundColor: Colors.lightBlue,
          ),
          child: const Text('Message'),
        )
      ],
    );

Widget babySitterCardNearby() => SizedBox(
      width: 360,
      child: Card(
        color: const Color.fromRGBO(237, 237, 241, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              babySitterCardHeader(),
              babySitterCardBio(),
              babySitterCardButton(),
            ],
          ),
        ),
      ),
    );

Widget scrollHorizontal() => SizedBox(
      height: 200, // Set height for the horizontal ListView
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Set to horizontal scrolling
        itemCount: 10, // Number of items in the list
        itemBuilder: (BuildContext context, int index) {
          return babySitterCardNearby();
        },
      ),
    );

Widget topRatedBabySitter() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1631947430066-48c30d57b943?q=80&w=1432&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
          radius: 30,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Ms. Jen Mea',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5),
                Text('₱ 210/hr'),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                  size: 16,
                  color: Colors.yellow,
                ),
                Text('4.5 / 808 reviews'),
              ],
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: () {},
              color: Colors.pink,
              icon: const Icon(
                FluentIcons.heart_12_regular,
              ),
            )
          ],
        )
      ],
    );

Widget topRatedBabySitterCard() => SizedBox(
      width: 360,
      child: Card(
        color: const Color.fromRGBO(237, 237, 241, 1),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              topRatedBabySitter(),
            ],
          ),
        ),
      ),
    );
