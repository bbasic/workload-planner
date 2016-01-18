angular.module 'workloadPlanner'
  .service 'workloadData', (localStorage, $log, $timeout) ->
    'ngInject'
    _persons = undefined
    _tasks = undefined
    _priorityMatrix = undefined
    _nextId = {}

    diff = (a, b) ->
      if a.length > b.length
        a.filter((i) -> b.indexOf(i) < 0)
      else
        b.filter((i) -> a.indexOf(i) < 0)

    getPersons = ->
      if _persons? then return _persons
      _persons = JSON.parse(localStorage.getItem('workloadData-persons') || '[]')
      return _persons

    setPersons = (persons, person = undefined) ->
      _persons = persons
      if person?
        matrix = getPriorityMatrix()
        if person._deleted
          $log.log 'person deleted', person
          delete matrix[person.id]
        else if person._added
          $log.log 'person added', person
          matrix[person.id] = {}
          for t in getTasks()
            sum = 0
            for p in persons
              sum += matrix[p.id][t.id]
            matrix[person.id][t.id] = if sum == 0 then sum else Math.floor(sum / persons.length)
        setPriorityMatrix(matrix)
      $timeout(
        -> localStorage.setItem('workloadData-persons', JSON.stringify(persons, ['id', 'firstName', 'lastName']))
      , 100)


    getTasks = ->
      if _tasks? then return _tasks
      _tasks = JSON.parse(localStorage.getItem('workloadData-tasks') || '[]')
      return _tasks
    setTasks = (tasks, task = undefined) ->
      _tasks = tasks
      if task?
        ps = getPersons()
        matrix = getPriorityMatrix()
        if task._deleted
          $log.log 'task deleted', task
          for p in ps
            per = matrix[p.id]
            delete per[task.id]
        else if task._added
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
      if _priorityMatrix? then return _priorityMatrix
      _priorityMatrix = JSON.parse(localStorage.getItem('workloadData-priorityMatrix') || '[]')
      if angular.isArray(_priorityMatrix) then _priorityMatrix = _generatePriorityMatrix()
      return _priorityMatrix


    setPriorityMatrix = (priorityMatrix) ->
      _priorityMatrix = priorityMatrix
      $timeout(
        -> localStorage.setItem('workloadData-priorityMatrix', JSON.stringify(priorityMatrix))
      , 100)

    getNextId = (who) ->
      newId = 0
      key = 'workloadData-'+who+'-id'
      if _nextId[who]?
        newId = _nextId[who] + 1
      else
        newId = parseInt(localStorage.getItem(key) || '0') + 1
      _nextId[who] = newId
      $timeout(
        ->localStorage.setItem(key, newId)
      , 100)
      newId

    service =
      getPersons: getPersons
      setPersons: setPersons
      getTasks: getTasks
      setTasks: setTasks
      nextId: getNextId
      getPriorityMatrix: getPriorityMatrix
      setPriorityMatrix: setPriorityMatrix
