angular.module 'workloadPlanner'
  .directive 'autoFocus', ($timeout, $log)->
    'ngInject'

    directive =
      restrict: 'AC',
      link: (scope, element) ->
        $timeout(->
          $log.info 'autoFocus', element[0]
          element[0].focus()
        , 0)
