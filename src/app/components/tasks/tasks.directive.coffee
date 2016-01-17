angular.module 'workloadPlanner'
  .directive 'tasks', ->
    'ngInject'

    TasksController = (tasks, $log, $translate, toastr, $scope, moment) ->
      'ngInject'
      vm = this

      add = ->
        vm.newTask = tasks.newTask()

      edit = (task) ->
        task._edit = true
        task._original = angular.copy(task)

      deleteTask = (task, confirmed = false) ->
        if confirmed
          vm.tasks.splice(vm.tasks.indexOf(task), 1)
          tasks.dataUpdated(task)
        else
          task._delete = true

      save = (task = undefined) ->
        if task?._edit
          task._edit = false
          tasks.dataUpdated()
        else
          vm.tasks.push(angular.copy(vm.newTask))
          vm.newTask = undefined
          vm.tasks.sort ((a,b)-> a.taskName.toLowerCase() > b.taskName.toLowerCase())
          tasks.dataUpdated(task)

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
