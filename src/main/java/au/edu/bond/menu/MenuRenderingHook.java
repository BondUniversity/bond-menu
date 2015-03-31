package au.edu.bond.menu;

import au.edu.bond.menu.config.Configuration;
import blackboard.platform.context.Context;
import blackboard.platform.context.ContextManagerFactory;
import blackboard.servlet.renderinghook.RenderingHook;
import com.alltheducks.configutils.service.ConfigurationService;
import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;
import org.apache.velocity.runtime.RuntimeConstants;
import org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import java.io.StringWriter;

/**
 * Created by shane on 31/03/15.
 */
public class MenuRenderingHook implements RenderingHook {
    final Logger logger = LoggerFactory.getLogger(MenuRenderingHook.class);

    private ConfigurationService<Configuration> configurationService;

    private Template template;

    @SuppressWarnings("unchecked")
    public MenuRenderingHook() {
        Context context = ContextManagerFactory.getInstance().getContext();
        final ServletContext wizardContext = context.getHttpSession().getServletContext().getContext(PluginHelper.URL_STUB);
        final WebApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(wizardContext);

        configurationService = springContext.getBean("configurationService", ConfigurationService.class);

        VelocityEngine velocityEngine = createVelocityEngine();
        template = velocityEngine.getTemplate("template.vm");
    }

    private VelocityEngine createVelocityEngine() {
        VelocityEngine velocityEngine = new VelocityEngine();
        velocityEngine.setProperty(RuntimeConstants.RUNTIME_LOG_LOGSYSTEM_CLASS, Slf4jLogChute.class.getName());
        velocityEngine.setProperty(RuntimeConstants.RESOURCE_LOADER, "classpath");
        velocityEngine.setProperty("classpath.resource.loader.class", ClasspathResourceLoader.class.getName());
        velocityEngine.init();
        return velocityEngine;
    }

    @Override
    public String getKey() {
        return "tags.globalNavPage.start";
    }

    @Override
    public String getContent() {
        final Configuration configuration = configurationService.loadConfiguration();

        final VelocityContext velocityContext = new VelocityContext();

        velocityContext.put("menuItems", configuration.getMenuItems());
        velocityContext.put("urlStub", PluginHelper.URL_STUB);

        StringWriter writer = new StringWriter();
        template.merge(velocityContext, writer);

        return writer.toString();
    }

}
