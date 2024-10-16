import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/obstetri_cubit.dart';
import 'package:mommy_be/cubit/obstetri_state.dart';
import 'package:mommy_be/pages/obstetri_create.dart';
import 'package:mommy_be/shared/widgets/page_title.dart';
import 'package:mommy_be/shared/widgets/retry_button.dart';

class ObstetriScreen extends StatefulWidget {
  const ObstetriScreen({super.key});

  @override
  State<ObstetriScreen> createState() => _ObstetriScreenState();
}

class _ObstetriScreenState extends State<ObstetriScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(child: PageTitle(title: "Obstetri")),
                    FilledButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ObstetriCreateScreen(),
                          ),
                        );
                      },
                      style: ButtonStyle(
                        visualDensity: VisualDensity.compact,
                        padding: WidgetStateProperty.all(EdgeInsets.zero),
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<ObstetriCubit, ObstetriState>(
                builder: (context, state) {
                  if (state is ObstetriLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state is ObstetriSuccess) {
                    return ExpansionPanelList(
                      expansionCallback: (panelIndex, isExpanded) {},
                      dividerColor: Colors.grey.shade300,
                      children: state.obstetri.map((obstetri) {
                        return ExpansionPanel(
                          headerBuilder: (context, isExpanded) {
                            return ListTile(
                              title: Text("Data Obstetri ${state.obstetri.indexOf(obstetri) + 1}"),
                            );
                          },
                          body: Column(
                            children: [],
                          ),
                        );
                      },).toList(),
                    );
                  }
                  
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: RetryButton(
                      message: (state is ObstetriFailed)
                          ? state.error
                          : "Terjadi kesalahan",
                      onPressed: () =>
                          context.read<ObstetriCubit>().getObstetri(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
