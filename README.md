<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Whatmore Industries</title>
  <style>
    html, body {
      margin: 0;
      padding: 0;
      font-family: 'Segoe UI', sans-serif;
      background: #111;
      color: #eee;
      height: 100%;
      line-height: 1.6;
      box-sizing: border-box;
    }
    *, *::before, *::after {
      box-sizing: inherit;
    }
    #particles-js {
      position: fixed;
      width: 100%;
      height: 100%;
      z-index: -1;
    }
    header {
      background: transparent;
      text-align: center;
      padding: 3rem 1rem 2rem;
      position: relative;
      z-index: 1;
    }
    nav {
      display: flex;
      justify-content: center;
      gap: 2rem;
      background: rgba(34, 34, 34, 0.9);
      padding: 0.5rem;
      position: sticky;
      top: 0;
      z-index: 10;
    }
    nav a {
      color: #fff;
      text-decoration: none;
    }
    nav a:hover {
      text-decoration: underline;
    }
    main {
      padding: 2rem 1rem;
      position: relative;
      z-index: 1;
    }
    section {
      margin-bottom: 3rem;
    }
    footer {
      background: #1e1e1e;
      text-align: center;
      padding: 1rem;
      font-size: 0.9rem;
      color: #666;
    }
    .grid {
      display: grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 20px;
      padding: 30px;
      max-width: 100%;
    }
    video {
      width: 100%;
      height: auto;
      border: 2px solid #333;
      border-radius: 18px;
      background: #111;
    }
    .video-container {
  position: relative;
  transition: transform 0.3s ease, z-index 0.3s;
  z-index: 1;
  cursor: pointer;
}
.video-container.zoomed {
  transform: scale(2.5); /* Adjust to your preferred zoom level */
  z-index: 999;
}
    .card {
  background: #222;
  padding: 1rem;
  border-radius: 12px;
  text-align: center;
  transition: background 0.3s;
}
.card:hover {
  background: #333;
}
    @media (max-width: 600px) {
      nav {
        flex-wrap: wrap;
        gap: 1rem;
      }
    }
  </style>
</head>
<body>
  <div id="particles-js"></div>

  <header>
    <h1>WHATMORE INDUSTRIES</h1>
    <p>"A Living Archive: A Mind in Motion."</p>
  </header>

  <nav>
    <a href="#about">About</a>
    <a href="#projects">Projects</a>
    <a href="#journal">Journal</a>
    <a href="#contact">Contact</a>
  </nav>

  <main>
    <section id="about">
      <h2>About</h2>
      <p>Coming soon...</p>
    </section>
     
<section id="projects">
  <h2>SDO Daily Solar Videos – Latest</h2>
  <div class="grid">
    <div class="video-container">
      <video muted autoplay loop playsinline>
        <source src="https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_0193.mp4" type="video/mp4">
        Your browser does not support the video tag.
      </video>
    </div>
    <div class="video-container">
      <video muted autoplay loop playsinline>
        <source src="https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_0304.mp4" type="video/mp4">
        Your browser does not support the video tag.
      </video>
    </div>
      <div class="video-container">
      <video muted loop playsinline>
        <source src="https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_0171.mp4" type="video/mp4">
      </video>
    </div>
      <div class="video-container">
      <video muted loop playsinline>
        <source src="https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_0211.mp4" type="video/mp4">
      </video>
    </div>
      <div class="video-container">
      <video muted loop playsinline>
        <source src="https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_0335.mp4" type="video/mp4">
      </video>      
    </div>
      <div class="video-container">
      <video muted loop playsinline>
        <source src="https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_0094.mp4" type="video/mp4">
      </video>      
    </div>
      <div class="video-container">
      <video muted loop playsinline>
        <source src="https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_1600.mp4" type="video/mp4">
      </video>      
    </div>
      <div class="video-container">
      <video muted loop playsinline>
        <source src="https://sdo.gsfc.nasa.gov/assets/img/latest/mpeg/latest_1024_1700.mp4" type="video/mp4">
      </video>
    </div>
  </div>
