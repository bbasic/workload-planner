angular.module 'workloadPlanner'
  .service 'persons', () ->
    'ngInject'

    dataEx = [
      {
        firstName: 'Becir'
        lastName: 'Basic'
      },
      {
        firstName: 'Petra'
        lastName: 'Zakall'
      }
    ]

    getPersons = () -> dataEx

    service =
      getPersons: getPersons
