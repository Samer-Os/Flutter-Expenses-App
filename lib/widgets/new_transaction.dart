import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTr;

  NewTransaction(this.addTr);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? selectedDate;

  void submitData() {
    final String title = titleController.text;
    final double amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTr(
      titleController.text,
      double.parse(amountController.text),
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'title',
                ),
                controller: titleController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'amount',
                ),
                controller: amountController,
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(selectedDate == null
                        ? 'no date picked yet'
                        : 'picked date is ${DateFormat.yMd().format(selectedDate!)}'),
                  ),
                  TextButton(
                    child: Text(
                      'chose date',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: presentDatePicker,
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                child: const Text(
                  'Add transaction',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
