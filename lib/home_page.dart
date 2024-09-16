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
  // double consumedWater = 0;

  double calculateCarbGoal() {
    double tdee = calculateTDEE();
    // Example: 50% of total calories from carbs
    return (tdee * 0.50) / 4; // 4 calories per gram of carbs
  }

  double calculateProteinGoal() {
    double tdee = calculateTDEE();
    // Example: 20% of total calories from protein
    return (tdee * 0.20) / 4; // 4 calories per gram of protein
  }

  double calculateFatGoal() {
    double tdee = calculateTDEE();
    // Example: 30% of total calories from fat
    return (tdee * 0.30) / 9; // 9 calories per gram of fat
  }

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

  // double calculateWaterRequirement() {
  //   return weight * 30; // Standard recommendation: 30 ml per kg of body weight
  // }

  void _addFood(Map<String, dynamic> newFood) {
    setState(() {
      foodItems.add(newFood);
      consumedCalories += newFood['calories'];
      consumedCarbs += newFood['carbs'];
      consumedProtein += newFood['protein'];
      consumedFat += newFood['fat'];

      // if (newFood['name'].toLowerCase() == 'water') {
      //   consumedWater += newFood['weight'];
      // }
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
    // double totalWater = calculateWaterRequirement();

    int carbGoal = (calculateCarbGoal()).toInt();
    int proteinGoal = (calculateProteinGoal()).toInt();
    int fatGoal = (calculateFatGoal()).toInt();

    int leftcarbGoal = (carbGoal - consumedCarbs).toInt();
    int leftproteinGoal = (proteinGoal - consumedProtein).toInt();
    int leftfatGoal = (fatGoal - consumedFat).toInt();

    int consumedCaloriesInt = consumedCalories.toInt();
    int consumedCarbsInt = consumedCarbs.toInt();
    int consumedProteinInt = consumedProtein.toInt();
    int consumedFatInt = consumedFat.toInt();
    // int consumedWaterInt = consumedWater.toInt();

    double remainingCalories = totalCalories - consumedCalories;
    // double remainingWater = totalWater - consumedWater;

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
                  // Header for Macronutrients
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
                      // Carbs
                      Column(
                        children: [
                          Text(
                            'Carbs',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width:
                                    80, // Increased size of circular indicator
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: consumedCarbsInt /
                                      carbGoal, // Example progress value
                                  color: Color(0xff6750a4),
                                  backgroundColor:
                                      Color(0xff6750a4).withOpacity(0.3),
                                  strokeWidth: 8,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$consumedCarbsInt', // Consumed number
                                    style: TextStyle(
                                      fontSize:
                                          20, // Increased size of consumed number
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '/$carbGoal g', // Total goal in new line
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'left $leftcarbGoal g', // Remaining amount at the bottom
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      // Protein
                      Column(
                        children: [
                          Text(
                            'Protein',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width:
                                    80, // Increased size of circular indicator
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: consumedProteinInt /
                                      proteinGoal, // Example progress value
                                  color: Color(0xff6750a4),
                                  backgroundColor:
                                      Color(0xff6750a4).withOpacity(0.3),
                                  strokeWidth: 8,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$consumedProteinInt', // Consumed number
                                    style: TextStyle(
                                      fontSize:
                                          20, // Increased size of consumed number
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '/$proteinGoal g', // Total goal in new line
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'left $leftproteinGoal g', // Remaining amount at the bottom
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                      // Fat
                      Column(
                        children: [
                          Text(
                            'Fat',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width:
                                    80, // Increased size of circular indicator
                                height: 80,
                                child: CircularProgressIndicator(
                                  value: consumedFatInt /
                                      fatGoal, // Example progress value
                                  color: Color(0xff6750a4),
                                  backgroundColor:
                                      Color(0xff6750a4).withOpacity(0.3),
                                  strokeWidth: 8,
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$consumedFatInt', // Consumed number
                                    style: TextStyle(
                                      fontSize:
                                          20, // Increased size of consumed number
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '/$leftfatGoal g', // Total goal in new line
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            'left $leftfatGoal g', // Remaining amount at the bottom
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            // Container(
            //   padding: EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Color(0xff6750a4).withOpacity(0.1),
            //     borderRadius: BorderRadius.circular(8),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Water Remaining',
            //         style: TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.bold,
            //           color: Color(0xff6750a4),
            //         ),
            //       ),
            //       Text(
            //         '${remainingWater.toStringAsFixed(1)} ml',
            //         style: TextStyle(
            //           fontSize: 24,
            //           fontWeight: FontWeight.bold,
            //           color: Colors.black,
            //         ),
            //       ),
            //       SizedBox(height: 8),
            //       ClipRRect(
            //         borderRadius: BorderRadius.circular(4),
            //         child: LinearProgressIndicator(
            //           value: consumedWater / totalWater,
            //           color: Color(0xff6750a4),
            //           backgroundColor: Color(0xff6750a4).withOpacity(0.3),
            //           minHeight: 20,
            //         ),
            //       ),
            //       SizedBox(height: 8),
            //       Text(
            //         'Intake ${consumedWater.toStringAsFixed(1)} ml / ${totalWater.toStringAsFixed(1)} ml',
            //         style: TextStyle(
            //           fontSize: 16,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                food['name'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                  width:
                                      4), // Reduced space between name and weight
                              Text(
                                '(${food['weight']})',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${food['calories']} kcal',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Carbs: ${food['carbs']}g'),
                          Text('Protein: ${food['protein']}g'),
                          Text('Fat: ${food['fat']}g'),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.bar_chart, size: 28, color: Color(0xff6750a4)),
              onPressed: () {
                // Navigate to report page
              },
            ),
            IconButton(
              icon: Icon(Icons.person, size: 28, color: Color(0xff6750a4)),
              onPressed: _navigateAndUpdatePersonalInfo,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff6750a4),
        child: Icon(Icons.add, color: Color(0xfffafafa)),
        onPressed: () async {
          final newFood = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddFoodPage()),
          );

          if (newFood != null) {
            _addFood(newFood);
          }
        },
      ),
    );
  }

  // Widget _buildNutrientIndicator(String name, double value, double maxValue) {
  //   return Expanded(
  //     child: Column(
  //       children: [
  //         Text(
  //           name,
  //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //         ),
  //         SizedBox(height: 4),
  //         Text(
  //           '${value.toStringAsFixed(1)} g',
  //           style: TextStyle(fontSize: 14, color: Colors.black54),
  //         ),
  //         SizedBox(height: 8),
  //         ClipRRect(
  //           borderRadius: BorderRadius.circular(4),
  //           child: LinearProgressIndicator(
  //             value: value / maxValue,
  //             color: Color(0xff6750a4),
  //             backgroundColor: Color(0xff6750a4).withOpacity(0.3),
  //             minHeight: 20,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
