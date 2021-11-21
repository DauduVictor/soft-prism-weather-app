import 'package:flutter/material.dart';
import 'package:softprism/components/transparent_container.dart';

class ReusableHeaderLocation extends StatelessWidget {

  final String location;

  const ReusableHeaderLocation({
    required this.location,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ReusableTransparentContainer(
        borderRadius: 20.0,
        colorOpacity: 0.1,
        horizontalPadding: 16.0,
        verticalPadding: 14.0,
        widget: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_sharp,
              color: Colors.white,
              size: 23,
            ),
            const SizedBox(width: 4.1),
            Text(
              location,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        )
    );
  }
}