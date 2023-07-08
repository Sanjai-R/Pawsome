import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pawsome_client/core/constant/constant.dart';
import 'package:pawsome_client/provider/app_provider.dart';
import 'package:pawsome_client/provider/auth_provider.dart';
import 'package:pawsome_client/provider/pet_provier.dart';
import 'package:pawsome_client/screens/pet_management/pet/component/create_pet_form.dart';
import 'package:provider/provider.dart';

class CreatePet extends StatefulWidget {
  const CreatePet({Key? key}) : super(key: key);

  @override
  State<CreatePet> createState() => _CreatePetState();
}

class _CreatePetState extends State<CreatePet> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? _selectedData;
late int userId;
  final TextEditingController _petname = TextEditingController();
  final TextEditingController _gender = TextEditingController();
  final TextEditingController _breed = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _price = TextEditingController();
  final TextEditingController _birthDate = TextEditingController();
  final TextEditingController _image = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<PetProvider>().fetchCategories();
      final user = Provider.of<AuthProvider>(context, listen: false).user;
      userId = user['userId'];
    });

  }

  DateTime? _selectedBirthDate;

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedBirthDate = picked;
        _birthDate.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Pet',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () {
            GoRouter.of(context).go('/');
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Consumer<PetProvider>(
        builder: (context, petProvider, child) {
          final categories = petProvider.categories;
          return Stack(
            children: [
              Center(
                child: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: defaultPadding),
                        CreatePetForm(
                          formKey: _formKey,
                          inputs: [
                            {
                              'label': 'Name of the pet',
                              'hintText': 'Lucas',
                              'type': 'text',
                              'controller': _petname,
                            },
                            {
                              'label': 'Gender',
                              'hintText': 'Male',
                              'type': 'text',
                              'controller': _gender,
                            },
                            {
                              'label': 'Breed',
                              'hintText': 'Labrador',
                              'type': 'text',
                              'controller': _breed,
                            },
                            {
                              'label': 'Description',
                              'hintText': 'Some description',
                              'type': 'text',
                              'controller': _description,
                            },
                            {
                              'label': 'Price',
                              'hintText': '100',
                              'type': 'text',
                              'controller': _price,
                            },
                            {
                              'label': 'Image URL',
                              'hintText': 'https://example.com/image.png',
                              'type': 'text',
                              'controller': _image,
                            },
                          ],
                        ),
                        // ...
                        SizedBox(height: defaultPadding / 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Birth Date",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: _birthDate,
                                      decoration: InputDecoration(
                                        hintText: 'Select Birth Date',
                                        contentPadding: defaultInputPadding,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          borderSide: BorderSide.none,
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      onTap: () {
                                        _selectBirthDate(context);
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _selectBirthDate(context);
                                    },
                                    icon: Icon(Icons.calendar_today),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: defaultPadding / 2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsets.only(bottom: defaultPadding / 3),
                              child: Text(
                                "Category",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: const Text('Please choose a category'),
                                  menuMaxHeight: 100,
                                  value: _selectedData,
                                  isExpanded: true,
                                  alignment: Alignment.center,
                                  items: categories.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.categoryId.toString(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10), // Set the border radius here
                                        ),
                                        child:
                                            Text(item.categoryName.toString()),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedData = value!;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: defaultPadding * 1.5),
                        Container(
                          margin: const EdgeInsets.only(bottom: defaultPadding),
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: defaultPadding * 0.75,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                // Form is valid, proceed with submitting the data
                                final petData = {
                                  'name': _petname.text,
                                  'gender': _gender.text,
                                  'breed': _breed.text,
                                  'description': _description.text,
                                  'price': double.parse(_price.text),
                                  'birthDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
                                      .format(_selectedBirthDate!.toUtc()).toString(),
                                  'image': _image.text,
                                  'categoryId': int.parse(_selectedData!),
                                  'userId': userId,
                                };
                                final res = await petProvider.postPet(
                                    petData);
                                if (res['status']) {
                                  setState(() => _isLoading = false);
                                  petProvider.fetchAllPetsByUser(userId);

                                  context.read<AppProvider>().changeIndex(4);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(res['message']),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  context.go('/');
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(res['message']),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                                // TODO: Call API or perform desired action with petData
                              }
                            },
                            child: _isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Create Pet",
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
