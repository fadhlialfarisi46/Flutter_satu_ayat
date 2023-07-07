import 'package:flutter/material.dart';

import '../data/model/ayat.dart';

class TafsirWidget extends StatefulWidget {
  final List<TafsirList> tafsirList;

  const TafsirWidget({Key? key, required this.tafsirList}) : super(key: key);

  @override
  State<TafsirWidget> createState() => _TafsirWidgetState();
}

class _TafsirWidgetState extends State<TafsirWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          //color is transparent so that it does not blend with the actual color specified
          borderRadius:
          const BorderRadius.all(Radius.circular(15.0)),
          color: const Color.fromRGBO(0, 0, 0,
              0.5019607843137255) // Specifies the background color and the opacity
      ),
      child: Column(
        children: [
          const Text("Tafsir",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 16.0,
          ),
          ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: widget.tafsirList.map<Widget>((TafsirList item) {
              return ExpansionPanelList(
                expandIconColor: Colors.white,
                dividerColor: Colors.white,
                elevation: 1,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    item.isExpanded = !isExpanded;
                  });
                },
                children: [
                  ExpansionPanel(
                    backgroundColor: Colors.green,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: Text(item.from, style: const TextStyle(color: Colors.white),),
                      );
                    },
                    body: ListTile(
                      title: Text(item.content, style: const TextStyle(color: Colors.white)),
                    ),
                    isExpanded: item.isExpanded,
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}