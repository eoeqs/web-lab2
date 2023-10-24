let x, y, r;
let svg = document.getElementById("svg");

function drawPoint(x, y, r, result) {
    let circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
    circle.setAttribute("cx", x * (100) / r + 150);
    circle.setAttribute("cy", -y * (100) / r + 150);
    circle.setAttribute("r", 3);
    circle.style.fill = result ? "green" : "red";
    svg.appendChild(circle);
}


function transformSvgToPlane(svgX, svgY, r) {
    console.log(svgX,svgY)
    let planeX = (svgX - 150) / (100 / r);

    let planeY = (150 - svgY) / (100 / r);
    console.log(planeX, planeY)
    return {x: planeX, y: planeY};
}

function addToTable(x, y, r, result) {
    const table = document.getElementById("outputTable");
    const newRow = table.insertRow();
    newRow.insertCell().innerText = x;
    newRow.insertCell().innerText = y;
    newRow.insertCell().innerText = r;
    newRow.insertCell().innerHTML = result
        ? "<span class=\"success\">Hit</span>"
        : "<span class=\"fail\">Miss</span>";
}


async function checkPoint(x, y, r) {
    const form = new FormData();
    form.append("X", x);
    form.append("Y", y);
    form.append("R", r);
    form.append("action", "checkPoint")

    const url = "ControllerServlet?" + new URLSearchParams(form).toString();
    const response = await fetch(url, {method: "post"});

    if (!response.ok) {
        alert("Unable to send data");
    }

    const data = response.json();
    if (data.error) alert(data.error);

    return data;
}

async function sendCoordinates(x, y, r) {
    const data = await checkPoint(x, y, r);
    if (!data.error) {
        drawPoint(x, y, r, data.result);
        addToTable(x, y, r, data.result);
    }
}


document.addEventListener("DOMContentLoaded", () => {
    const table = document.getElementById("outputTable");
    const svg = document.getElementById("svg");

    if (table) {

        for (let item of table.rows) {
            const x = parseFloat(item.children[0].innerText.trim());
            const y = parseFloat(item.children[1].innerText.trim());
            const r = parseFloat(item.children[2].innerText.trim());


            if (isNaN(x) || isNaN(y) || isNaN(r)) continue;


            const result = item.children[3].innerText.trim() === "Hit";
            drawPoint(x, y, r, result);
        }
    }
    svg.addEventListener("click", (event) => {
        if (validateR()) {
            let point = svg.createSVGPoint();
            point.x = event.clientX;
            point.y = event.clientY;


            const svgPoint = point.matrixTransform(svg.getScreenCTM().inverse());
            let planeCoords = transformSvgToPlane(svgPoint.x, svgPoint.y, r);
            console.log(planeCoords)
            sendCoordinates(
                planeCoords.x.toFixed(1),
                planeCoords.y.toFixed(1),
                r
            );
        }

    });

    let buttons = document.querySelectorAll('input[name="x-group"]');
    buttons.forEach((button) => {
        button.onclick = function () {
            x = this.value;
        };
    });
});


document.getElementById("checkButton").onclick = function () {

    if (validateX() && validateY() && validateR()) {
        const form = $('<form>',{
            method: "POST",
            action: "ControllerServlet"
        });
        const args = { action: "submitForm",
            X: x, Y: y, R: r
        };
        Object.entries(args).forEach(entry => {
            const [key, value] = entry;
            $('<input>').attr({
                type: "hidden",
                name: key,
                value: value
            }).appendTo(form);
        });

        form.appendTo('body').submit()


    }
};

function validateX() {
    try {
        x = document.querySelector("input[type=checkbox]:checked").value;
        return true;
    } catch (err) {
        alert("The X value is not selected");
        return false;
    }
}

function validateY() {
    y = document.querySelector("input[name=Y-input]").value.replace(",", ".");
    if (y === "") {
        alert("The y parameter is not entered");
        return false;
    } else if (y === "+0" || y === "-0") {
        alert("Zero cannot have a sign");
        return false;
    } else if (!isNumeric(y)) {
        alert("Y is not a number");
        return false;
    } else if (!((y > -5) && (y < 5))) {
        alert("The Y value is not within the scope of acceptable values");
        return false;
    } else return true;
}

function validateR() {
    r = document.getElementById("r-select").value;
    if (r === "") {
        alert("R value is not selected");
        return false;
    } else return true;

}

function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}


