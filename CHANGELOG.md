## 0.0.1
A collection of helpful widgets and extensions for async values
## 0.0.2
Modified the showDialogOnError function to use the error_alert_manager library. This will allow errors to only be shown once if showDialogOnError is called multiple times for the same error
## 0.0.3
Rearranged the file structure
## 0.0.4
Modified the showdialogOnError function to NOT  use the error_alert_manager library, as it was too complicated. Now, it simply uses a private variable _lastError to track the last error.
