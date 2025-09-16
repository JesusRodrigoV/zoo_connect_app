import 'package:flutter/material.dart' hide ImageInfo;
import 'package:zoo_connect_app/widgets/shared/carousel_card.dart';
import './modelocr.dart';

class Carousel extends StatefulWidget {
  const Carousel({super.key});

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.sizeOf(context).height;
    return ListView(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: height / 2),
          child: CarouselView.weighted(
            controller: controller,
            itemSnapping: true,
            flexWeights: const <int>[1, 7, 1],
            children: ImageInfo.values.map((ImageInfo image) {
              return CarouselCard(imageInfo: image);
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
          child: Text('Multi-browse layout'),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 50),
          child: CarouselView.weighted(
            flexWeights: const <int>[1, 2, 3, 2, 1],
            consumeMaxWeight: false,
            children: List<Widget>.generate(20, (int index) {
              return ColoredBox(
                color: Colors.primaries[index % Colors.primaries.length]
                    .withOpacity(0.8),
                child: const SizedBox.expand(),
              );
            }),
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: CarouselView.weighted(
            flexWeights: const <int>[3, 3, 3, 2, 1],
            consumeMaxWeight: false,
            children: CardInfo.values.map((CardInfo info) {
              return ColoredBox(
                color: info.backgroundColor,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(info.icon, color: info.color, size: 32.0),
                      Text(
                        info.label,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                        softWrap: false,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        const Padding(
          padding: EdgeInsetsDirectional.only(top: 8.0, start: 8.0),
          child: Text('Uncontained layout'),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200),
          child: CarouselView(
            itemExtent: 330,
            shrinkExtent: 200,
            children: List<Widget>.generate(20, (int index) {
              return UncontainedLayoutCard(index: index, label: 'Show $index');
            }),
          ),
        ),
      ],
    );
  }
}
