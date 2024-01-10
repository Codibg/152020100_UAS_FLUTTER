import "package:flutter/material.dart";
import 'kalkulator.dart';

class BMIPage extends StatefulWidget {
  @override
  _BMIPageState createState() => _BMIPageState();
}

enum Gender { male, female }

class _BMIPageState extends State<BMIPage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  Gender selectedGender = Gender.male;
  double bmiResult = 0.0;
  String resultCategory = '';

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    double height = double.tryParse(heightController.text) ?? 0.0;

    if (weight > 0 && height > 0) {
      double bmi = weight / ((height / 100) * (height / 100));
      setState(() {
        bmiResult = bmi;
        resultCategory = _getCategory(bmi);
      });
    }
  }

  void resetFields() {
    setState(() {
      weightController.text = '';
      heightController.text = '';
      bmiResult = 0.0;
      resultCategory = '';
    });
  }

  String _getCategory(double bmi) {
    if (bmi < 18.5) {
      return 'Kurus';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Normal';
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return 'Berlebih Berat';
    } else {
      return 'Obesitas';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('BMI'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                children: [
                  Text('Jenis Kelamin: '),
                  Radio(
                    value: Gender.male,
                    groupValue: selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        selectedGender = value ?? Gender.male;
                      });
                    },
                  ),
                  Text('Pria'),
                  Radio(
                    value: Gender.female,
                    groupValue: selectedGender,
                    onChanged: (Gender? value) {
                      setState(() {
                        selectedGender = value ?? Gender.male;
                      });
                    },
                  ),
                  Text('Wanita'),
                ],
              ),
              TextField(
                controller: weightController,
                decoration: InputDecoration(labelText: 'Berat (kg)'),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: heightController,
                decoration: InputDecoration(labelText: 'Tinggi (cm)'),
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, // Ubah warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        18.0), // Membuat tombol menjadi tumpul
                  ),
                ),
                child: Text('Hitung'),
              ),
              SizedBox(height: 20),
              Text(
                'BMI: ${bmiResult.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Kategori: $resultCategory',
                style: TextStyle(fontSize: 24),
              ),
              ElevatedButton(
                onPressed: resetFields,
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // Ubah warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        18.0), // Membuat tombol menjadi tumpul
                  ),
                ),
                child: Text('Hapus'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => kalkulator()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Ubah warna tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        18.0), // Membuat tombol menjadi tumpul
                  ),
                ),
                child: Text('Pindah ke Kalkulator'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
