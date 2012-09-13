while (condition) {
  label_redo:
  goto label_next;
  goto label_break;
  goto label_redo;
  ...
  ...
  label_next:
}
label_break: