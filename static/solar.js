// In your existing solar.js
// Just adjust radius and sizes like below:

const canvas = document.getElementById("solar-bg");
const ctx = canvas.getContext("2d");

function resizeCanvas() {
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;
}
resizeCanvas();
window.addEventListener("resize", resizeCanvas);

let centerX, centerY;
function updateCenter() {
  centerX = canvas.width / 2;
  centerY = canvas.height / 2;
}
updateCenter();
const planets = [
  { radius: 120, size: 6, speed: 0.02, color: "#999" },     // Mercury
  { radius: 180, size: 9, speed: 0.015, color: "#f5b041" }, // Venus
  { radius: 240, size: 10, speed: 0.01, color: "#3c9ee7" }, // Earth
  { radius: 300, size: 8, speed: 0.008, color: "#c1440e" }, // Mars
];


let angle = 0;

function draw() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  updateCenter();

  // Draw Sun
  ctx.beginPath();
  ctx.arc(centerX, centerY, 20, 0, 2 * Math.PI);
  ctx.fillStyle = "#ffcc00";
  ctx.shadowColor = "#ff9900";
  ctx.shadowBlur = 15;
  ctx.fill();

  planets.forEach((planet, index) => {
    const planetAngle = angle * planet.speed + index;
    const x = centerX + planet.radius * Math.cos(planetAngle);
    const y = centerY + planet.radius * Math.sin(planetAngle);

    ctx.beginPath();
    ctx.arc(x, y, planet.size, 0, 2 * Math.PI);
    ctx.fillStyle = planet.color;
    ctx.shadowColor = planet.color;
    ctx.shadowBlur = 10;
    ctx.fill();
  });

  angle += 1;

  requestAnimationFrame(draw);
}
draw();