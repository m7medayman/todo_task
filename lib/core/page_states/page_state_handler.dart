import 'package:flutter/material.dart';
import 'package:task/core/page_states/page_states.dart';
import 'package:task/core/rout_manager/rout_manager.dart';
import 'package:task/core/state_renderer/pop_state_dialog_widget.dart';

class PageStateHandler {
  bool _isLoading = false;

  PageStateHandler();
  void handlePageState(PageState state, BuildContext context) {
    if (state is LoadingPageState) {
      if (!_isLoading) {
        _isLoading = true;
        showLoadingPopUpDialog(context);
      }
    } else {
      if (_isLoading) {
        _isLoading = false;
        Navigator.of(context).pop();
      }
    }

    if (state is FailurePageState) {
      showFailurePopUpDialog(context, state.errorMessage);
    }
    if (state is UnauthorizedPageState) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Routes.login, (route) => false);
    }
  }
}
