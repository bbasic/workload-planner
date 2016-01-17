angular.module 'workloadPlanner'
  .directive 'planner', ->
    'ngInject'

    PlannerController = (persons, tasks, $log, $translate, toastr, $scope, moment, workloadData) ->
      'ngInject'
      vm = this

      calculate = (date) ->
        $log.log 'date', date
        if date == undefined then vm.week = new Date()
        week = moment(date)
        if week.isBefore(moment()) then week = moment()
        if !week.isBetween(moment().startOf('week'), moment().endOf('week')) then week.startOf('week')
        $log.log 'weekChanged', week, week.days()
        plan = []
        matrix = workloadData.getPriorityMatrix()

        $log.info matrix
        # all days without sunday
        for day in [week.day()..6]
          $log.log day

        sunday = 0
        personsMap = persons.getDataAsMap()
        tasksMap = tasks.getDataAsMap()
        $log.log 'personsMap', personsMap
        for id, task of tasksMap
          $log.log 'task', id, task, task.activeDays[sunday]

        vm.startDay = week.format('dddd, LL')
        vm.endDay = week.endOf('week').format('dddd, LL')

        # after calculation
        workloadData.setPriorityMatrix(matrix)

      # PUBLIC
      $scope.moment = moment
      vm.persons = persons.getData()
      vm.tasks = tasks.getData()
      vm.week = new Date()
      calculate(vm.week)

      currentDate = moment()
      currentWeek = currentDate.week()
      vm.minWeek = currentDate.year() + '-W' + if currentWeek < 10 then '0'+currentWeek else currentWeek
      $log.log 'minWeek', vm.minWeek

      maxDate = moment().endOf('week').day('-1').add(4, 'w')
      maxWeek = maxDate.week()
      vm.maxWeek = maxDate.year() + '-W' + if maxWeek < 10 then '0'+maxWeek else maxWeek
      $log.log 'maxWeek', vm.maxWeek

      vm.weekChanged = (date) -> calculate(date)

      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/planner/planner.html'
      controller: PlannerController
      controllerAs: 'vm'
