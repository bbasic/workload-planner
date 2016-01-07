angular.module 'workloadPlanner'
  .directive 'workloadPlannerNavbar', ->
    'ngInject'

    NavbarController = (moment, $log, $rootScope, $translate) ->
      'ngInject'
      vm = this

      # "vm.creation" is avaible by directive option "bindToController: true" # (was previously given from MainController)
      # vm.relativeDate = moment(vm.creationDate).fromNow()

      vm.activeRoute = undefined
      $rootScope.$on '$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
        vm.activeRoute = toState.name

      vm.currentLanguage = -> 'navigation.language.' + if $translate.use() == 'en_EN' then 'de_DE' else 'en_EN'
      vm.toggleLanguage = -> $translate.use( if $translate.use() == 'en_EN' then 'de_DE' else 'en_EN')

      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/navbar/navbar.html'
      scope: creationDate: '='
      controller: NavbarController
      controllerAs: 'vm'
      bindToController: true
