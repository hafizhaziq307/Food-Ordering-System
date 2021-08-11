<%-- 
    Document   : header
    Created on : May 21, 2020, 8:37:49 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!-- for view victuals manager -->
        <form action="../VictualsServlet">
            <input type="text" name="option" value="LIST" >
            <button type="submit">View Victuals</button>
        </form>
        
    </body>
</html>
