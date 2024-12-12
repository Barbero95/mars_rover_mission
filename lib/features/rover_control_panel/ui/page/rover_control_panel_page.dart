import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mars_rover_mission/core/commons/services/export_services.dart';
import 'package:mars_rover_mission/core/commons/ui/export_ui.dart';
import 'package:mars_rover_mission/features/rover_control_panel/export_rover_control_panel.dart';

class _Constants {
  static const double startMenuAnimation = 0;
  static const double endMenuAnimation = 1;
  static const menuAnimationDuration = Duration(seconds: 1);
}

class _Strings {
  static const title = 'Rover Control Panel';
  static const screenStateError = 'Ups! We have lost connection with the rover';
  static const menuSL = 'Show menu';
  static const maxZoomOutLabel = 'Max Zoom Out';
  static const maxZoomInLabel = 'Max Zoom In';
}

class RoverControlPanelPage extends StatefulWidget {
  final RoverControlPanelExtra extra;

  const RoverControlPanelPage({
    super.key,
    required this.extra,
  });

  @override
  State<RoverControlPanelPage> createState() => _RoverControlPanelPageState();
}

class _RoverControlPanelPageState extends State<RoverControlPanelPage>
    with SingleTickerProviderStateMixin {
  late final RoverControlPanelBloc _roverCPBloc;
  late AnimationController _menuController;
  late Animation<double> _menuAnimation;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _roverCPBloc = locator<RoverControlPanelBloc>()
      ..init(
        widget.extra,
      );
    _menuController = AnimationController(
      vsync: this,
      duration: _Constants.menuAnimationDuration,
    );
    _menuAnimation = Tween<double>(
      begin: _Constants.startMenuAnimation,
      end: _Constants.endMenuAnimation,
    ).animate(_menuController);
  }

  @override
  void dispose() {
    _menuController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(_Strings.title),
      ),
      body: ValueListenableBuilder(
        valueListenable: _roverCPBloc.screenState,
        builder: (context, screenState, _) {
          if (screenState.isError) {
            return const Center(
              child: Text(
                _Strings.screenStateError,
              ),
            );
          }

          return Column(
            children: [
              HeaderWidget(
                roverCPBloc: _roverCPBloc,
              ),
              Spaces.verticalS(),
              GridWidget(
                roverCPBloc: _roverCPBloc,
              ),
              Spaces.verticalS(),
              const PackageInfoWidget(),
              Spaces.verticalXXS(),
            ],
          );
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isMenuOpen) ...[
            FloatingActionButton.extended(
              heroTag: 'maxZoomOut',
              onPressed: () => _roverCPBloc.maxZoomOut(context),
              label: const Text(_Strings.maxZoomOutLabel),
              icon: const Icon(Icons.zoom_out),
            ),
            Spaces.verticalXXS(),
            FloatingActionButton.extended(
              heroTag: 'maxZoomIn',
              onPressed: () => _roverCPBloc.maxZoomIn(context),
              label: const Text(_Strings.maxZoomInLabel),
              icon: const Icon(Icons.zoom_in),
            ),
            Spaces.verticalXXS(),
            FloatingActionButton(
              heroTag: 'zoomOut',
              onPressed: () => _roverCPBloc.zoomOut(context),
              child: const Icon(Icons.zoom_out),
            ),
            Spaces.verticalXXS(),
            FloatingActionButton(
              heroTag: 'zoomIn',
              onPressed: () => _roverCPBloc.zoomIn(context),
              child: const Icon(Icons.zoom_in),
            ),
            Spaces.verticalXXS(),
          ],
          FloatingActionButton(
            heroTag: 'menu',
            onPressed: () {
              if (_menuController.isForwardOrCompleted) {
                _menuController.reverse();
              } else {
                _menuController.forward();
              }
              Timer(Durations.medium2, () {
                setState(() => _isMenuOpen = !_isMenuOpen);
              });
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.menu_close,
              progress: _menuAnimation,
              semanticLabel: _Strings.menuSL,
            ),
          ),
        ],
      ),
    );
  }
}
