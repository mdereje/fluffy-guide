import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowMoneyFrame extends StatelessWidget {
  final String type;
  final double typeValue, balance;
  const ShowMoneyFrame(this.type, this.typeValue, this.balance);

  @override
  Widget build(BuildContext context) {
    Widget rowFrame(String typeName, double value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            typeName,
            style: TextStyle(fontSize: 22),
          ),
          Expanded(
              child: Text(
            // fix here: Overflow is a temporary parameter, fix whatever it is so that the money value will never overflow
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            value.toString(),
            style: GoogleFonts.aBeeZee(
              fontSize: value > 22
                  ? 16.5
                  : value > 17
                      ? 19.5
                      : 22,
            ),
          )),
        ],
      );
    }

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: Colors.grey,
            width: 0.4,
          )),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18.5),
        child: Column(
          children: [
            rowFrame(type, typeValue),
            SizedBox(
              height: 12.5,
            ),
            rowFrame('Balance', balance)
          ],
        ),
      ),
    );
  }
}
