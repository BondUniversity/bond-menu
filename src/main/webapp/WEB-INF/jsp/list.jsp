<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/bbUI" prefix="bbUI" %>
<%@ taglib uri="/bbNG" prefix="bbNG" %>
<%@ taglib prefix="stripes" uri="http://stripes.sourceforge.net/stripes.tld" %>
<%@ taglib prefix="bbng" uri="/bbNG" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<fmt:message var="addLabel" key="bond.menu.config.list.addLabel" />
<fmt:message var="keyColumnLabel" key="bond.menu.config.list.keyColumn" />
<fmt:message var="editColumnLabel" key="bond.menu.config.list.editColumn" />
<fmt:message var="deleteColumnLabel" key="bond.menu.config.list.deleteColumn" />
<fmt:message var="emptyMsg" key="bond.menu.config.list.empty" />

<bbNG:genericPage bodyClass="normalBackground"
                  navItem="bond-menu-app-nav-menuconfig">

    <bbNG:actionControlBar showWhenEmpty="true">
        <bbNG:actionButton title="${addLabel}" url="Config.action?add" primary="true" />
    </bbNG:actionControlBar>

    <bbNG:pagedList collection="${actionBean.config.menuItems.entrySet()}" className="java.util.Map.Entry" objectVar="menuItem"
                    recordCount="${actionBean.config.menuItems.entrySet().size()}" displayPagingControls="false"
                    emptyMsg="${emptyMsg}" initialSortCol="key">

        <c:url value="Config.action" var="editUrl">
            <c:param name="edit" />
            <c:param name="menuItem" value="${menuItem.key}" />
        </c:url>
        <c:url value="Config.action" var="deleteUrl">
            <c:param name="delete" />
            <c:param name="menuItem" value="${menuItem.key}" />
        </c:url>

        <bbNG:listElement name="key" isRowHeader="true" label="${keyColumnLabel}" comparator="${actionBean.titleComparator}">${menuItem.key}</bbNG:listElement>
        <bbNG:listElement name="edit" label="${editColumnLabel}" ><a href="${editUrl}">Edit</a></bbNG:listElement>
        <bbNG:listElement name="delete" label="${deleteColumnLabel}" ><a href="${deleteUrl}">Delete</a></bbNG:listElement>

    </bbNG:pagedList>-

</bbNG:genericPage>
