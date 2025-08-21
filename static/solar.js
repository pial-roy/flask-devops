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
  { radius: 120, size: 6, speed: 0.02, color: "#999" },        // Mercury
  { radius: 180, size: 9, speed: 0.015, color: "#f5b041" },    // Venus
  { radius: 240, size: 10, speed: 0.01, color: "#3c9ee7" },    // Earth
  { radius: 300, size: 8, speed: 0.008, color: "#c1440e" },    // Mars
  { radius: 400, size: 16, speed: 0.006, color: "#e2c290" },   // Jupiter
  { radius: 520, size: 14, speed: 0.004, color: "#d4af37", ring: true }, // Saturn with ring
  { radius: 650, size: 11, speed: 0.003, color: "#20c997" },   // Uranus
  { radius: 780, size: 11, speed: 0.0025, color: "#0077be" }   // Neptune
];

let angle = 0;

function draw() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  updateCenter();

  // Draw Sun
  ctx.beginPath();
  ctx.arc(centerX, centerY, 30, 0, 2 * Math.PI);
  ctx.fillStyle = "#ffcc00";
  ctx.shadowColor = "#ff9900";
  ctx.shadowBlur = 20;
  ctx.fill();

  planets.forEach((planet, index) => {
    const planetAngle = angle * planet.speed + index;
    const x = centerX + planet.radius * Math.cos(planetAngle);
    const y = centerY + planet.radius * Math.sin(planetAngle);

    // Draw ring for Saturn
    if (planet.ring) {
      ctx.beginPath();
      ctx.ellipse(x, y, planet.size + 10, planet.size + 3, 0, 0, 2 * Math.PI);
      ctx.strokeStyle = "rgba(255,255,255,0.3)";
      ctx.lineWidth = 2;
      ctx.stroke();
    }

    // Draw planet
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