angular.module 'workloadPlanner'
  .directive 'persons', ->
    'ngInject'

    PersonsController = (persons, $log, $translate, toastr) ->
      'ngInject'
      vm = this

      add = ->
        vm.newPerson = persons.newPerson()

      edit = (person) ->
        person._edit = true
        person._original = angular.copy(person)

      deletePerson = (person, confirmed = false) ->
        if confirmed
          vm.persons.splice(vm.persons.indexOf(person), 1)
          person._deleted = true
          persons.dataUpdated(person)
        else
          person._delete = true

      save = (person = undefined) ->
        if person?._edit
          person._edit = false
          persons.dataUpdated()
        else
          person = angular.copy(vm.newPerson)
          vm.newPerson = undefined
          vm.persons.push(person)
          vm.persons.sort ((a,b)-> a.firstName.toLowerCase() > b.firstName.toLowerCase())
          person._added = true
          persons.dataUpdated(person)

      keyUp = ($event, person) ->
        if $event.keyCode == 13 && person.firstName then save(person)

      cancle = (person) ->
        person._edit = false
        person.firstName = person._original.firstName
        person.lastName = person._original.lastName
        delete person['_original']

      # PUBLIC
      vm.persons = persons.getData().sort ((a,b)-> a.firstName.toLowerCase() > b.firstName.toLowerCase())
      vm.newPerson = undefined
      vm.add = add
      vm.edit = edit
      vm.delete = deletePerson
      vm.save = save
      vm.keyUp = keyUp
      vm.cancle = cancle

      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/persons/persons.html'
      controller: PersonsController
      controllerAs: 'vm'
