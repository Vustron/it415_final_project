import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hugeicons/hugeicons.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final ScrollController _scrollController = ScrollController();

  Widget requestButton() => GFIconButton(
        onPressed: () {},
        icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedTimeSchedule,
          color: Colors.white,
        ),
      );

  Widget searchHeader() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'John Doe',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand_Bold'),
          ),
          Row(
            children: [
              for (int i = 0; i < 5; i++)
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 12,
                ),
            ],
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Row(
            children: [
              Icon(
                Icons.location_on,
                color: Color.fromARGB(127, 158, 158, 158),
                size: 15,
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                'Panabo City',
                style: TextStyle(fontSize: 15, fontFamily: 'Quicksand'),
              )
            ],
          ),
        ],
      );

  Widget showSearched() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              radius: 20,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            flex: 5,
            child: searchHeader(),
          ),
          requestButton()
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        controller: _scrollController,
        shrinkWrap: true,
        children: <Widget>[
          for (int i = 0; i < 5; i++) ...<Widget>[
            SizedBox(
              height: 10,
              child: Container(color: const Color.fromARGB(38, 248, 193, 211)),
            ),
            const SizedBox(
              height: 10.0,
            ),
            showSearched(),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ],
      ),
    );
  }
}
