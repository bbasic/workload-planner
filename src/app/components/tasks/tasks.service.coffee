angular.module 'workloadPlanner'
  .service 'tasks', (workloadData) ->
    'ngInject'


    tasks = undefined
    
    getData = () ->
      tasks = workloadData.getTasks()
      return tasks

    dataUpdated = -> workloadData.setTasks(tasks)
      
    service =
      getData: getData
      dataUpdated: dataUpdated
