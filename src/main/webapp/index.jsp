<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="models.Results" %>
<%@ page import="models.Point" %>
<!DOCTYPE html>
<html lang="en-US">
<head>
    <title>eoeqs-web2</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <link rel="stylesheet" href="stylesheets/style.css">
    <script src='https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js'></script>

</head>

<body>

<div id="header">
    <header>
        Иванова Александра, Р3218, вариант 8849
    </header>
</div>
<table id="main-table">
    <tbody id="main">
    <tr>
        <td colspan="5">
            <hr>
        </td>
    </tr>
    <tr>
        <td id="content-graph" rowspan="6">
            <svg xmlns="http://www.w3.org/2000/svg" id="svg">
                <line x1="0" y1="150" x2="300" y2="150" stroke="black"></line>
                <line x1="150" y1="0" x2="150" y2="300" stroke="black"></line>

                <line x1="250" y1="145" x2="250" y2="155" stroke="black"></line>
                <line x1="200" y1="145" x2="200" y2="155" stroke="black"></line>
                <line x1="100" y1="145" x2="100" y2="155" stroke="black"></line>
                <line x1="50" y1="145" x2="50" y2="155" stroke="black"></line>

                <line x1="145" y1="50" x2="155" y2="50" stroke="black"></line>
                <line x1="145" y1="100" x2="155" y2="100" stroke="black"></line>
                <line x1="145" y1="200" x2="155" y2="200" stroke="black"></line>
                <line x1="145" y1="250" x2="155" y2="250" stroke="black"></line>

                <text x="245" y="140" stroke="black">R</text>
                <text x="185" y="140" stroke="black">R/2</text>
                <text x="77" y="140" stroke="black">-R/2</text>
                <text x="37" y="140" stroke="black">-R</text>
                <text x="156" y="55" stroke="black">R</text>
                <text x="156" y="105" stroke="black">R/2</text>
                <text x="156" y="205" stroke="black">-R/2</text>
                <text x="156" y="255" stroke="black">-R</text>
                <polygon points="300,150 295,155 295, 145" fill="black" stroke="black"></polygon>
                <polygon points="150,0 145,5 155,5" fill="black" stroke="black"></polygon>

                <rect x="100" y="50" width="50" height="100" fill-opacity="0.4" stroke="navy" fill="blue"></rect>
                <polygon points="150,150 150,200 200,150" fill-opacity="0.4" stroke="navy" fill="blue"></polygon>
                <path d="M 150 150 L 50 150 C 50 150 50 250 150 250 Z" fill-opacity="0.4" stroke="navy" fill="blue">
                </path>
            </svg>
        </td>
        <td>
            <div >
                <table class="form_">
                    <tr>
                        <td id="x-check" class="checkboxes">
                            <label>
                                X value:
                            </label>
                        </td>
                    <tr>
                        <td>

                                <input id="checkbox-1" type="checkbox" name="x-group" value="-4">
                                <label for="checkbox-1">-4</label>

                                <input id="checkbox-2" type="checkbox" name="x-group" value="-3">
                                <label for="checkbox-2">-3</label>

                                <input id="checkbox-3" type="checkbox" name="x-group" value="-2">
                                <label for="checkbox-3">-2</label>

                                <input id="checkbox-4" type="checkbox" name="x-group" value="-1">
                                <label for="checkbox-4">-1</label>

                                <input id="checkbox-5" type="checkbox" name="x-group" value="0">
                                <label for="checkbox-5">0</label>

                                <input id="checkbox-6" type="checkbox" name="x-group" value="1">
                                <label for="checkbox-6">1</label>

                                <input id="checkbox-7" type="checkbox" name="x-group" value="2">
                                <label for="checkbox-7">2</label>

                                <input id="checkbox-8" type="checkbox" name="x-group" value="3">
                                <label for="checkbox-8">3</label>

                                <input id="checkbox-9" type="checkbox" name="x-group" value="4">
                                <label for="checkbox-9">4</label>

                            <script>
                                const checkboxes = document.querySelectorAll('input[type="checkbox"]');

                                checkboxes.forEach((checkbox) => {
                                    checkbox.addEventListener('change', () => {
                                        checkboxes.forEach((otherCheckbox) => {
                                            if (otherCheckbox !== checkbox) {
                                                otherCheckbox.checked = false;
                                            }
                                        });
                                    });
                                });
                            </script>
                        </td>
                    </tr>


                    <tr>
                        <td class="y-text" id="yinput">
                            <label>
                                Y value:
                                <input id="y-text" name="Y-input" class="y-text-input" type="text"
                                       placeholder="(-3;5)"
                                       maxlength="10"
                                >
                            </label>
                        </td>
                    </tr>
                    <tr>
                        <td id="r-selector" class="selector">

                            <label for="r-select">R value:</label>
                            <select name="r-select" id="r-select">
                                <option name="coordinateR" value="1" selected>1</option>
                                <option name="coordinateR" value="2">2</option>
                                <option name="coordinateR" value="3">3</option>
                                <option name="coordinateR" value="4">4</option>
                                <option name="coordinateR" value="5">5</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                    <tr>
                        <td colspan="5">
                            <input type="submit" id="checkButton" value="Check">
                        </td>
                    </tr>
                </table>
            </div>

    </tr>
    </tbody>
    <tfoot>
    <td colspan="2">
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
            <tr id="result">
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
        </table>
    </td>

    </tfoot>
</table>


</body>

<script src="script.js"></script>

</html>