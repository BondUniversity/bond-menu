function setupBondMenu() {
  var menu = $("bond-menu");
  var globalNav = $("globalNavPageNavArea");
  globalNav.insert({ after: menu });

  var hideStack = [];
  var timerId = null;

  var show = function(menuItem) {
    if(timerId != null) {
      window.clearTimeout(timerId);
      timerId = null;
    }
    while(hideItem = hideStack.pop()) {
      if(hideItem != menuItem) {
        hideItem.removeClassName("bond-menu-container-show");
      }
    }
    menuItem.addClassName("bond-menu-container-show");
  };

  var hideQueued = function() {
    while (hideItem = hideStack.pop()) {
      hideItem.removeClassName("bond-menu-container-show");
    }
  };

  var hide = function(menuItem) {
    hideStack.push(menuItem);
    timerId = hideQueued.delay(0.3);

  };

  var tabs = $$("#appTabList td");
  tabs.each(function(tab) {
    var menuItemId = tab.id
        .replace(/\.label$/i, "")
        .replace(/[^a-z0-9]+/i, "");
    menuItemId = menuItemId + "Menu";
    var menuItem = $(menuItemId);

    if(menuItem != null) {
      var over = show.curry(menuItem);
      var out = hide.curry(menuItem);

      tab.observe('mouseover', over);
      menuItem.observe('mouseover', over);

      tab.observe('mouseout', out);
      menuItem.observe('mouseout', out);
    }
  });
}