import 'package:flutter/material.dart';
import 'package:nutrition_tracker_application/AddFoodPage.dart';
import 'package:nutrition_tracker_application/personal.dart';

class HomePage extends StatefulWidget {
  final int age;
  final String gender;
  final double weight; // in kg
  final double height; // in cm
  final String activeLevel;

  HomePage({
    Key? key,
    required this.age,
    required this.gender,
    required this.weight,
    required this.height,
    required this.activeLevel,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int age;
  late String gender;
  late double weight; // in kg
  late double height; // in cm
  late String activeLevel;

  List<Map<String, dynamic>> foodItems = [];

  double consumedCalories = 0;
  double consumedCarbs = 0;
  double consumedProtein = 0;
  double consumedFat = 0;
  double consumedWater = 0;

  @override
  void initState() {
    super.initState();
    age = widget.age;
    gender = widget.gender;
    weight = widget.weight;
    height = widget.height;
    activeLevel = widget.activeLevel;
  }

  double calculateBMR() {
    if (gender == 'Male') {
      return 10 * weight + 6.25 * height - 5 * age + 5;
    } else {
      return 10 * weight + 6.25 * height - 5 * age - 161;
    }
  }

  double calculateTDEE() {
    double bmr = calculateBMR();
    switch (activeLevel) {
      case 'Sedentary':
        return bmr * 1.2;
      case 'Lightly active':
        return bmr * 1.375;
      case 'Moderately active':
        return bmr * 1.55;
      case 'Very active':
        return bmr * 1.725;
      case 'Super active':
        return bmr * 1.9;
      default:
        return bmr * 1.2; // Default to Sedentary
    }
  }

  double calculateWaterRequirement() {
    return weight * 30; // Standard recommendation: 30 ml per kg of body weight
  }

  void _addFood(Map<String, dynamic> newFood) {
    setState(() {
      foodItems.add(newFood);
      consumedCalories += newFood['calories'];
      consumedCarbs += newFood['carbs'];
      consumedProtein += newFood['protein'];
      consumedFat += newFood['fat'];

      if (newFood['name'].toLowerCase() == 'water') {
        consumedWater += newFood['weight'];
      }
    });
  }

  void _navigateAndUpdatePersonalInfo() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPersonalInfoPage(
          age: age,
          gender: gender,
          weight: weight,
          height: height,
          activeLevel: activeLevel,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        age = result['age'];
        gender = result['gender'];
        weight = result['weight'];
        height = result['height'];
        activeLevel = result['activeLevel'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalCalories = calculateTDEE();
    double totalWater = calculateWaterRequirement();

    double remainingCalories = totalCalories - consumedCalories;
    double remainingWater = totalWater - consumedWater;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, User!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xff6750a4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Calories Remaining',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6750a4),
                    ),
                  ),
                  Text(
                    '${remainingCalories.toStringAsFixed(1)} kcal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: consumedCalories / totalCalories,
                      color: Color(0xff6750a4),
                      backgroundColor: Color(0xff6750a4).withOpacity(0.3),
                      minHeight: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Intake ${consumedCalories.toStringAsFixed(1)} kcal / ${totalCalories.toStringAsFixed(1)} kcal',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xff6750a4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Macronutrients',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6750a4),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNutrientIndicator('Carbs', consumedCarbs, 120),
                      _buildNutrientIndicator('Protein', consumedProtein, 60),
                      _buildNutrientIndicator('Fat', consumedFat, 60),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xff6750a4).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Water Remaining',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff6750a4),
                    ),
                  ),
                  Text(
                    '${remainingWater.toStringAsFixed(1)} ml',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: consumedWater / totalWater,
                      color: Color(0xff6750a4),
                      backgroundColor: Color(0xff6750a4).withOpacity(0.3),
                      minHeight: 20,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Intake ${consumedWater.toStringAsFixed(1)} ml / ${totalWater.toStringAsFixed(1)} ml',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            Text(
              'Recent Foods',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Column(
              children: foodItems.map((food) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xff6750a4).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              food['name'],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${food['quantity']} ${food['unit']}',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              '${food['calories']} kcal',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff6750a4),
        onPressed: () async {
          final newFood = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFoodPage(),
            ),
          );

          if (newFood != null) {
            _addFood(newFood);
          }
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: _navigateAndUpdatePersonalInfo,
            ),
            IconButton(
              icon: Icon(Icons.report),
              onPressed: () {

              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientIndicator(String name, double value, double maxValue) {
    return Expanded(
      child: Column(
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            '${value.toStringAsFixed(1)} g',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value / maxValue,
              color: Color(0xff6750a4),
              backgroundColor: Color(0xff6750a4).withOpacity(0.3),
              minHeight: 20,
            ),
          ),
        ],
      ),
    );
  }
}