</section>

<script>
  // Zoom Effect
  document.querySelectorAll('.video-container').forEach(container => {
    container.addEventListener('click', () => {
      // Remove zoomed class from all others
      document.querySelectorAll('.video-container').forEach(c => c.classList.remove('zoomed'));
      // Add zoomed class to this one
      container.classList.add('zoomed');
    });
  });

  // Optional: click again to zoom out
  document.addEventListener('click', (e) => {
    if (!e.target.closest('.video-container')) {
      document.querySelectorAll('.video-container').forEach(c => c.classList.remove('zoomed'));
    }
  });

  // Video Syncing
  const videos = document.querySelectorAll("video");
  let readyCount = 0;

  videos.forEach(video => {
    video.addEventListener("canplaythrough", () => {
      readyCount++;
      if (readyCount === videos.length) {
        // Sync play all at once
        videos.forEach(v => {
          v.currentTime = 0;
          v.play();
        });

        syncLoops();
      }
    });
  });

  function syncLoops() {
    const loopTime = videos[0].duration;

    function loopCheck() {
      const now = videos[0].currentTime;
      if (now >= loopTime - 0.05) {
        videos.forEach(v => {
          v.pause();
          v.currentTime = 0;
        });
        // Wait one frame, then restart all
        requestAnimationFrame(() => {
          videos.forEach(v => v.play());
        });
      }
      requestAnimationFrame(loopCheck);
    }

    loopCheck();
  }
</script>


<section id="solar-links">
  <h3 style="text-align:center;">Latest 48-Hour SDO Views</h3>
  <div class="grid">
    <div class="card"><a href="https://sdo.gsfc.nasa.gov/data/latest48.php?q=0193" target="_blank">SDO 0193 Å</a></div>
    <div class="card"><a href="https://sdo.gsfc.nasa.gov/data/latest48.php?q=0304" target="_blank">SDO 0304 Å</a></div>
    <div class="card"><a href="https://sdo.gsfc.nasa.gov/data/latest48.php?q=0171" target="_blank">SDO 0171 Å</a></div>
    <div class="card"><a href="https://sdo.gsfc.nasa.gov/data/latest48.php?q=0211" target="_blank">SDO 0211 Å</a></div>
    <div class="card"><a href="https://sdo.gsfc.nasa.gov/data/latest48.php?q=0335" target="_blank">SDO 0335 Å</a></div>
    <div class="card"><a href="https://sdo.gsfc.nasa.gov/data/latest48.php?q=0094" target="_blank">SDO 0094 Å</a></div>
    <div class="card"><a href="https://sdo.gsfc.nasa.gov/data/latest48.php?q=1600" target="_blank">SDO 1600 Å</a></div>
    <div class="card"><a href="https://sdo.gsfc.nasa.gov/data/latest48.php?q=1700" target="_blank">SDO 1700 Å</a></div>
  </div>
</section>

<section id="calculator">
  <h2>Smart Unit Calculator</h2>
  <div style="background:#222; padding:1rem; border-radius:0.9rem; font-size:1rem;">
    <div id="display" style="background:#000; padding:0.5rem 1rem; margin-bottom:1rem; color:#0f0; font-weight:bold;">
      0
    </div>

    <!-- Number Buttons -->
<style>
  .calculator {
    display: grid;
    grid-template-columns: repeat(3, 60px);
    gap: 5px;
  }

  button {
    width: 60px;
    height: 60px;
    font-size: 1.2em;
  }

  .wide {
    grid-column: span 2;
  }
</style>

