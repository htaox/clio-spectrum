

# angular.module('bannerApp').controller 'BannerController', ($scope) ->
# 
#   $scope.init = ->
#     $scope.banners = Banner.query();
#   
#   $scope.create = (bannerData) ->
#     banner = new Banner(bannerData)
#     $scope.banners.push(banner)
#   # $scope.create = function(bannerData) {
#   #   // alert('creating!');
#   #   banner = new Banner(bannerData);
#   #   $scope.banners.push(banner);
#   # }



  # $scope.init = ->        
  #   @listsService = new TaskList(serverErrorHandler)
  #   $scope.lists = @listsService.all()
  # 
  # $scope.createList = (name) ->
  #   @listsService.create name: name, (list) ->
  #       $location.url("/task_lists/#{list.id}")
  # 
  # $scope.deleteList = (list, index) ->
  #   result = confirm "Are you sure you want to remove this list?" 
  # 
  #   if result
  #     @listsService.delete list
  #     $scope.lists.splice index, 1
  # 
  # serverErrorHandler = ->
  #   alert("There was a server error, please reload the page and try again.")
