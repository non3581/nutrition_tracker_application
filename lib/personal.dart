import 'package:flutter/material.dart';

class EditPersonalInfoPage extends StatefulWidget {
  final int age;
  final String gender;
  final double weight;
  final double height;
  final String activeLevel;

  const EditPersonalInfoPage({
    Key? key,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.activeLevel,
  }) : super(key: key);

  @override
  _EditPersonalInfoPageState createState() => _EditPersonalInfoPageState();
}

class _EditPersonalInfoPageState extends State<EditPersonalInfoPage> {
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;
  String? _selectedGender;
  String? _selectedActiveLevel;

  @override
  void initState() {
    super.initState();
    _ageController = TextEditingController(text: widget.age.toString());
    _weightController = TextEditingController(text: widget.weight.toString());
    _heightController = TextEditingController(text: widget.height.toString());
    _selectedGender = widget.gender;
    _selectedActiveLevel = widget.activeLevel;
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final int updatedAge = int.tryParse(_ageController.text) ?? widget.age;
    final double updatedWeight = double.tryParse(_weightController.text) ?? widget.weight;
    final double updatedHeight = double.tryParse(_heightController.text) ?? widget.height;

    Navigator.of(context).pop({
      'age': updatedAge,
      'gender': _selectedGender,
      'weight': updatedWeight,
      'height': updatedHeight,
      'activeLevel': _selectedActiveLevel,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Personal information updated!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Personal Information'),
        backgroundColor: Color(0xff6750a4),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Color(0xfffafafa)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleTextStyle: TextStyle(
          color: Color(0xfffafafa),
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
                value: _selectedGender,
                items: ['Male', 'Female', 'Other'].map((String gender) {
                  return DropdownMenuItem<String>(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGender = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              TextField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Active Level',
                  border: OutlineInputBorder(),
                ),
                value: _selectedActiveLevel,
                items: [
                  'Sedentary',
                  'Lightly Active',
                  'Moderately Active',
                  'Very Active'
                ].map((String level) {
                  return DropdownMenuItem<String>(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedActiveLevel = newValue;
                  });
                },
              ),
              SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  
                  child: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff6750a4),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
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
