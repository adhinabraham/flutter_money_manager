import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/db/category/categor_db.dart';
import 'package:money_manager/models/category/category_model.dart';

import '../../db/transaction/transaction_db.dart';
import '../../models/transactions/transaction_model.dart';
import 'package:intl/intl.dart';



class ScreenaddTransaction extends StatefulWidget {
  const ScreenaddTransaction({super.key});
  static const routeName = "add-transaction";

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  CategoryModel? _selectedCategoryModel;
  CategoryType _selectedRadioValue = CategoryType.income;
   final TextEditingController _purposeTExtEditingController =  TextEditingController();
   final TextEditingController _amountEditingController =   TextEditingController();
  String? _categoryID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CategoryDB.instance.refreshUI();
  }

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
                  controller: _purposeTExtEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Purpose',
                  ),
                ),
                TextFormField(
                  controller: _amountEditingController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(hintText: 'Amount'),
                ),
                TextButton.icon(
                  onPressed: () async {
                    final _selectedDateTemp = await showDatePicker(
                        context: context, initialDate: DateTime.now(), firstDate: DateTime.now().subtract(const Duration(days: 30)), lastDate: DateTime.now());
                    if (_selectedDateTemp == null) {
                      return;
                    } else {
                      setState(() {
                        _selectedDate = _selectedDateTemp;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(_selectedDate == null ? "select Date " : _selectedDate.toString()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(children: [
                      Radio(
                          value: CategoryType.income,
                          groupValue: _selectedRadioValue,
                          onChanged: (newValue) {
                            print("$newValue");
                            if (newValue == null) {
                              print("something is haappen --->");
                              return;
                            }
                            setState(() {
                              _selectedRadioValue = newValue;
                              _categoryID = null;
                            });
                          }),
                      const Text("Income")
                    ]),
                    Row(children: [
                      Radio(
                          value: CategoryType.expense,
                          groupValue: _selectedRadioValue,
                          onChanged: (newValue) {
                            print("$newValue");
                            if (newValue == null) {
                              print("something is haappen --->");
                              return;
                            }
                            setState(() {
                              _selectedRadioValue = newValue;
                              _categoryID = null;
                            });
                          }),
                      const Text("Expense")
                    ]),
                  ],
                ),
                DropdownButton(
                  hint: const Text("Select Category"),
                  value: _categoryID,
                  items: (_selectedRadioValue == CategoryType.income ? CategoryDB().incomeCategoryList : CategoryDB().expenseCategoryList).value.map((e) {
                    return DropdownMenuItem(
                      value: e.id, // Explicitly specify the type as Object
                      child: Text(e.name),
                      onTap: (){
                        print(e.toString());
                        _selectedCategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (selectedValue) {
                    setState(() {
                      _categoryID = selectedValue;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    addTransaction();
                  },
                  child: const Text("Submit"),
                )
              ],
            ),
          )),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTExtEditingController.text;
    final _amountText = _amountEditingController.text;
    if (_purposeText.isEmpty || _amountText.isEmpty) {
      return;
    }
    if (_categoryID == null) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_selectedCategoryModel == null) {
      return;
    }
    if (_selectedRadioValue == null) {
      print("where is this error getting");
      return;
    }
   final model =   TransactionModel(amount: _amountText, purpose: _purposeText, transactionDate: _selectedDate!, transActionType: _selectedRadioValue, selectedCategory: _selectedCategoryModel!);
     await TransactionDB.instance.addTransaction(model);
     if(mounted) {
       Navigator.of(context).pop();
     }
     TransactionDB.instance.refresh();
  }
}