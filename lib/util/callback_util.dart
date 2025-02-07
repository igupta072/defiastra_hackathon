typedef NavigationCallback<T> = void Function(String, {T? argument});
typedef ErrorCallback = void Function(String);
typedef ResultCallback<T> = void Function(T);