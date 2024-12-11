import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/domain/enums/export_enums.dart';
import 'package:mars_rover_mission/core/commons/services/export_services.dart';
import 'package:mars_rover_mission/core/commons/ui/export_ui.dart';
import 'package:mars_rover_mission/features/setup/domain/export_domain.dart';

class _Constants {
  static const numMaxLength = 5;
  static const commandsMaxLength = 50;
}

class _Strings {
  static const title = 'Setup Page';
  static const gridTitle = 'Grid:';
  static const rowsLabel = 'Rows';
  static const columnsLabel = 'Columns';
  static const obstaclesTitle = 'Number of obstacles:';
  static const obstaclesLabel = 'Nº Obstacles';
  static const commandsTitle = 'Commands';
  static const forwardInfo = 'The rover can move forward (F)';
  static const turnInfo = 'The rover can move left/right (L,R)';
  static const navigationButton = 'Go to Panel Control';
}

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
        title: const Text(_Strings.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Spaces.spaceXS),
        child: Form(
          key: _setupBloc.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _Strings.gridTitle,
                style: CustomTextStyle.paragraphLsemibold,
              ),
              Spaces.verticalXS(),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: _setupBloc.rowsTE,
                      label: _Strings.rowsLabel,
                      type: TextFormFieldType.number,
                      maxLength: _Constants.numMaxLength,
                    ),
                  ),
                  Spaces.horizontalXS(),
                  Expanded(
                    child: CustomTextFormField(
                      controller: _setupBloc.columnsTE,
                      label: _Strings.columnsLabel,
                      type: TextFormFieldType.number,
                      maxLength: _Constants.numMaxLength,
                    ),
                  ),
                ],
              ),
              Spaces.verticalXXS(),
              Text(
                _Strings.obstaclesTitle,
                style: CustomTextStyle.paragraphLsemibold,
              ),
              Spaces.verticalXS(),
              CustomTextFormField(
                controller: _setupBloc.numberOfObstaclesTE,
                label: _Strings.obstaclesLabel,
                type: TextFormFieldType.number,
                maxLength: _Constants.numMaxLength,
              ),
              Spaces.verticalXXS(),
              Text(
                '${_Strings.commandsTitle}:',
                style: CustomTextStyle.paragraphLsemibold,
              ),
              Spaces.verticalXS(),
              CustomTextFormField(
                controller: _setupBloc.commandsTE,
                label: _Strings.commandsTitle,
                type: TextFormFieldType.command,
                maxLength: _Constants.commandsMaxLength,
              ),
              const CustomInfoWidget(
                text: _Strings.forwardInfo,
              ),
              const CustomInfoWidget(
                text: _Strings.turnInfo,
              ),
              Spaces.verticalS(),
              Center(
                child: FilledButton(
                  onPressed: () => _setupBloc.navigateToPanelControl(context),
                  child: const Text(
                    _Strings.navigationButton,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
