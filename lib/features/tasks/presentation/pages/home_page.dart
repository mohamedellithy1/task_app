import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:task_app/core/language/language_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/task.dart';
import '../../../weather/presentation/cubit/weather_cubit.dart';
import '../../../weather/presentation/cubit/weather_state.dart';
import '../../../weather/presentation/widgets/weather_card.dart';
import '../cubit/task_cubit.dart';
import '../cubit/task_state.dart';
import '../widgets/add_task_bottom_sheet.dart';
import '../widgets/app_sidebar.dart';
import '../widgets/empty_tasks_widget.dart';
import '../widgets/progress_indicator_widget.dart';
import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().loadTasks();
    context.read<WeatherCubit>().getWeather();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddTaskSheet({Task? taskToEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddTaskBottomSheet(taskToEdit: taskToEdit),
    ).then((task) {
      if (task != null) {
        if (taskToEdit != null) {
          context.read<TaskCubit>().editTask(task);
        } else {
          context.read<TaskCubit>().createTask(task);
        }
      }
    });
  }

  void _showDeleteConfirmation(String taskId, String taskTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'deleteTask'.tr(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          '${'confirmDelete'.tr()} "$taskTitle"?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr(), style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<TaskCubit>().removeTask(taskId);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(
              'delete'.tr(),
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        final isMobile = sizingInformation.isMobile;

        return Scaffold(
          appBar: _buildAppBar(isMobile),
          drawer: isMobile ? _buildDrawer() : null,
          body: BlocListener<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is TaskOperationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message, style: GoogleFonts.poppins()),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              } else if (state is TaskError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message, style: GoogleFonts.poppins()),
                    backgroundColor: AppColors.error,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            child: Row(
              children: [
                if (!isMobile) _buildSidebar(),

                Expanded(child: _buildMainContent(isMobile)),
              ],
            ),
          ),
          floatingActionButton: _buildFAB(isMobile),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(bool isMobile) {
    return AppBar(
      title: Text(
        'appTitle'.tr(),
        style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: _showSearchDialog,
          tooltip: 'searchTasks'.tr(),
        ),
      
        BlocBuilder<LanguageCubit, Locale>(
          builder: (context, locale) {
            return IconButton(
              icon: Text(
                locale.languageCode == 'ar' ? 'EN' : 'ع',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () async {
                final cubit = context.read<LanguageCubit>();
                await cubit.toggleLanguage();
                await context.setLocale(cubit.state);
              },
              tooltip: 'language'.tr(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSidebar() {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        final showCompletedOnly =
            state is TaskLoaded && state.showCompletedOnly;

        return AppSidebar(
          showCompletedOnly: showCompletedOnly,
          onHomePressed: () {
            if (state is TaskLoaded && state.showCompletedOnly) {
              context.read<TaskCubit>().toggleShowCompletedOnly();
            }
          },
          onCompletedPressed: () {
            if (state is TaskLoaded && !state.showCompletedOnly) {
              context.read<TaskCubit>().toggleShowCompletedOnly();
            }
          },
          onSettingsPressed: () {
          },
        );
      },
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          final showCompletedOnly =
              state is TaskLoaded && state.showCompletedOnly;

          return AppSidebar(
            showCompletedOnly: showCompletedOnly,
            onHomePressed: () {
              if (state is TaskLoaded && state.showCompletedOnly) {
                context.read<TaskCubit>().toggleShowCompletedOnly();
              }
              Navigator.pop(context);
            },
            onCompletedPressed: () {
              if (state is TaskLoaded && !state.showCompletedOnly) {
                context.read<TaskCubit>().toggleShowCompletedOnly();
              }
              Navigator.pop(context);
            },
            onSettingsPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  Widget _buildMainContent(bool isMobile) {
    return Column(
      children: [
        BlocBuilder<WeatherCubit, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return WeatherCard(
                weather: state.weather,
                onRefresh: () => context.read<WeatherCubit>().refreshWeather(),
                onCitySearch: (cityName) =>
                    context.read<WeatherCubit>().getWeatherByCity(cityName),
              );
            } else if (state is WeatherError) {
              return Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: AppColors.error),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'failedToLoadWeather'.tr(),
                        style: GoogleFonts.poppins(color: AppColors.error),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () =>
                          context.read<WeatherCubit>().getWeather(),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),

        Expanded(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, state) {
              if (state is TaskLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is TaskLoaded) {
                return _buildTaskList(state, isMobile);
              } else if (state is TaskError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      Text(state.message, style: GoogleFonts.poppins()),
                    ],
                  ),
                );
              }
              return const EmptyTasksWidget();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskList(TaskLoaded state, bool isMobile) {
    final tasks = state.filteredTasks;

    if (tasks.isEmpty) {
      return EmptyTasksWidget(
        message: state.showCompletedOnly
            ? 'noCompletedTasksYet'.tr()
            : 'noTasksYet'.tr(),
        icon: state.showCompletedOnly ? Icons.check_circle : Icons.task_alt,
      );
    }

    return Column(
      children: [
        if (!state.showCompletedOnly && state.totalCount > 0)
          ProgressIndicatorWidget(
            percentage: state.completionPercentage,
            completedCount: state.completedCount,
            totalCount: state.totalCount,
          ),

        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 80),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: TaskCard(
                        task: task,
                        onTap: () => _showAddTaskSheet(taskToEdit: task),
                        onDelete: () =>
                            _showDeleteConfirmation(task.id, task.title),
                        onToggleComplete: () {
                          context.read<TaskCubit>().toggleCompletion(task.id);
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFAB(bool isMobile) {
    return isMobile
        ? FloatingActionButton(
            onPressed: () => _showAddTaskSheet(),
            child: const Icon(Icons.add),
          )
        : FloatingActionButton.extended(
            onPressed: () => _showAddTaskSheet(),
            icon: const Icon(Icons.add),
            label: Text(
              'addTask'.tr(),
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          'searchTasks'.tr(),
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'enterSearchQuery'.tr(),
            prefixIcon: const Icon(Icons.search),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              context.read<TaskCubit>().searchTasks('');
              Navigator.pop(dialogContext);
            },
            child: Text('clear'.tr(), style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<TaskCubit>().searchTasks(_searchController.text);
              Navigator.pop(dialogContext);
            },
            child: Text('search'.tr(), style: GoogleFonts.poppins()),
          ),
        ],
      ),
    );
  }
}
