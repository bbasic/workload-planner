angular.module 'workloadPlanner'
  .directive 'tasks', ->
    'ngInject'

    TasksController = (tasks, $log, $translate, toastr, $scope, moment) ->
      'ngInject'
      vm = this

      newTask = -> {
        taskName: undefined
        activeDays: [
          false,  # 0 = su
          false,  # 1 = mo
          false,  # 2 = tu
          false,  # 3 = we
          false,  # 4 = th
          false,  # 5 = fr
          false   # 6 = sa
        ]
      }

      add = ->
        vm.newTask = newTask()

      edit = (task) ->
        task._edit = true
        task._original = angular.copy(task)

      deleteTask = (task, confirmed = false) ->
        if confirmed
          vm.tasks.splice(vm.tasks.indexOf(task), 1)
          tasks.dataUpdated()
        else
          task._delete = true

      save = (task = undefined) ->
        if task?._edit
          task._edit = false
        else
          vm.tasks.push(angular.copy(vm.newTask))
          vm.newTask = undefined
          vm.tasks.sort ((a,b)-> a.taskName.toLowerCase() > b.taskName.toLowerCase())
        tasks.dataUpdated()

      keyUp = ($event, task) ->
        if $event.keyCode == 13 then save(task)

      cancle = (task) ->
        task._edit = false
        task.taskName = task._original.taskName
        task.lastName = task._original.lastName
        delete task['_original']

      # PUBLIC
      $scope.moment = moment
      vm.tasks = tasks.getData().sort ((a,b)-> a.taskName.toLowerCase() > b.taskName.toLowerCase())
      vm.newTask = undefined
      vm.add = add
      vm.edit = edit
      vm.delete = deleteTask
      vm.save = save
      vm.keyUp = keyUp
      vm.cancle = cancle

      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/tasks/tasks.html'
      controller: TasksController
      controllerAs: 'vm'
