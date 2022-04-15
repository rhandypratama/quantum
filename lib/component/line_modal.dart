import 'package:flutter/material.dart';

import '../constant.dart';

class LineModal extends StatelessWidget {
  const LineModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 4,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(kRadiusS)),
            // color: Colors.black12,
            color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
          
          ),
        ),
        const SizedBox(height: 3),
        Container(
          height: 4,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(kRadiusS)),
            color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor!,
          
          ),
        ),
      ],
    );
  }
}