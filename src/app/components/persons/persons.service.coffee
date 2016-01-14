angular.module 'workloadPlanner'
  .service 'persons', (workloadData) ->
    'ngInject'

    persons = undefined
    
    getData = () ->
      persons = workloadData.getPersons()
      return persons

    dataUpdated = -> workloadData.setPersons(persons)
      
    service =
      getData: getData
      dataUpdated: dataUpdated
