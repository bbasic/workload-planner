angular.module 'workloadPlanner'
  .service 'tasks', (workloadData) ->
    'ngInject'


    tasks = undefined

    getData = () ->
      tasks = workloadData.getTasks()
      return tasks
    getDataAsMap = ->
      ts = if tasks? then tasks else workloadData.getTasks()
      result = {}
      for t in ts
        result[t.id] = t
      return result

    dataUpdated = (task) -> workloadData.setTasks(tasks, task)

    newTask = -> {
      id: 't-'+workloadData.nextId('task')
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
    service =
      getData: getData
      getDataAsMap: getDataAsMap
      dataUpdated: dataUpdated
      newTask: newTask
