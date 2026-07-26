import 'package:flutter/material.dart';

/// Runs `validate()` on [formKey] and, when a field fails, brings the first
/// invalid one into view.
///
/// Forms here are taller than the screen, so an error could land below the
/// fold — the user tapped submit, nothing visibly changed, and the button
/// looked broken. Rather than making every screen hold a [GlobalKey] per
/// field, this walks the form's element tree for the first [FormFieldState]
/// reporting an error. `visitChildren` is depth-first in child order, which
/// for the `Column`s these forms are built from matches top-to-bottom.
///
/// Returns whether the form is valid, so callers read as
/// `if (!validateAndScrollToError(_formKey)) return;`.
bool validateAndScrollToError(GlobalKey<FormState> formKey) {
  final form = formKey.currentState;
  if (form == null) return false;
  if (form.validate()) return true;

  final formContext = formKey.currentContext;
  if (formContext is Element) {
    final invalid = _firstInvalidField(formContext);
    if (invalid != null && invalid.context.mounted) {
      Scrollable.ensureVisible(
        invalid.context,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        // Leaves a little breathing room above the field rather than pinning
        // it flush to the top edge.
        alignment: 0.15,
      );
    }
  }
  return false;
}

FormFieldState<dynamic>? _firstInvalidField(Element root) {
  FormFieldState<dynamic>? found;

  void visit(Element element) {
    if (found != null) return;
    if (element is StatefulElement) {
      final state = element.state;
      if (state is FormFieldState && state.hasError) {
        found = state;
        return;
      }
    }
    element.visitChildren(visit);
  }

  root.visitChildren(visit);
  return found;
}