<div class="calculator">
  <button onclick="appendCalc('1')">1</button>
  <button onclick="appendCalc('2')">2</button>
  <button onclick="appendCalc('3')">3</button>

  <button onclick="appendCalc('4')">4</button>
  <button onclick="appendCalc('5')">5</button>
  <button onclick="appendCalc('6')">6</button>

  <button onclick="appendCalc('7')">7</button>
  <button onclick="appendCalc('8')">8</button>
  <button onclick="appendCalc('9')">9</button>

  <button onclick="appendCalc('.')">.</button>
  <button onclick="appendCalc('0')">0</button>
  <button onclick="calculate()">=</button>

  <button class="wide" onclick="backspace()">Backspace</button>
  <button class="wide" onclick="clearCalc()">Clear</button>
</div><br>
  <!-- Operators -->
    <div style="margin-bottom: 1rem;">
      <button onclick="appendCalc(' + ')">+</button>
      <button onclick="appendCalc(' - ')">-</button><br>
      <button onclick="appendCalc(' * ')">*</button>
      <button onclick="appendCalc(' / ')">&nbsp;/&nbsp;</button>
    </div>
    <!-- Length Units -->
    <div>
      <strong>Length</strong><br>
      <button onclick="appendCalc(' nm ')">nm</button>
      <button onclick="appendCalc(' μm ')">μm</button>
      <button onclick="appendCalc(' mm ')">mm</button>
      <button onclick="appendCalc(' cm ')">cm</button>
      <button onclick="appendCalc(' m ')">m</button>
      <button onclick="appendCalc(' km ')">km</button><br>
      <button onclick="appendCalc(' in ')">in</button>
      <button onclick="appendCalc(' ft ')">ft</button>
      <button onclick="appendCalc(' yd ')">yd</button>
      <button onclick="appendCalc(' mi ')">mi</button>
    </div><br>
    <!-- Mass Units -->
    <div>
      <strong>Mass</strong><br>
      <button onclick="appendCalc(' mg ')">mg</button>
      <button onclick="appendCalc(' g ')">g</button>
      <button onclick="appendCalc(' kg ')">kg</button><br>
      <button onclick="appendCalc(' t ')">t</button>
      <button onclick="appendCalc(' oz ')">oz</button>
      <button onclick="appendCalc(' lb ')">lb</button>
      <button onclick="appendCalc(' st ')">st</button>
    </div><br>
    <!-- Time Units -->
    <div>
      <strong>Time</strong><br>
      <button onclick="appendCalc(' ns ')">ns</button>
      <button onclick="appendCalc(' μs ')">μs</button>
      <button onclick="appendCalc(' ms ')">ms</button>
      <button onclick="appendCalc(' s ')">s</button>
      <button onclick="appendCalc(' min ')">min</button>
      <button onclick="appendCalc(' hr ')">hr</button>
      <button onclick="appendCalc(' day ')">day</button>
    </div>
  </div>
