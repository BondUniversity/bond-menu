package au.edu.bond.menu.stripes;

import au.edu.bond.menu.config.Configuration;
import com.alltheducks.bb.stripes.EntitlementRestrictions;
import net.sourceforge.stripes.action.*;
import net.sourceforge.stripes.controller.LifecycleStage;
import com.alltheducks.configutils.service.ConfigurationService;
import net.sourceforge.stripes.integration.spring.SpringBean;

import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

@EntitlementRestrictions(entitlements={"bond.menu.admin.MODIFY"}, errorPage="/noaccess.jsp")
public class ConfigAction implements ActionBean {

    private ActionBeanContext context;

//    @ValidateNestedProperties({@Validate(field = "settingOne", required = true),
//            @Validate(field = "settingTwo", required = true, minvalue = 0, maxvalue = 100)})
    private Configuration config;

    @SpringBean
    private ConfigurationService<Configuration> configService;
    private String menuItem;
    private String menuItemHtml;

    @Before(stages = LifecycleStage.BindingAndValidation)
    public void loadConfiguration() {
        config = configService.loadConfiguration();
        if (config == null) {
            config = new Configuration();
        }
        if(config.getMenuItems() == null) {
            config.setMenuItems(new HashMap<String, String>());
        }
    }


    @DefaultHandler
    @DontValidate
    public Resolution list() {
        return new ForwardResolution("/WEB-INF/jsp/list.jsp");
    }

    public Resolution edit() {
        menuItemHtml = config.getMenuItems().get(menuItem);
        return new ForwardResolution("/WEB-INF/jsp/edit.jsp");
    }

    public Resolution add() {
        return new ForwardResolution("/WEB-INF/jsp/edit.jsp");
    }

    public Resolution save() {
        config.getMenuItems().put(menuItem, menuItemHtml);
        configService.persistConfiguration(config);
        return new RedirectResolution("/Config.action", true);
    }

    public Resolution delete() {
        menuItemHtml = config.getMenuItems().get(menuItem);
        return new ForwardResolution("/WEB-INF/jsp/delete.jsp");
    }

    public Resolution confirmDelete() {
        config.getMenuItems().remove(menuItem);
        configService.persistConfiguration(config);
        return new RedirectResolution("/Config.action", true);
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    public Configuration getConfig() {
        return config;
    }

    public void setConfig(Configuration config) {
        this.config = config;
    }

    public String getMenuItem() {
        return menuItem;
    }

    public void setMenuItem(String menuItem) {
        this.menuItem = menuItem;
    }

    public String getMenuItemHtml() {
        return menuItemHtml;
    }

    public void setMenuItemHtml(String menuItemHtml) {
        this.menuItemHtml = menuItemHtml;
    }

    public Comparator<Map.Entry<String, String>> getTitleComparator() {
        return new KeyComparator();
    }

    public class KeyComparator implements Comparator<Map.Entry<String, String>> {
        @Override
        public int compare(Map.Entry<String, String> o1, Map.Entry<String, String> o2) {
            return o1.getKey().compareToIgnoreCase(o2.getKey());
        }
    }
}
