function setupBondMenu() {
  var menu = $("bond-menu");
  var globalNav = $("globalNavPageNavArea");
  globalNav.insert({ after: menu });

  var currentMenuItem = null;

  var over = function(menuItem) {
    if(currentMenuItem != menuItem) {
      if(currentMenuItem != null) {
        currentMenuItem.removeClassName("bond-menu-container-show");
      }
      menuItem.addClassName("bond-menu-container-show");
      currentMenuItem = menuItem;
    }
  };

  var out = function(menuItem) {
    var hide = function() {
      if(currentMenuItem != menuItem) {
        menuItem.removeClassName("bond-menu-container-show");
      }
    };
    hide.delay(0.3);
    currentMenuItem = null;
  }

  var tabs = $$("#appTabList td");
  tabs.each(function(tab) {
    var menuItemId = tab.id.replace(/\.label$/i, "Menu");
    var menuItem = $(menuItemId);

    if(menuItem != null) {
      var miover = over.curry(menuItem);
      var miout = out.curry(menuItem);

      tab.observe('mouseover', miover);
      menuItem.observe('mouseover', miover);

      tab.observe('mouseout', miout);
      menuItem.observe('mouseout', miout);
    }
  });
}