</section>
    <section id="about">
      <h2>About</h2>
      <p>I am the founder of Whatmore Industries. I build, test, observe, and connect — from off-grid systems and theoretical models to hands-on fabrication and prototyping. Every line I draw and every circuit I etch aims to serve a greater curiosity: what more is possible?</p>
    </section>
    <section id="projects">
      <h2>Projects</h2>
      <p>Explore my work in electromaterials, antenna theory, sustainable design, and beyond. Each project is a story of purpose and discovery.</p>
    </section>
    <section id="journal">
      <h2>Journal</h2>
      <p>Thoughts, theories, and breakthroughs — documented in motion. This is where process meets philosophy.</p>
    </section>
    <section id="contact">
      <h2>Contact</h2>
      <p>To collaborate, ask questions, or propose a mission — reach out directly at <a href="mailto:contact@whatmoreindustries.io">contact@whatmoreindustries.io</a>.</p>
    </section>
  </main>


  <!-- Particles.js -->
  <script src="https://cdn.jsdelivr.net/npm/particles.js@2.0.0/particles.min.js"></script>
  <script>
    particlesJS("particles-js", {
      particles: {
        number: { value: 80, density: { enable: true, value_area: 800 }},
        color: { value: "#00ffff" },
        shape: { type: "circle" },
        opacity: { value: 0.5 },
        size: { value: 3, random: true },
        line_linked: {
          enable: true,
          distance: 150,
          color: "#00ffff",
          opacity: 0.4,
          width: 1
        },
        move: {
          enable: true,
          speed: 0.01,
          direction: "none"
        }
      },
      interactivity: {
        events: {
          onhover: { enable: true, mode: "repulse" },
          onclick: { enable: true, mode: "push" }
        },
        modes: {
          repulse: { distance: 100, duration: 0.4 },
          push: { particles_nb: 4 }
        }
      },
      retina_detect: true
    });
  </script>
  
  <script>
  const unitFactors = {
    // Length (in meters)
    nm: 1e-9, μm: 1e-6, mm: 1e-3, cm: 1e-2, m: 1, km: 1e3,
    in: 0.0254, ft: 0.3048, yd: 0.9144, mi: 1609.34,
    // Mass (in kg)
    mg: 1e-6, g: 1e-3, kg: 1, t: 1000, oz: 0.0283495, lb: 0.453592, st: 6.35029, kip: 453.592,
    // Time (in seconds)
    ns: 1e-9, μs: 1e-6, ms: 1e-3, s: 1, min: 60, hr: 3600, day: 86400
  };

  let expression = "";

  function appendCalc(value) {
    expression += value;
    document.getElementById("display").innerText = expression;
  }

  function clearCalc() {
    expression = "";
    document.getElementById("display").innerText = "0";
  }

  function backspace() {
    expression = expression.trim().slice(0, -1);
    document.getElementById("display").innerText = expression || "0";
  }

  function calculate() {
    try {
      // Tokenize numbers and units
      const parsed = expression.replace(/([0-9.]+)\s*([a-zμ]+)/gi, (match, value, unit) => {
        if (unitFactors[unit]) {
          return `(${parseFloat(value) * unitFactors[unit]})`; // convert to SI
        } else {
          throw new Error(`Unknown unit: ${unit}`);
        }
      });

      const result = eval(parsed);
      document.getElementById("display").innerText = result + " (SI)";
      expression = result.toString();
    } catch (err) {
      document.getElementById("display").innerText = "Error";
      expression = "";
    }
  }
</script>

<script>
  let currentExpression = '';

  function appendCalc(value) {
    currentExpression += value;
    document.getElementById('display').innerText = currentExpression;
  }

  function clearCalc() {
    currentExpression = '';
    document.getElementById('display').innerText = '0';
  }

  function backspace() {
    currentExpression = currentExpression.slice(0, -1);
    document.getElementById('display').innerText = currentExpression || '0';
  }

  function calculate() {
    try {
      const result = eval(currentExpression);
      document.getElementById('display').innerText = result;
      currentExpression = result.toString();
    } catch (e) {
      document.getElementById('display').innerText = 'Error';
      currentExpression = '';
    }
  }
</script>
<script>
  let calcStr = '';
  function appendCalc(value) {
    calcStr += value;
    document.getElementById('display').textContent = calcStr;
  }

  function clearCalc() {
    calcStr = '';
    document.getElementById('display').textContent = '0';
  }

  function backspace() {
    calcStr = calcStr.slice(0, -1);
    document.getElementById('display').textContent = calcStr || '0';
  }

  function calculate() {
    try {
      const result = eval(calcStr);
      document.getElementById('display').textContent = result;
      calcStr = result.toString();
    } catch (e) {
      document.getElementById('display').textContent = 'Error';
    }
  }
</script>
<script>
  document.querySelectorAll('.video-container').forEach(container => {
    container.addEventListener('click', () => {
      // Remove zoom from other videos
      document.querySelectorAll('.video-container.zoomed').forEach(z => {
        if (z !== container) z.classList.remove('zoomed');
      });

      container.classList.toggle('zoomed');
    });
  });
</script>

 
  <footer>
    &copy; 2025 Whatmore Industries. All rights reserved.
  </footer>
</body>
</html>


