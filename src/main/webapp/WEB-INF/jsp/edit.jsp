<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/bbUI" prefix="bbUI" %>
<%@ taglib uri="/bbNG" prefix="bbNG" %>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes-dynattr.tld" %>
<%@ taglib prefix="bbng" uri="/bbNG" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:message var="title" key="bond.menu.config.edit.title" />
<fmt:message var="menuItemHtmlLabel" key="bond.menu.config.edit.menuItemHtml" />
<fmt:message var="menuItemKeyLabel" key="bond.menu.config.edit.menuItemKey" />

<bbNG:genericPage bodyClass="normalBackground"
                  navItem="bond-menu-app-nav-menuconfig">
    <bbNG:cssFile href="css/bond-menu-config.css" />

    <stripes:form beanclass="au.edu.bond.menu.stripes.ConfigAction">
        <input type="hidden" name="save"/>

        <bbNG:dataCollection>
            <bbNG:step title="${title}">
                <bbNG:dataElement isRequired="true" label="${menuItemKeyLabel}">
                    <c:choose>
                        <c:when test="${empty actionBean.menuItem}">
                            <stripes:text name="menuItem" />
                        </c:when>
                        <c:otherwise>
                            ${actionBean.menuItem}
                            <stripes:hidden name="menuItem"/>
                        </c:otherwise>
                    </c:choose>
                </bbNG:dataElement>
                <bbNG:dataElement isRequired="true" label="${menuItemHtmlLabel}">
                    <stripes:textarea name="menuItemHtml" id="bond-menu-item-html" />
                </bbNG:dataElement>
            </bbNG:step>
            <bbNG:stepSubmit cancelUrl="Config.action" />
        </bbNG:dataCollection>
    </stripes:form>

</bbNG:genericPage>
