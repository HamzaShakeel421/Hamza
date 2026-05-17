$htmlPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\index.html'
$html = [System.IO.File]::ReadAllText($htmlPath)

# 1. GSAP Scripts
if (-not $html.Contains('gsap.min.js')) {
    $html = $html.Replace('</body>', "  <script src=`"https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js`"></script>`n  <script src=`"https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js`"></script>`n</body>")
}

# 2. Fix Bento Grid
$html = $html -replace '<div class="bc bc-3 reveal">', '<div class="bc bc-full reveal">'

# 3. Rebuild Projects section for GSAP
$gsapProjectsHtml = @"
<div class="h-scroll-wrapper">
    <div class="h-scroll-container">
      <!-- Project 1 -->
      <div class="proj-c">
        <div class="proj-mock">
          <img src="https://placehold.co/1200x800/080604/CF9735?text=SaaS+Dashboard" alt="SaaS Dashboard" class="mock-img"/>
          <div class="proj-overlay"><a href="#" class="proj-view">View Case Study</a></div>
        </div>
        <div class="proj-body">
          <div class="proj-cat">SaaS Platform</div>
          <h3 class="proj-name">Analytics Dashboard</h3>
          <p class="proj-desc">A high-performance dark mode SaaS dashboard with complex data visualization, real-time metrics, and state management.</p>
          <div class="proj-tags"><span class="ptag">React</span><span class="ptag">TypeScript</span><span class="ptag">Tailwind</span></div>
        </div>
      </div>
      <!-- Project 2 -->
      <div class="proj-c">
        <div class="proj-mock">
          <img src="https://placehold.co/1200x800/080604/E1A558?text=Aura+Fashion+Store" alt="Luxury Fashion" class="mock-img"/>
          <div class="proj-overlay"><a href="#" class="proj-view">View Case Study</a></div>
        </div>
        <div class="proj-body">
          <div class="proj-cat">eCommerce</div>
          <h3 class="proj-name">Aura Fashion Store</h3>
          <p class="proj-desc">A premium luxury fashion storefront built on Shopify, featuring custom animations, 3D product viewing, and seamless checkout.</p>
          <div class="proj-tags"><span class="ptag">Shopify</span><span class="ptag">Liquid</span><span class="ptag">GSAP</span></div>
        </div>
      </div>
      <!-- Project 3 -->
      <div class="proj-c">
        <div class="proj-mock">
          <img src="https://placehold.co/1200x800/080604/CF9735?text=Elite+Subscriptions" alt="Subscription Box" class="mock-img"/>
          <div class="proj-overlay"><a href="#" class="proj-view">View Case Study</a></div>
        </div>
        <div class="proj-body">
          <div class="proj-cat">WooCommerce</div>
          <h3 class="proj-name">Elite Subscriptions</h3>
          <p class="proj-desc">A fully automated subscription box platform utilizing WooCommerce Subscriptions, Stripe integration, and complex custom logic.</p>
          <div class="proj-tags"><span class="ptag">WordPress</span><span class="ptag">PHP</span><span class="ptag">WooCommerce</span></div>
        </div>
      </div>
      <!-- Project 4 -->
      <div class="proj-c">
        <div class="proj-mock">
          <img src="https://placehold.co/1200x800/080604/E1A558?text=MediCare+Booking" alt="Medical Portal" class="mock-img"/>
          <div class="proj-overlay"><a href="#" class="proj-view">View Case Study</a></div>
        </div>
        <div class="proj-body">
          <div class="proj-cat">Healthcare</div>
          <h3 class="proj-name">MediCare Booking System</h3>
          <p class="proj-desc">A sophisticated medical portal with dynamic appointment booking, secure patient records, and doctor scheduling.</p>
          <div class="proj-tags"><span class="ptag">Angular</span><span class="ptag">Node.js</span><span class="ptag">MySQL</span></div>
        </div>
      </div>
      <!-- Project 5 -->
      <div class="proj-c">
        <div class="proj-mock">
          <img src="https://placehold.co/1200x800/080604/CF9735?text=Luxe+Properties" alt="Real Estate" class="mock-img"/>
          <div class="proj-overlay"><a href="#" class="proj-view">View Case Study</a></div>
        </div>
        <div class="proj-body">
          <div class="proj-cat">Real Estate</div>
          <h3 class="proj-name">Luxe Properties</h3>
          <p class="proj-desc">An interactive property listing map interface with advanced filtering, 360-tours, and real-time agent chatting.</p>
          <div class="proj-tags"><span class="ptag">React</span><span class="ptag">Mapbox</span><span class="ptag">Firebase</span></div>
        </div>
      </div>
      <!-- Project 6 -->
      <div class="proj-c">
        <div class="proj-mock">
          <img src="https://placehold.co/1200x800/080604/E1A558?text=Payment+Gateway+API" alt="Developer API" class="mock-img"/>
          <div class="proj-overlay"><a href="#" class="proj-view">View Case Study</a></div>
        </div>
        <div class="proj-body">
          <div class="proj-cat">FinTech</div>
          <h3 class="proj-name">Payment Gateway API</h3>
          <p class="proj-desc">Comprehensive developer documentation portal for a custom FinTech payment API, built with dark mode and code block highlighting.</p>
          <div class="proj-tags"><span class="ptag">Next.js</span><span class="ptag">MDX</span><span class="ptag">Vercel</span></div>
        </div>
      </div>
    </div>
