import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/models/category/category_model.dart';

import '../../db/category/categor_db.dart';


ValueNotifier<CategoryType> selectedpopUp = ValueNotifier(CategoryType.income);

Future<void> showCategoryAddPopup(BuildContext context)async{
  showDialog(context: context, builder: (ctx) {
    final _nameEditingController = TextEditingController();
    return SimpleDialog(
      title:  const Text("Add Category "),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: _nameEditingController,
            decoration: const InputDecoration(
              hintText: "Category Name",
              border: OutlineInputBorder(
              )
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            RadioButton(title: "Income", selectedCategorytype: CategoryType.income, type: CategoryType.income,),
            RadioButton(title: "Expense", selectedCategorytype: CategoryType.expense, type: CategoryType.expense,)
          ],
        ),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: (){
            final  _name = _nameEditingController.text;
            if (_name.isEmpty){
               return;
            }
            final _type = selectedpopUp.value;
            // print("add cateogory ");
            final _category =  CategoryModel(id:DateTime.now().microsecondsSinceEpoch.toString() , name: _name, type:_type);
             CategoryDB().insertCategory(_category);
             Navigator.of(ctx).pop();

          }, child: Text("Add")),
        )
      ],
    );
  });
  
}

class RadioButton extends StatelessWidget {
  const RadioButton({super.key, required this.title, required this.selectedCategorytype, required this.type});

  final String title;
  final CategoryType type;
  final CategoryType selectedCategorytype;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedpopUp,
      builder: (BuildContext context, newCategory, Widget? child) {
        return  Row(
          children: [
            Radio<CategoryType>(value: type, groupValue: newCategory, onChanged: (value){
              if(value == null){
                return;
              }
              selectedpopUp.value = value;
              selectedpopUp.notifyListeners();

            }),
            Text(title)
          ],
        );
      },
    );
  }
}
