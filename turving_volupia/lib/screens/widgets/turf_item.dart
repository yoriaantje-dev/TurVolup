import 'package:flutter/material.dart';

import '../../data/models/turv_model.dart';

class TurfItemCard extends StatelessWidget {
  const TurfItemCard(
      {super.key,
      required this.item,
      required this.removeOne,
      required this.addOne});

  final TurvableItem item;
  final dynamic addOne;
  final dynamic removeOne;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        color: Colors.redAccent,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: removeOne,
                    icon: const Icon(Icons.exposure_neg_1),
                    color: Colors.white,
                    iconSize: 25,
                  ),
                  Text(
                    item.count.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    onPressed: addOne,
                    icon: const Icon(Icons.exposure_plus_1),
                    color: Colors.white,
                    iconSize: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
