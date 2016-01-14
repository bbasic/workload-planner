angular.module 'workloadPlanner'
  .directive 'planner', ->
    'ngInject'

    PlannerController = (persons, tasks, $log, $translate, toastr, $scope, moment) ->
      'ngInject'
      vm = this

      # PUBLIC
      $scope.moment = moment
      vm.persons = persons.getData()
      vm.tasks = tasks.getData()

      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/planner/planner.html'
      controller: PlannerController
      controllerAs: 'vm'
