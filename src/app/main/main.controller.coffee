angular.module 'workloadPlanner'
  .controller 'MainController', ($timeout, webDevTec, toastr, $log) ->
    'ngInject'
    vm = this
    activate = ->
      getWebDevTec()
      $timeout (->
        vm.classAnimation = 'rubberBand'
        return
      ), 4000
      return

    showToastr = ->
      toastr.info 'Fork <a href="https://github.com/Swiip/generator-gulp-angular" target="_blank"><b>generator-gulp-angular</b></a>'
      vm.classAnimation = ''
      return

    getWebDevTec = ->
      vm.awesomeThings = webDevTec.getTec()
      angular.forEach vm.awesomeThings, (awesomeThing) ->
        awesomeThing.rank = Math.random()
        return
      return

    vm.awesomeThings = []
    vm.classAnimation = ''
    vm.creationDate = 1451903816692
    vm.showToastr = showToastr
    activate()
    
    vm.things = [{name:'one'}, {name:'two'}, {name:'three'}, {name:'four'}]
    vm.remove = ($index, elem)->
      $log.log 'elem', elem
      elem._deleted = true
      # angular.element('#yourElement').addClass('fadeOut')
      vm.things.splice($index, 1)
      return
    return
