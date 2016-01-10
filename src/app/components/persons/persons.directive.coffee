angular.module 'workloadPlanner'
  .directive 'persons', ->
    'ngInject'

    PersonsController = (persons, $log, $translate, toastr) ->
      'ngInject'
      vm = this

      newPerson = -> {
        firstName: ''
        lastName: ''
        _edit: true
        _add: true
      }

      add = ->
        vm.persons.unshift(newPerson())

      edit = (person) ->
        person._edit = true
        person._original = angular.copy(person)

      deletePerson = ($index, person, confirmed = false) ->
        if confirmed
          vm.persons.splice($index, 1)
        else
          person._delete = true

      keyUp = ($event, $index, person) ->
        if $event.keyCode == 13 then person._edit = false

      cancle = ($index, person) ->
        if person._add
          vm.persons.splice($index, 1)
        else
          person._edit = false
          person.firstName = person._original.firstName
          person.lastName = person._original.lastName
          delete person['_original']

      # PUBLIC
      vm.persons = persons.getPersons()
      vm.add = add
      vm.edit = edit
      vm.delete = deletePerson
      vm.keyUp = keyUp
      vm.cancle = cancle
      return

    directive =
      restrict: 'E'
      templateUrl: 'app/components/persons/persons.html'
      controller: PersonsController
      controllerAs: 'vm'
