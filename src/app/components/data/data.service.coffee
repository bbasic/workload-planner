angular.module 'workloadPlanner'
  .service 'workloadData', (localStorage, $log, $timeout) ->
    'ngInject'

    diff = (a, b) ->
      if a.length > b.length
        a.filter((i) -> b.indexOf(i) < 0)
      else
        b.filter((i) -> a.indexOf(i) < 0)

    getPersons = -> JSON.parse(localStorage.getItem('workloadData-persons') || '[]')
    setPersons = (persons, person = undefined) ->
      if person?
        old = getPersons()
        matrix = getPriorityMatrix()
        if old.length > persons.length
          $log.log 'person deleted', person
          delete matrix[person.id]
        else
          $log.log 'person added', person
          matrix[person.id] = {}
          for t in getTasks()
            sum = 0
            for p in old
              sum += matrix[p.id][t.id]
            matrix[person.id][t.id] = if sum == 0 then sum else Math.floor(sum / old.length)
        setPriorityMatrix(matrix)
      $timeout(
        -> localStorage.setItem('workloadData-persons', JSON.stringify(persons, ['id', 'firstName', 'lastName']))
      , 100)


    getTasks = -> JSON.parse(localStorage.getItem('workloadData-tasks') || '[]')
    setTasks = (tasks, task = undefined) ->
      if task?
        old = getTasks()
        ps = getPersons()
        matrix = getPriorityMatrix()
        if old.length > tasks.length
          $log.log 'task deleted', task
          for p in ps
            per = matrix[p.id]
            delete per[task.id]
        else
          $log.log 'task added', task
          for p in ps
            matrix[p.id][task.id] = 0
        setPriorityMatrix(matrix)
      $timeout(
        -> localStorage.setItem('workloadData-tasks', JSON.stringify(tasks, ['id', 'taskName', 'activeDays']))
      , 100)

    _generatePriorityMatrix = ->
      matrix = {}
      ps = getPersons()
      ts = getTasks()
      for p in ps
        matrix[p.id] = {}
        for t in ts
          matrix[p.id][t.id] = 0
      return matrix
    getPriorityMatrix = ->
      pm = JSON.parse(localStorage.getItem('workloadData-priorityMatrix') || '[]')
      if angular.isArray(pm) then _generatePriorityMatrix() else pm


    setPriorityMatrix = (priorityMatrix) ->
      $timeout(
        -> localStorage.setItem('workloadData-priorityMatrix', JSON.stringify(priorityMatrix))
      , 100)

    getNextId = (who) ->
      key = 'workloadData-'+who+'-id'
      newId = parseInt(localStorage.getItem(key) || '0') + 1
      localStorage.setItem(key, newId)
      newId

    service =
      getPersons: getPersons
      setPersons: setPersons
      getTasks: getTasks
      setTasks: setTasks
      nextId: getNextId
      getPriorityMatrix: getPriorityMatrix
      setPriorityMatrix: setPriorityMatrix
