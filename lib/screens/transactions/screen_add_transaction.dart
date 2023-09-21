import 'package:flutter/material.dart';
import 'package:money_manager/db/category/categor_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class ScreenaddTransaction extends StatefulWidget {
  const ScreenaddTransaction({super.key});
  static const routeName = "add-transaction";

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  CategoryModel? _selectedCategoryModel;
  CategoryType? _selectedCategoryType;
  CategoryType _selectedRadioValue = CategoryType.expense;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Purpose',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Amount'),
            ),
            TextButton.icon(
              onPressed: () async {
               final _selectedDateTemp = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 30)), lastDate: DateTime.now());
                if (_selectedDateTemp == null){
                  return ;
                } else {
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: const Icon(Icons.calendar_today),
              label:  Text(_selectedDate == null ?"select Date ":_selectedDate.toString()),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(children: [Radio(value:CategoryType.income, groupValue: _selectedRadioValue, onChanged: (newValue) {
                  print("$newValue");
                  if (newValue == null ){
                    print("something is haappen --->");
                    return;
                  }
                  setState(() {
                    _selectedRadioValue = newValue;
                  });
                }),
                const Text("Income")]),
                Row(children: [Radio(value: CategoryType.expense, groupValue:_selectedRadioValue, onChanged: (newValue) {
                  print("$newValue");
                  if (newValue == null){
                    print("something is haappen --->");
                    return;
                  }
                  setState(() {
                    _selectedRadioValue = newValue;
                  });

                }),
                  const Text("Expense")]),
              ],
            ),
            DropdownButton(
              hint:const Text("Select Category") ,
              items: CategoryDB().expenseCategoryList.value.map((e) {
                return  DropdownMenuItem( // Explicitly specify the type as Object
                  value: e.id, // Explicitly specify the type as Object
                  child: Text(e.name),
                );
              }).toList(),
              onChanged: (value) {
                // Handle the onChanged event here
              },
            ),
          ElevatedButton(onPressed: (){
          },child: const Text("Submit"),)
        ],
      ),
          )),
    );
  }
}
