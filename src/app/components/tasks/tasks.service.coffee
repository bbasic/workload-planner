angular.module 'workloadPlanner'
  .service 'tasks', () ->
    'ngInject'

    dataEx = [
      {
        taskName: 'Wäsche waschen'
        activeDays: [ false, true, false, true, true, false, true ]
      },
      {
        taskName: 'Saugen'
        activeDays: [ true, false, true, true, true, true, false ]
      }
    ]

    getTasks = () -> dataEx

    service =
      getTasks: getTasks
