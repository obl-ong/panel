angular.module('starter', ['ionic', 'ionic.contrib.ui.tinderCards'])

.directive('noScroll', function($document) {

    return {
      restrict: 'A',
      link: function($scope, $element, $attr) {
  
        $document.on('touchmove', function(e) {
          e.preventDefault();
        });
      }
    }
  })

  .controller('CardsCtrl', function($scope, TDCardDelegate) {
  console.log('CARDS CTRL');
  var cardTypes = JSON.parse(document.querySelector("main.admin").getAttribute("domains"))

  $scope.cards = Array.prototype.slice.call(cardTypes, 0);

  let currentCard = null

  $scope.cardDestroyed = async function(index) {
    if (currentCard != null) {
      $scope.cards.splice(index, 1);
      console.log(currentCard.action)
    } else {
      currentCard = $scope.cards[index];
      $scope.cards.push(angular.extend({}, currentCard));
    }

    if(currentCard.action == "dontDestroy") {
      $scope.cards.push(angular.extend({}, currentCard));
      currentCard = null;
    } else if (currentCard.action == "accept") {
      document.querySelector(`form#form-${currentCard.domain_id} .action-field`).value = "accept";
      document.querySelector(`form#form-${currentCard.domain_id}`).submit()

      Toastify({
        text: `${currentCard.host} was accepted`,
        duration: 3000,
        newWindow: true,
        close: true,
        gravity: "bottom", // `top` or `bottom`
        position: "center", // `left`, `center` or `right`
        style: {
          background: "#41EAD4;"
        }
      }).showToast();
      currentCard = null;
    } else if(currentCard.action == "reject") {
      document.querySelector(`form#form-${currentCard.domain_id} .action-field`).value = "reject";
      document.querySelector(`form#form-${currentCard.domain_id}`).submit()

      Toastify({
        text: `${currentCard.host} was rejected`,
        duration: 3000,
        newWindow: true,
        close: true,
        gravity: "bottom", // `top` or `bottom`
        position: "center", // `left`, `center` or `right`
        style: {
          background: "var(--winter-sky);"
        }
      }).showToast();
      currentCard = null;
    }
  };

  $scope.addCard = function() {
    var newCard = cardTypes[Math.floor(Math.random() * cardTypes.length)];
    newCard.id = Math.random();
    $scope.cards.push(angular.extend({}, newCard));
  }

  $scope.cardSwipedLeft = function(index) {
    
    currentCard = structuredClone($scope.cards[index]);

    if(window.confirm(`Are you sure you want to reject ${$scope.cards[index].host}?`)) {
      currentCard.action = "reject"
    } else {
      currentCard.action = "dontDestroy"
    }
  };

  $scope.cardSwipedRight = function(index) {
    currentCard = structuredClone($scope.cards[index]);
    currentCard.action = "accept";
  };  
})

  .controller('CardCtrl', function($scope, TDCardDelegate) {});
