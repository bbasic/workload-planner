angular.module 'workloadPlanner'
  .service 'workloadData', () ->
    'ngInject'
    
    getPersons = -> JSON.parse(localStorage.getItem('workloadData-persons') || '[]')
    setPersons = (persons) -> localStorage.setItem('workloadData-persons', JSON.stringify(persons, ['firstName', 'lastName']))

    getTasks = -> JSON.parse(localStorage.getItem('workloadData-tasks') || '[]')
    setTasks = (tasks) -> localStorage.setItem('workloadData-tasks', JSON.stringify(tasks, ['taskName', 'activeDays']))

    service =
      getPersons: getPersons
      setPersons: setPersons
      getTasks: getTasks
      setTasks: setTasks
