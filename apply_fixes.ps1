$htmlPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\index.html'
$html = [System.IO.File]::ReadAllText($htmlPath)

# 1. Fonts
$html = $html -replace '<link href="https://fonts.googleapis.com/css2\?family=Clash\+Display.*?rel="stylesheet"/>', '<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" rel="stylesheet"/>'
# Remove swiper CSS/JS
$html = $html -replace '<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />', ''
$html = $html -replace '<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>', ''

# 2. Fix Bento Grid HTML classes
$html = $html -replace '<div class="bc bc-4 reveal">', '<div class="bc bc-3 reveal">'

# 3. Revert Swiper to Sticky Stack in HTML
$projectsStickyHtml = @"
<div class="proj-grid">
      <!-- Project 1 -->
      <div class="proj-c reveal">
        <div class="proj-mock">
          <img src="assets/img1.png" alt="SaaS Dashboard" class="mock-img"/>
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
      <div class="proj-c reveal">
        <div class="proj-mock">
          <img src="assets/img2.png" alt="Luxury Fashion" class="mock-img"/>
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
      <div class="proj-c reveal">
        <div class="proj-mock">
          <img src="assets/img3.png" alt="Subscription Box" class="mock-img"/>
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
      <div class="proj-c reveal">
        <div class="proj-mock">
          <img src="assets/img1.png" alt="Medical Portal" class="mock-img"/>
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
      <div class="proj-c reveal">
        <div class="proj-mock">
          <img src="assets/img2.png" alt="Real Estate" class="mock-img"/>
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
      <div class="proj-c reveal">
        <div class="proj-mock">
          <img src="assets/img3.png" alt="Developer API" class="mock-img"/>
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

$html = $html -replace '(?s)<div class="swiper mySwiper">.*?</div>\s*</section>', "$projectsStickyHtml`n</section>"
[System.IO.File]::WriteAllText($htmlPath, $html)

$cssPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\style.css'
$css = [System.IO.File]::ReadAllText($cssPath)

# Replace Fonts
$css = $css -replace "'Syne',sans-serif", "'Roboto', Arial, sans-serif"
$css = $css -replace "'JetBrains Mono',monospace", "'Roboto', Arial, sans-serif"
$css = $css -replace "'DM Sans',sans-serif", "'Roboto', Arial, sans-serif"

# Fix CSS for Projects (Sticky Stack with Full Images)
$stickyCss = @"
/* ══ PROJECTS (STICKY STACK) ══ */
#projects{background:var(--bg2); padding-bottom: 4rem;}
.proj-grid{display:flex;flex-direction:column;gap:4rem;padding-bottom:10rem;}
.proj-c{
  background:var(--card);border:1px solid var(--border);
  border-radius:var(--r2);overflow:hidden;
  transition:.35s;
  position:sticky;top:100px;
  display:flex;flex-direction:column;
  box-shadow:0 -20px 40px rgba(0,0,0,.8);
}
.proj-c:hover{
  border-color:var(--gold);
  box-shadow:0 -20px 60px rgba(0,0,0,1), 0 0 30px rgba(207,151,53,.2);
}
.proj-mock{
  width:100%; height:450px; position:relative; overflow:hidden;
  border-bottom:1px solid var(--border);
}
.mock-img{width:100%;height:100%;display:block;object-fit:cover;transition: transform 0.6s ease;}
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

$css = $css -replace '(?s)/\* ══ PROJECTS \(SWIPER\) ══ \*/.*?(?=/\* ══ CTA ══ \*/)', "$stickyCss`n`n"
$css = $css -replace '(?s)/\* ══ PROJECTS ══ \*/.*?(?=/\* ══ CTA ══ \*/)', "$stickyCss`n`n"

# Remove the flex-direction:column override for .proj-c in responsive since it's already column
$css = $css -replace '\.proj-c\{flex-direction:column;\}\.proj-mock\{width:100%;height:250px;border-right:none;border-bottom:1px solid var\(--border\);\}\.proj-body\{width:100%;padding:2rem;\}', '.proj-mock{height:300px;}.proj-body{padding:1.5rem;}'

[System.IO.File]::WriteAllText($cssPath, $css)

# Update JS to remove Swiper init
$jsPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\script.js'
$js = [System.IO.File]::ReadAllText($jsPath)
$js = $js -replace '(?s)/\* ── SWIPER INIT ── \*/.*', ''
[System.IO.File]::WriteAllText($jsPath, $js)

Write-Output "Applied fixes successfully"
