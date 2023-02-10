import 'package:flutter/material.dart';

class Bar extends StatelessWidget {
  final Object? day;
  final Object? amount;
  final double amountPct;

  Bar(this.day, this.amount, this.amountPct);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(
                  child: Text('\$${(amount as double).toStringAsFixed(0)}'),
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.6,
                width: 10,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        border: Border.all(color: Colors.grey, width: 1),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: amountPct,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.05,
              ),
              Container(
                height: constraints.maxHeight * 0.15,
                child: FittedBox(child: Text('$day')),
              ),
            ],
          );
        },
      ),
    );
  }
}
