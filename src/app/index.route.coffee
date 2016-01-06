angular.module 'workloadPlanner'
  .config ($stateProvider, $urlRouterProvider) ->
    'ngInject'
    $stateProvider
      # .state 'home',
      #   abstract: true
      #   url: '/planner'
      #   templateUrl: 'app/main/main.html'
      #   controller: 'MainController'
      #   controllerAs: 'main'
      .state 'planner',
        url: '/planner',
        templateUrl: 'app/partials/planner.html'
        controller: 'MainController'
        controllerAs: 'main'
      .state 'persons',
        url: '/persons',
        templateUrl: 'app/partials/persons.html'
        controller: 'MainController'
        controllerAs: 'main'
      .state 'tasks',
        url: '/tasks',
        templateUrl: 'app/partials/tasks.html'

    $urlRouterProvider.otherwise '/planner'
