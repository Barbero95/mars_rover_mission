import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/services/export_services.dart';
import 'package:mars_rover_mission/core/commons/ui/export_ui.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';
import 'package:mars_rover_mission/features/setup/domain/export_domain.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  late final SetupBloc _setupBloc;

  @override
  void initState() {
    super.initState();
    _setupBloc = locator<SetupBloc>();
  }

  @override
  void dispose() {
    _setupBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setup Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spaces.spaceXS),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _setupBloc.rowsTE,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Rows',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Spaces.horizontalXS(),
                Expanded(
                  child: TextField(
                    controller: _setupBloc.columnsTE,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Columns',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            Spaces.verticalXS(),
            TextField(
              controller: _setupBloc.commandsTE,
              decoration: InputDecoration(
                labelText: 'Commands (${CommandType.values.join(',')})',
                border: const OutlineInputBorder(),
              ),
            ),
            Spaces.verticalXS(),
            ElevatedButton(
              onPressed: () => _setupBloc.navigateToPanelControl(context),
              child: const Text('Go to Panel Control'),
            )
          ],
        ),
      ),
    );
  }
}
