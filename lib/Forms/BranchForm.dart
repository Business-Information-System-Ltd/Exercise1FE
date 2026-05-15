import 'package:flutter/material.dart';

class BranchForm extends StatefulWidget {
  @override
  _BranchFormState createState() => _BranchFormState();
}

class _BranchFormState extends State<BranchForm> {
  final _formKey = GlobalKey<FormState>();
  String? _status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Branch Form")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField("Branch Code", "Enter branch code", isRequired: true),
              SizedBox(height: 20),
              _buildTextField("Branch Name", "Enter branch name", isRequired: true),
              SizedBox(height: 20),
              _buildTextField("Location", "Enter location"),
              SizedBox(height: 20),
              
              // Status Radio Buttons
              Row(
                children: [
                  Expanded(flex: 2, child: Text("Status *", style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                    flex: 3,
                    child: Row(
                      
                      children: [
                        Radio<String>(
  value: 'Active',
  groupValue: _status,
  onChanged: (val) {
    setState(() {
      _status = val;
    });
  },
),
Text("Active"),

Radio<String>(
  value: 'Inactive',
  groupValue: _status,
  onChanged: (val) {
    setState(() {
      _status = val;
    });
  },
),
Text("Inactive"),
                        
                      ],
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 30),
              
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Backend API နဲ့ ချိတ်ဖို့ နေရာ
                      }
                    },
                    icon: Icon(Icons.save),
                    label: Text("Submit"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white),
                  ),
                  SizedBox(width: 10),
                  OutlinedButton.icon(
                    onPressed: () => _formKey.currentState!.reset(),
                    icon: Icon(Icons.close),
                    label: Text("Clear"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {bool isRequired = false}) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: RichText(
            text: TextSpan(
              text: label,
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: isRequired ? [TextSpan(text: ' *', style: TextStyle(color: Colors.red))] : [],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
            ),
            validator: isRequired ? (value) => value!.isEmpty ? 'Required' : null : null,
          ),
        ),
      ],
    );
  }
}