import 'package:discover_morocco/views/ui/home/plan/bloc/trip_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class DateTimePicker extends StatefulWidget {
  const DateTimePicker({super.key});

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late ThemeData _theme;
  late TextEditingController textController;

  @override
  void didChangeDependencies() {
    _theme = Theme.of(context);
    textController=TextEditingController(text: formatDate(DateTime.now().toString()));
    super.didChangeDependencies();
  }
  formatDate(String date){
    return date.split(' ').first;
  }
  Future<void>datePressed() async {
    final selectedDate =await showDialog(
        context: context,
        builder: (_) => DatePickerDialog(
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 2),
        ));
    if (selectedDate != null) {
      textController.text = formatDate(selectedDate.toString());
      context.read<TripBloc>().dateChange(formatDate(selectedDate.toString())); // Call your method here
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical: 20),
      child: Container(
        padding: const EdgeInsetsDirectional.all(10),
        decoration: BoxDecoration(
          border: Border.all(
            color:  Colors.grey,
          ),
          borderRadius: BorderRadius.circular(32),

        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: datePressed,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(32),
                bottomStart: Radius.circular(32),
              ).resolve(Directionality.of(context)),
              child: IconTheme.merge(
                  data: IconThemeData(
                    color: _theme.primaryColor,
                  ),
                  child: const Icon(Icons.date_range)),
            ),
            const VerticalDivider(
              color: Colors.black,
              thickness: 0.5,
              width: 0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,),
                child: TextFormField(
                  readOnly: true,
                  controller: textController,
                  onTap: datePressed,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    alignLabelWithHint: true,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
