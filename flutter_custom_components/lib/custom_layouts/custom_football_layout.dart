import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_custom_components/utils/constants.dart';
import 'package:flutter_custom_components/utils/demins.dart';
import 'package:flutter_custom_components/utils/string.dart';

class CustomFootballLayout extends StatefulWidget {
  const CustomFootballLayout({Key? key}) : super(key: key);

  @override
  State<CustomFootballLayout> createState() => _CustomFootballLayoutState();
}

class _CustomFootballLayoutState extends State<CustomFootballLayout> {
  Formations formations = Formations.FOUR_FOUR_TWO;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FootballPatchBackgroundView(),
          FormationView(
            formationType: formations,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.blue,
        onPressed: () {
          formations =
              Formations.values[Random().nextInt(Formations.values.length)];
          setState(() {});
        },
      ),
    );
  }
}

class FormationView extends StatelessWidget {
  final Formations formationType;

  const FormationView({Key? key, required this.formationType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _generateFormation(formationType),
    );
  }

  Widget _generateFormation(Formations formation) {
    switch (formation) {
      case Formations.FOUR_FOUR_TWO:
        return FormationViewFourFourTwo();
      case Formations.FOUR_TWO_THREE_ONE:
        return FormationViewFourTwoThreeOne();
      case Formations.FOUR_THREE_THREE:
        return FormationViewFourThreeThree();
      case Formations.THREE_FOUR_THREE:
        return FormationViewThreeFourThree();
    }
  }
}

class FormationViewThreeFourThree extends StatelessWidget {
  const FormationViewThreeFourThree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MARGIN_XL_FT),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(3, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(4, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 15),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(3, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          PlayerView(isGoolKeeper: true),
        ],
      ),
    );
  }
}

class FormationViewFourThreeThree extends StatelessWidget {
  const FormationViewFourThreeThree({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MARGIN_XL_FT),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(3, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(3, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 15),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(4, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          PlayerView(isGoolKeeper: true),
        ],
      ),
    );
  }
}

class FormationViewFourTwoThreeOne extends StatelessWidget {
  const FormationViewFourTwoThreeOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MARGIN_XL_FT),
      child: Column(
        children: [
          PlayerView(),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(3, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(2, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(4, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
          PlayerView(isGoolKeeper: true)
        ],
      ),
    );
  }
}

class FormationViewFourFourTwo extends StatelessWidget {
  const FormationViewFourFourTwo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MARGIN_XL_FT),
      child: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(2, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(4, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 15),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(4, (index) => const PlayerView()),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 12),
          PlayerView(isGoolKeeper: true),
        ],
      ),
    );
  }
}

class PlayerView extends StatelessWidget {
  final bool? isGoolKeeper;
  const PlayerView({
    Key? key,
    this.isGoolKeeper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          width: MARGIN_XL,
          height: MARGIN_XL,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MARGIN_MEDIUM_2),
              color: isGoolKeeper ?? false ? Colors.yellow : Colors.blue),
        ),
      ),
    );
  }
}

class FootballPatchBackgroundView extends StatelessWidget {
  const FootballPatchBackgroundView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        width: double.infinity,
        height: double.infinity,
        FOOTBALL_PATCH_BACKGROUND,
        fit: BoxFit.fill,
      ),
    );
  }
}
