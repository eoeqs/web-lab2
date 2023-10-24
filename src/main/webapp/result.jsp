<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Results" %>
<%@ page import="models.Point" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="stylesheets/style.css" rel="stylesheet">
    <title>results</title>
</head>

<body>
<div id="header">
    <header>
        Иванова Александра, Р3218, вариант 8849
    </header>
</div>

<table id="mainTable" style="width: 50%" >
    <thead>
    <td colspan="5">
        <hr>
        <h3 style="text-align: center">Results:</h3>

    </td>
    </thead>

    <tbody >
    <tr>
        <td colspan="5"><hr></td>
    </tr>
    <tr >
        <td colspan="5" id="outputContainer" >
            <table class="frontTables">
                    <% Results res = (Results) request.getSession().getAttribute("results");
                if (res == null) {
            %>

                <table id="outputTable">
                    <tr>
                        <th>X</th>
                        <th>Y</th>
                        <th>R</th>
                        <th>Result</th>
                    </tr>
                </table>
                    <% } else { %>
                <table id="outputTable">
                    <tr>
                        <th>X</th>
                        <th>Y</th>
                        <th>R</th>
                        <th>Result</th>
                    </tr>
                    <% for (Point point : res.getPoints()) { %>
                    <tr>
                        <td>
                            <%= point.getX() %>
                        </td>
                        <td>
                            <%= point.getY() %>
                        </td>
                        <td>
                            <%= point.getR() %>
                        </td>
                        <td>
                            <%= point.isHit() ? "<span class=\"success\">Hit</span>"
                                    : "<span class=\"fail\">Miss</span>" %>
                        </td>
                    </tr>
                    <% } %>
                </table>
                    <% } %>
        </td>
    </tr>
    <tr>
        <td>
            <div id="goBack">
                <a href="index.jsp">Back</a>
            </div>
        </td>
    </tr>

    </tbody>

    <tfoot>
        </tfoot>

</table>

<script src="script.js"></script>
</body>

</html>
