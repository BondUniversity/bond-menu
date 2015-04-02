<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="/bbNG" prefix="bbNG"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<fmt:message var="title" key="bond.menu.noAccessPage.title" />
<fmt:message var="noAccessMessage" key="bond.menu.noAccessPage.noAccessMessage" />

<bbNG:learningSystemPage title="${title}" ctxId="ctx" >
  <bbNG:pageHeader >
    <bbNG:breadcrumbBar >
      <bbNG:breadcrumb title="${title}"/>
    </bbNG:breadcrumbBar>
    <bbNG:pageTitleBar title="${title}" />
  </bbNG:pageHeader>
  ${noAccessMessage}
</bbNG:learningSystemPage>