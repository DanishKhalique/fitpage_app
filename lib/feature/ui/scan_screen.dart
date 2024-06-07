import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_diary_flutter/feature/bloc/scanner_bloc.dart';
import 'scan_criteria_widget.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scans')),
      body: BlocProvider(
        create: (context) =>
            BlocProvider.of<ScanBloc>(context)..add(FetchScans()),
        child: BlocBuilder<ScanBloc, ScanState>(
          builder: (context, state) {
            if (state is ScanLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ScanLoaded) {
              return ListView.builder(
                itemCount: state.scans.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.scans[index].name),
                    subtitle: Text(state.scans[index].tag),
                    tileColor: state.scans[index].color == 'green'
                        ? Colors.green[100]
                        : Colors.red[100],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ScanCriteriaWidget(scan: state.scans[index])),
                    ),
                  );
                },
              );
            } else if (state is ScanError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
