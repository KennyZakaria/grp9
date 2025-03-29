import 'package:app/dashboard.dart';
import 'package:app/home.dart';
import 'package:app/models/Depense.dart';
import 'package:app/models/Travel.dart';
import 'package:app/services/httpService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewExpenseScreen extends StatefulWidget {
  @override
  _NewExpenseScreenState createState() => _NewExpenseScreenState();
}

class _NewExpenseScreenState extends State<NewExpenseScreen> {
  HttpService httpService = HttpService();
  final _expenseNameController = TextEditingController();
  final _amountController = TextEditingController();

  String? _selectedPayer = 'Jounir';
  DateTime _selectedDate = DateTime(2025, 2, 20);

  final List<String> _payers = ['Aissam', 'Badr', 'Zakaria', 'Soufian'];

  Future<void> createDepense() async {
    await httpService
        .addDepense(
          Depense(
            name: _expenseNameController.text,
            paidBy: _selectedPayer!,
            price: _amountController.text,
          ),
        )
        .then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Nouvelle dépense', style: TextStyle(fontSize: 18)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Expense Name Input
            TextField(
              controller: _expenseNameController,
              decoration: InputDecoration(
                labelText: 'Nom de la dépense',
                hintText: 'Par ex : repas, ...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Amount Input
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: InputDecoration(
                labelText: 'Montant',
                hintText: '0,00',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 16),

            // Payer Dropdown
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedPayer,
                    decoration: InputDecoration(
                      labelText: 'Payé Par',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items:
                        _payers.map((String payer) {
                          return DropdownMenuItem<String>(
                            value: payer,
                            child: Text(payer),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedPayer = newValue;
                      });
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Quand',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        '${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}',
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Spacer(),

            ElevatedButton(
              onPressed: createDepense,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Valider',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _validateExpense() {
    print('Expense Name: ${_expenseNameController.text}');
    print('Amount: ${_amountController.text}');
    print('Payer: $_selectedPayer');
    print('Date: $_selectedDate');
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'jan';
      case 2:
        return 'fev';
      case 3:
        return 'mar';
      case 4:
        return 'avr';
      case 5:
        return 'mai';
      case 6:
        return 'juin';
      case 7:
        return 'juil';
      case 8:
        return 'août';
      case 9:
        return 'sep';
      case 10:
        return 'oct';
      case 11:
        return 'nov';
      case 12:
        return 'dec';
      default:
        return '';
    }
  }
}
