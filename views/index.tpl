<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="/static/styles/default.css">
    <script src="/static/js/raphael.js"></script>
    <script src="/static/js/colorpicker.js"></script>
    <script src="/static/js/colorwheel.js"></script>
    <script src="/static/js/jquery.min.js"></script>
    <script>
    Raphael(function () {
      var out = document.getElementById("output")
      var vr = document.getElementById("vr")
      var vg = document.getElementById("vg")
      var vb = document.getElementById("vb")
      var vh = document.getElementById("vh")
      var vh2 = document.getElementById("vh2")
      var vs = document.getElementById("vs")
      var vs2 = document.getElementById("vs2")
      var vv = document.getElementById("vv")
      var vl = document.getElementById("vl")
      var colorpicker = Raphael.colorpicker(40, 20, 300, "#eee")
      var colorwheel = Raphael.colorwheel(360, 20, 300, "#eee")
      var color = Raphael.color("#eee")

      vr.innerHTML = color.r
      vg.innerHTML = color.g
      vb.innerHTML = color.b

      vh.innerHTML = vh2.innerHTML = Math.round(color.h * 360) + "°"
      vs.innerHTML = vs2.innerHTML = Math.round(color.s * 100) + "%"
      vv.innerHTML = Math.round(color.v * 100) + "%"
      vl.innerHTML = Math.round(color.l * 100) + "%"

      out.onkeyup = function () {
        colorpicker.color(this.value)
        colorwheel.color(this.value)
      }

      var onchange = function (item) {
        return function (color) {
          out.value = color.replace(/^#(.)\1(.)\2(.)\3$/, "#$1$2$3")

          item.color(color)
          out.style.background = color
          out.style.color = Raphael.rgb2hsb(color).b < .5 ? "#fff" : "#000"
          color = Raphael.color(color)

          vr.innerHTML = color.r
          vg.innerHTML = color.g
          vb.innerHTML = color.b

          vh.innerHTML = vh2.innerHTML = Math.round(color.h * 360) + "°"
          vs.innerHTML = vs2.innerHTML = Math.round(color.s * 100) + "%"
          vv.innerHTML = Math.round(color.v * 100) + "%"
          vl.innerHTML = Math.round(color.l * 100) + "%"

          $.ajax({
            url : '/color/' + (((color.r & 0x0ff) << 16) | ((color.g & 0x0ff) << 8) | (color.b & 0x0ff))
          })
        }
      }

      colorpicker.onchange = onchange(colorwheel)
      colorwheel.onchange = onchange(colorpicker)
    })
    </script>
  </head>
  <body>
    <div id="content">
      <table id="values">
        <tr>
          <th>R</th>
          <td id="vr"></td>
          <th>H</th>
          <td id="vh"></td>
          <th>H</th>
          <td id="vh2"></td>
        </tr>
        <tr>
          <th>G</th>
          <td id="vg"></td>
          <th>S</th>
          <td id="vs"></td>
          <th>S</th>
          <td id="vs2"></td>
        </tr>
        <tr>
          <th>B</th>
          <td id="vb"></td>
          <th>B</th>
          <td id="vv"></td>
          <th>L</th>
          <td id="vl"></td>
        </tr>
      </table>
      <input type="text" id="output" value="#eeeeee">
      <p id="copy">
        Powered by <a href="http://raphaeljs.com/">Raphaël</a>
      </p>
    </div>
    <div id="picker"></div>
  </body>
</html>

