import 'package:flutter/material.dart';
import 'package:softprism/components/transparent_container.dart';
import 'package:softprism/utils/constants.dart';

class CustomSearchPage extends StatefulWidget {

  static const String id = 'customSearchPage';
  const CustomSearchPage({Key? key}) : super(key: key);

  @override
  _CustomSearchPageState createState() => _CustomSearchPageState();
}

class _CustomSearchPageState extends State<CustomSearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: kPurpleColor,
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 47),
            height: constraints.maxHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Go back, Location
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.keyboard_arrow_left_sharp,
                        color: Color(0xFFFFFFFF),
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 3),
                    ReusableTransparentContainer(
                      borderRadius: 20.0,
                      colorOpacity: 0.1,
                      horizontalPadding: 16.0,
                      verticalPadding: 14.0,
                      widget: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(
                            Icons.location_on_sharp,
                            color: Colors.white,
                            size: 23,
                          ),
                          SizedBox(width: 4.1),
                          Text(
                            'Lagos, Nigeria',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: constraints.maxHeight * 0.165),
                ///Today's weather
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.399,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.43),
                    border: Border.all(
                      width: 0.77,
                      color:  const Color(0xFFB9BCF2),
                    ),
                  ),
                  child: ReusableTransparentContainer(
                    borderRadius: 15.43,
                    colorOpacity: 0.2,
                    horizontalPadding: 50.0,
                    verticalPadding: 44.0,
                    widget: Column(
                      children: const [

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
