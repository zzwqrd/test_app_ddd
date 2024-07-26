import 'package:dartz/dartz.dart';

import '../../dialogs/error_alert_dialogue_widget.dart';
import 'failures.dart';

void failureHandler(
    Either<Failure, dynamic> result, void Function() onSuccess) {
  result.fold(
    (l) => showErrorDialogue(l.message ?? "errorMessage"),
    (r) => onSuccess(),
  );
}
