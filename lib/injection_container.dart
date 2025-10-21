import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/theme_cubit.dart';
import 'core/language/language_cubit.dart';
import 'features/tasks/data/datasources/app_database.dart';
import 'features/tasks/data/datasources/task_drift_datasource.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/repositories/task_repository.dart';
import 'features/tasks/domain/usecases/add_task.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/tasks/domain/usecases/get_tasks.dart';
import 'features/tasks/domain/usecases/toggle_task_completion.dart';
import 'features/tasks/domain/usecases/update_task.dart';
import 'features/tasks/presentation/cubit/task_cubit.dart';
import 'features/weather/data/datasources/weather_remote_datasource.dart';
import 'features/weather/data/repositories/weather_repository_impl.dart';
import 'features/weather/domain/repositories/weather_repository.dart';
import 'features/weather/presentation/cubit/weather_cubit.dart';

class InjectionContainer {
  late SharedPreferences sharedPreferences;
  late http.Client httpClient;
  late AppDatabase appDatabase;

  late TaskCubit taskCubit;
  late WeatherCubit weatherCubit;
  late ThemeCubit themeCubit;
  late LanguageCubit languageCubit;

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    httpClient = http.Client();
    appDatabase = AppDatabase();

    final taskDriftDataSource = TaskDriftDataSourceImpl(database: appDatabase);

    final weatherRemoteDataSource = WeatherRemoteDataSourceImpl(
      client: httpClient,
    );

    final TaskRepository taskRepository = TaskRepositoryImpl(
      driftDataSource: taskDriftDataSource,
    );

    final WeatherRepository weatherRepository = WeatherRepositoryImpl(
      remoteDataSource: weatherRemoteDataSource,
    );

    final getTasks = GetTasks(taskRepository);
    final addTask = AddTask(taskRepository);
    final updateTask = UpdateTask(taskRepository);
    final deleteTask = DeleteTask(taskRepository);
    final toggleTaskCompletion = ToggleTaskCompletion(taskRepository);

    taskCubit = TaskCubit(
      getTasks: getTasks,
      addTask: addTask,
      updateTask: updateTask,
      deleteTask: deleteTask,
      toggleTaskCompletion: toggleTaskCompletion,
    );

    weatherCubit = WeatherCubit(repository: weatherRepository);

    themeCubit = ThemeCubit(sharedPreferences: sharedPreferences);
    languageCubit = LanguageCubit(sharedPreferences: sharedPreferences);
  }

  void dispose() {
    taskCubit.close();
    weatherCubit.close();
    themeCubit.close();
    languageCubit.close();
    httpClient.close();
    appDatabase.close();
  }
}
