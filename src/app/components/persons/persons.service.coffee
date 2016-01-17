angular.module 'workloadPlanner'
  .service 'persons', (workloadData, $log) ->
    'ngInject'

    persons = undefined

    getData = () ->
      persons = workloadData.getPersons()
      return persons

    getDataAsMap = ->
      ps = if persons? then persons else workloadData.getPersons()
      result = {}
      for p in ps
        result[p.id] = p
      return result

    dataUpdated = (person) -> workloadData.setPersons(persons, person)

    newPerson = ->
      {
        id: 'p-'+workloadData.nextId('person')
        firstName: undefined
        lastName: undefined
      }

    service =
      getData: getData
      getDataAsMap: getDataAsMap
      dataUpdated: dataUpdated
      newPerson: newPerson
