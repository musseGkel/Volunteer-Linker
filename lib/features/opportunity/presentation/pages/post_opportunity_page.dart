import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:volunteer_linker/core/widgets/common_textfield.dart';
import 'package:volunteer_linker/features/opportunity/presentation/bloc/opportunity_bloc.dart';
import '../../../profile/presentation/bloc/key_selection_bloc/keyword_selection_bloc.dart';
import '../../../profile/presentation/widgets/keyword_selection.dart';

class PostOpportunity extends StatelessWidget {
  const PostOpportunity({super.key});

  // final _formKey = GlobalKey<FormState>();

  // DateTime _startDateTime = DateTime.now();
  // final _dateController = TextEditingController();
  // final _timeController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   // _dateController.text = DateFormat('yyyy-MM-dd').format(_startDateTime);
  //   // _timeController.text = DateFormat('HH:mm').format(_startDateTime);
  // }

  @override
  Widget build(
    BuildContext context,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<KeywordSelectionBloc>(
          create: (context) {
            final skills =
                context.read<OpportunityBloc>().state.tempRequiredSkills ??
                    <String>[];
            return KeywordSelectionBloc(skills);
          },
        ),
      ],
      child: BlocBuilder<OpportunityBloc, OpportunityState>(
        builder: (
          context,
          state,
        ) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Post an Opportunity',
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommonTextField(
                      label: "Title",
                      onChanged: (value) {
                        BlocProvider.of<OpportunityBloc>(context).add(
                          UpdateTempTitle(
                            title: value,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CommonTextField(
                      label: "Description",
                      onChanged: (value) {
                        BlocProvider.of<OpportunityBloc>(context).add(
                          UpdateTempDescription(
                            description: value,
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: KeywordsSelection(
                      keywords: state.skills(),
                      title: "Required Skills",
                      canEdit: true,
                      onSave: (value) {
                        BlocProvider.of<OpportunityBloc>(context).add(
                          UpdateTempRequiredSkills(
                            requiredSkills: value,
                          ),
                        );
                      },
                    ),
                  ),
                  /*  TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                          labelText: 'Start Date (YYYY-MM-DD)'),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _startDateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _startDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              _startDateTime.hour,
                              _startDateTime.minute,
                            );
                            _dateController.text =
                                DateFormat('yyyy-MM-dd').format(_startDateTime);
                          });
                        }
                      },
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a date' : null,
                    ),
                    TextFormField(
                      controller: _timeController,
                      decoration:
                          const InputDecoration(labelText: 'Start Time (HH:MM)'),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(_startDateTime),
                        );
                        if (pickedTime != null) {
                          setState(() {
                            _startDateTime = DateTime(
                              _startDateTime.year,
                              _startDateTime.month,
                              _startDateTime.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            _timeController.text =
                                DateFormat('HH:mm').format(_startDateTime);
                          });
                        }
                      },
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter a time' : null,
                    ),
                    // TextFormField(
                    //   decoration:
                    //       const InputDecoration(labelText: 'Duration (hours)'),
                    //   keyboardType: TextInputType.number,
                    //   onChanged: (value) => _duration = int.tryParse(value) ?? 0,
                    //   validator: (value) =>
                    //       value!.isEmpty ? 'Please enter a duration' : null,
                    // ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text('Post Opportunity'),
                    ),*/
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