"@
$html = $html -replace '(?s)<div class="proj-grid">.*?</div>\s*</section>', "$gsapProjectsHtml`n</section>"

[System.IO.File]::WriteAllText($htmlPath, $html)

$cssPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\style.css'
$css = [System.IO.File]::ReadAllText($cssPath)

# 4. Global Font Force
if (-not $css.Contains('* { font-family')) {
    $css = "*{font-family:'Roboto',Arial,sans-serif !important;}`n" + $css
}

# 5. Fix CSS Bento & Projects
$css = $css -replace '\.bc-3\{grid-column:span 3;\}', '.bc-full{grid-column: 1 / -1;}.bc-3{grid-column:span 3;}'

$gsapCss = @"
/* ══ GSAP PROJECTS SLIDER ══ */
#projects{background:var(--bg2); padding-bottom: 0;}
.h-scroll-wrapper { overflow: hidden; width: 100%; position: relative; }
.h-scroll-container { display: flex; width: max-content; gap: 4rem; padding: 4rem 5vw 10rem; }
.proj-c{
  width: 80vw; max-width: 1000px; flex-shrink: 0;
  background:var(--card);border:1px solid var(--border);
  border-radius:var(--r2);overflow:hidden;
  transition:.35s;
  display:flex;flex-direction:column;
  box-shadow:0 10px 40px rgba(0,0,0,.5);
}
.proj-c:hover{
  border-color:var(--gold);
  box-shadow:0 10px 50px rgba(0,0,0,.8), 0 0 30px rgba(207,151,53,.15);
}
.proj-mock{
  width:100%; height:55vh; min-height: 400px; position:relative; overflow:hidden;
  border-bottom:1px solid var(--border); background: #000;
}
.mock-img{width:100%;height:100%;display:block;object-fit:contain;transition: transform 0.6s ease; padding: 1rem;}
.proj-c:hover .mock-img { transform: scale(1.02); }
.proj-overlay{
  position:absolute;inset:0;background:rgba(8,6,4,.4);
  display:flex;justify-content:center;align-items:center;
  opacity:0;transition:.3s;backdrop-filter:blur(2px);
}
.proj-c:hover .proj-overlay{opacity:1;}
.proj-view{
  background:var(--text);color:var(--bg);padding:1rem 2rem;
  border-radius:50px;font-weight:700;font-size:.9rem;text-decoration:none;
  transform:translateY(20px);transition:.3s;
}
.proj-c:hover .proj-view{transform:translateY(0);}
.proj-body{padding:2.5rem;width:100%;display:flex;flex-direction:column;justify-content:center;background:var(--card);}
"@

$css = $css -replace '(?s)/\* ══ PROJECTS \(STICKY STACK\) ══ \*/.*?(?=/\* ══ CTA ══ \*/)', "$gsapCss`n`n"
$css = $css -replace '(?s)/\* ══ PROJECTS ══ \*/.*?(?=/\* ══ CTA ══ \*/)', "$gsapCss`n`n"

[System.IO.File]::WriteAllText($cssPath, $css)

$jsPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\script.js'
$js = [System.IO.File]::ReadAllText($jsPath)

$gsapJs = @"

/* ── GSAP HORIZONTAL SCROLL SLIDER ── */
document.addEventListener('DOMContentLoaded', () => {
  if (typeof gsap !== 'undefined' && typeof ScrollTrigger !== 'undefined') {
    gsap.registerPlugin(ScrollTrigger);
    let scrollCont = document.querySelector(".h-scroll-container");
    if (scrollCont) {
      let scrollAmount = scrollCont.scrollWidth - window.innerWidth;
      gsap.to(scrollCont, {
        x: -scrollAmount,
        ease: "none",
        scrollTrigger: {
          trigger: ".h-scroll-wrapper",
          pin: true,
          scrub: 1,
          end: () => "+=" + scrollAmount
        }
      });
    }
  }
});
"@
if (-not $js.Contains('GSAP HORIZONTAL SCROLL')) {
    $js += $gsapJs
}

[System.IO.File]::WriteAllText($jsPath, $js)
Write-Output "Applied ultimate GSAP fixes successfully"
