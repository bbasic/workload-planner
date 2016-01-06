angular.module 'workloadPlanner'
  .config ($logProvider, toastrConfig) ->
    'ngInject'
    # Enable log
    $logProvider.debugEnabled true
    # Set options third-party lib
    toastrConfig.allowHtml = true
    toastrConfig.timeOut = 3000
    toastrConfig.positionClass = 'toast-top-right'
    toastrConfig.preventDuplicates = true
    toastrConfig.progressBar = true

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
    }
