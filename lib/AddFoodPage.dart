import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddFoodPage extends StatefulWidget {
  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {
  final List<String> _units = ['g', 'kg', 'oz', 'lb','ml'];
  String? _selectedUnit;
  final TextEditingController _qtyController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<Map<String, dynamic>> _fetchNutritionData(
      String foodName, String qty, String? unit) async {
    final appId = '297a679c'; // Replace with your App ID
    final appKey =
        '5f0aa9c71d4129df0e1e744ef8ae370f'; // Replace with your App Key

    final url = Uri.parse(
        'https://api.edamam.com/api/nutrition-data?app_id=$appId&app_key=$appKey&ingr=$qty%20$unit%20$foodName');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return {
          'calories': data['calories'] ?? 0,
          'carbs': data['totalNutrients']['CHOCDF']?['quantity'] ?? 0,
          'protein': data['totalNutrients']['PROCNT']?['quantity'] ?? 0,
          'fat': data['totalNutrients']['FAT']?['quantity'] ?? 0,
        };
      } else {
        throw Exception('Failed to load nutrition data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      throw Exception('Failed to load nutrition data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Food'),
        backgroundColor: Color(0xff6750a4),
        titleTextStyle: TextStyle(
          color: Color(0xfffafafa),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xfffafafa)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _foodNameController,
                decoration: InputDecoration(
                  labelText: 'Food Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a food name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _qtyController,
                      decoration: InputDecoration(
                        labelText: 'Quantity',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a quantity';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Unit',
                        border: OutlineInputBorder(),
                      ),
                      items: _units.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedUnit = newValue;
                        });
                      },
                      value: _selectedUnit,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a unit';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String foodName = _foodNameController.text;
                      String qty = _qtyController.text;
                      String? unit = _selectedUnit;

                      try {
                        final nutritionData =
                        await _fetchNutritionData(foodName, qty, unit);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).pop({
                            'name': foodName,
                            'weight': '$qty $unit',
                            'calories': nutritionData['calories'],
                            'carbs': nutritionData['carbs'],
                            'protein': nutritionData['protein'],
                            'fat': nutritionData['fat'],
                          });
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Food $foodName added successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        _foodNameController.clear();
                        _qtyController.clear();
                        setState(() {
                          _selectedUnit = null;
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to fetch nutrition data'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: Text('Add Food'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff6750a4),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
