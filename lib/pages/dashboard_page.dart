import 'package:flutter/material.dart';

import '../models/expense_model.dart';
import '../routes/add_expense.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  String _getStringDate(DateTime dt) {
    return "${dt.year}/${dt.month}/${dt.day}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    _getStringDate(DateTime.now()),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_forward,
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _getExpenses()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpense(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getExpenses() {
    var expense1 = ExpenseModel().rebuild((b) => b
      ..id = 1
      ..title = "Coffee"
      ..notes = "Coffee at peepalbot"
      ..amount = 129.00);

    var expense2 = ExpenseModel().rebuild((b) => b
      ..id = 2
      ..title = "Lunch"
      ..notes = "Momos at dilli bazar"
      ..amount = 150.00);

    var expense3 = ExpenseModel().rebuild((b) => b
      ..id = 3
      ..title = "Pants"
      ..notes = "Bought a pair of pants from Dbmg"
      ..amount = 2500.00);

    var listExpenses = [expense1, expense2, expense3];

    return ListView.builder(
      itemCount: listExpenses.length,
      itemBuilder: (context, index) {
        var expense = listExpenses[index];

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              width: 1.0,
              style: BorderStyle.solid,
              color: Colors.white,
            ),
          ),
          margin: const EdgeInsets.all(12.0),
          child: ListTile(
            onTap: () {},
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete),
              color: Theme.of(context).primaryColorLight,
            ),
            title: Text(
              '${expense.title!} - ${expense.amount!.toString()} MMK.',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            subtitle: Text(expense.notes ?? ''),
          ),
        );
      },
    );
  }
}
