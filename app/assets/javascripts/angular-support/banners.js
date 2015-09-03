

// plain old JS

var bannerApp = angular.module("bannerApp", ['ngResource', 'ngSanitize']);

bannerApp.factory('Banner', function($resource) {
  return $resource('api/banners/:id', {id: "@id"},  {'update': { method:'PUT' }});
});

bannerApp.controller("BannerController", function ($scope, Banner, $sce) {

  $scope.banners = Banner.query();

  $scope.create = function(bannerData) { 
    banner = new Banner(bannerData);
    $scope.banners.push(banner);
    banner.$save()
  };

  $scope.destroy = function(banner) { 
    banner.$delete(function(){
      $scope.banners = Banner.query();
    });
  }

  $scope.update = function(banner) { 
    banner.$update();
  }

  $scope.color2class = color2class;

  // $scope.color2class = function(color) {
  //   switch(color) {
  //     case 'green':
  //       return 'alert-success';
  //       // break;
  //     case 'blue':
  //       return 'alert-info';
  //       // break;
  //     case 'yellow':
  //       return 'alert-warning';
  //       // break;
  //     case 'red':
  //       return 'alert-danger';
  //       // break;
  //     default:
  //       return 'alert-warning';
  //   };
  // };
  
  // $scope.icon2html = icon2html;
  // $scope.icon2html = function (icon) {
  //   style = " style='font-size:120%;padding-right:0.25em;' ";
  //   return "<span class='glyphicon.glyphicon-" + icon + "' " + style + "/>";
  // }

});

// Remember to return HTML - not HAML
function icon2html(icon) {
  style = " style='font-size:120%;padding-right:0.25em;' ";
  return "<span class='glyphicon.glyphicon-" + icon + "' " + style + "/>";
}

function color2class(color) 
{
  switch(color) {
    case 'green':
      return 'alert-success';
    case 'blue':
      return 'alert-info';
    case 'yellow':
      return 'alert-warning';
    case 'red':
      return 'alert-danger';
    default:
      return 'alert-warning';
  }
};