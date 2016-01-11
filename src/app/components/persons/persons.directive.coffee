angular.module 'workloadPlanner'
  .directive 'persons', ->
    'ngInject'

    PersonsController = (persons, $log, $translate, toastr) ->
      'ngInject'
      vm = this

      animeRef = 0
      newPerson = -> {
        firstName: undefined
        lastName: undefined
        _animeRef: animeRef++
      }

      add = ->
        vm.newPerson = newPerson()

      edit = (person) ->
        person._edit = true
        person._original = angular.copy(person)

      deletePerson = (person, confirmed = false) ->
        if confirmed
          vm.persons.splice(vm.persons.indexOf(person), 1)
        else
          person._delete = true

      save = () ->
        vm.persons.push(angular.copy(vm.newPerson))
        vm.newPerson = undefined
        vm.persons.sort ((a,b)-> a.firstName.toLowerCase() > b.firstName.toLowerCase())

      keyUp = ($event, person) ->
        if $event.keyCode == 13 then save()

      cancle = (person) ->
        person._edit = false
        person.firstName = person._original.firstName
        person.lastName = person._original.lastName
        delete person['_original']

      # PUBLIC
      vm.persons = persons.getPersons()
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