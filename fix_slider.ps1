$htmlPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\index.html'
$html = [System.IO.File]::ReadAllText($htmlPath)

# 1. Update Hero Text
$oldHero = '<p>A FULL STACK DEVELOPER<br/>PASSIONATE ABOUT CRAFTING<br/>BOLD APPLICATIONS AND<br/>BRINGING IDEAS TO LIFE.</p>'
$newHero = '<p>A FULL STACK DEVELOPER<br/>PASSIONATE ABOUT CRAFTING BOLD,<br/>HIGH-PERFORMANCE WEB APPLICATIONS.<br/>BRINGING IDEAS TO LIFE WITH CLEAN CODE<br/>AND STUNNING DESIGN.</p>'
$html = $html.Replace($oldHero, $newHero)

# 2. Add Swiper CSS in HEAD
if (-not $html.Contains('swiper-bundle.min.css')) {
    $html = $html.Replace('</head>', "  <link rel=`"stylesheet`" href=`"https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css`" />`n</head>")
}

# 3. Add Swiper JS before body
if (-not $html.Contains('swiper-bundle.min.js')) {
    $html = $html.Replace('</body>', "  <script src=`"https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js`"></script>`n</body>")
}

# 4. Rebuild Projects section
$swiperHtml = @"
<div class="swiper mySwiper">
    <div class="swiper-wrapper">
      <!-- Slide 1 -->
      <div class="swiper-slide proj-c">
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
      <!-- Slide 2 -->
      <div class="swiper-slide proj-c">
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
      <!-- Slide 3 -->
      <div class="swiper-slide proj-c">
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
      <!-- Slide 4 -->
      <div class="swiper-slide proj-c">
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
      <!-- Slide 5 -->
      <div class="swiper-slide proj-c">
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
      <!-- Slide 6 -->
      <div class="swiper-slide proj-c">
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
    <div class="swiper-pagination" style="bottom: 0;"></div>
    <div class="swiper-button-next"></div>
    <div class="swiper-button-prev"></div>
  </div>
</section>
"@

$html = $html -replace '(?s)<div class="proj-grid">.*?</section>', $swiperHtml

[System.IO.File]::WriteAllText($htmlPath, $html)
Write-Output "HTML updated successfully"
