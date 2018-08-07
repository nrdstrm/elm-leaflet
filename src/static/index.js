import "../../node_modules/leaflet/dist/leaflet.css";
import "../../node_modules/leaflet/dist/leaflet.js";

var Elm = require("../elm/Main");
var app = Elm.Main.embed(document.getElementById("main"));

app.ports.initializeMap.subscribe(function (pos) {
    console.log("rx: initializeMap", {
        pos,
    });

    var map = L.map("map").setView([pos.lat, pos.lng], 11);

    L.tileLayer("http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
        attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a>',
    }).addTo(map);
});
