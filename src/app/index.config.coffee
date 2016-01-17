angular.module 'workloadPlanner'
  .config ($logProvider, toastrConfig, moment) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true
    # Set options third-party lib
    toastrConfig.allowHtml = true
    toastrConfig.timeOut = 3000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = true
    toastrConfig.progressBar = true

    # set moment locale
    moment.locale('de-at')

  .config ($translateProvider) ->
    'ngInject'
    $translateProvider.useSanitizeValueStrategy('sanitize')
    $translateProvider.useLocalStorage()
    $translateProvider.preferredLanguage('de_DE')

    $translateProvider.translations 'de_DE', {
      # NAVIGATION

      'navigation.planner':     'Planer'
      'navigation.persons':     'Personen'
      'navigation.tasks':       'Aufgaben'
      'navigation.data':        'Daten'
      'navigation.data.export': 'Exportieren'
      'navigation.data.import': 'Importieren'
      'navigation.language.en_EN': 'En'
      'navigation.language.de_DE': 'De'

      # PERSONS
      'persons.firstName': 'Vorname'
      'persons.lastName': 'Nachname'

      # TASKS
      'tasks.taskName': 'Name'
      'tasks.activeDays': 'Ausführende Tage'

      # PLANNER
      'planner.chooseWeek': 'Woche auswählen'
    }
    $translateProvider.translations 'en_EN', {
      # NAVIGATION

      'navigation.planner':     'Planner'
      'navigation.persons':     'Persons'
      'navigation.tasks':       'Tasks'
      'navigation.data':        'Data'
      'navigation.data.export': 'Export'
      'navigation.data.import': 'Import'
      'navigation.language.en_EN': 'En'
      'navigation.language.de_DE': 'De'

      # PERSONS
      'persons.firstName': 'First Name'
      'persons.lastName': 'Last Name'

      # TASKS
      'tasks.taskName': 'Name'
      'tasks.activeDays': 'Active days'

      # PLANNER
      'planner.chooseWeek': 'Choose Week'
    }
