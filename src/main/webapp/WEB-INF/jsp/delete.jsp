<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/bbUI" prefix="bbUI" %>
<%@ taglib uri="/bbNG" prefix="bbNG" %>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="bbng" uri="/bbNG" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:message var="title" key="bond.menu.config.edit.title" />
<fmt:message var="menuItemHtmlLabel" key="bond.menu.config.edit.menuItemHtml" />
<fmt:message var="menuItemKeyLabel" key="bond.menu.config.edit.menuItemKey" />
<fmt:message var="confirmDeleteLabel" key="bond.menu.config.delete.confirm" />

<bbNG:genericPage bodyClass="normalBackground"
                  navItem="bond-menu-app-nav-menuconfig">

    <stripes:form beanclass="au.edu.bond.menu.stripes.ConfigAction">
        <input type="hidden" name="confirmDelete"/>

        <bbNG:dataCollection>
            <bbNG:step title="${title}">
                <bbNG:dataElement isRequired="true" label="${menuItemKeyLabel}">
                    ${actionBean.menuItem}
                    <stripes:hidden name="menuItem"/>
                </bbNG:dataElement>
                <bbNG:dataElement isRequired="true" label="${menuItemHtmlLabel}">
                    <c:out value="${actionBean.menuItemHtml}" />
                </bbNG:dataElement>
            </bbNG:step>
            <bbNG:stepSubmit cancelUrl="Config.action">
                <bbNG:stepSubmitButton label="${confirmDeleteLabel}" />
            </bbNG:stepSubmit>
        </bbNG:dataCollection>
    </stripes:form>

</bbNG:genericPage>
