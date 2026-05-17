/* ── CURSOR ── */
const cur=document.getElementById('cur'),curR=document.getElementById('cur-r');
let mx=0,my=0,rx=0,ry=0;
document.addEventListener('mousemove',e=>{mx=e.clientX;my=e.clientY;cur.style.cssText+=`left:${mx}px;top:${my}px;`;});
(function anim(){rx+=(mx-rx)*.14;ry+=(my-ry)*.14;curR.style.cssText=`left:${rx}px;top:${ry}px;`;requestAnimationFrame(anim);})();
document.querySelectorAll('a,button').forEach(el=>{
  el.addEventListener('mouseenter',()=>{curR.style.transform='translate(-50%,-50%) scale(2)';curR.style.borderColor='rgba(207,151,53,.3)';});
  el.addEventListener('mouseleave',()=>{curR.style.transform='translate(-50%,-50%) scale(1)';curR.style.borderColor='rgba(207,151,53,.5)';});
});

/* ── NAV SCROLL ── */
window.addEventListener('scroll',()=>{
  document.getElementById('nav').classList.toggle('scrolled',window.scrollY>50);
});

/* ── SCROLL REVEAL ── */
const revEls=document.querySelectorAll('.reveal,.reveal-l,.reveal-r');
const revObs=new IntersectionObserver(entries=>{
  entries.forEach((e,i)=>{
    if(e.isIntersecting){setTimeout(()=>e.target.classList.add('in'),i*70);revObs.unobserve(e.target);}
  });
},{threshold:.1});
revEls.forEach(r=>revObs.observe(r));

/* ── COUNTER ── */
const counts=document.querySelectorAll('.count[data-t]');
const cObs=new IntersectionObserver(entries=>{
  entries.forEach(e=>{
    if(!e.isIntersecting)return;
    const el=e.target,target=+el.dataset.t;
    let n=0,start=null;
    function step(ts){
      if(!start)start=ts;
      const prog=Math.min((ts-start)/1400,1);
      const ease=1-Math.pow(1-prog,3);
      el.textContent=Math.floor(ease*target)+(target>=10?'+':'');
      if(prog<1)requestAnimationFrame(step);
      else el.textContent=target+'+';
    }
    requestAnimationFrame(step);
    cObs.unobserve(el);
  });
},{threshold:.5});
counts.forEach(c=>cObs.observe(c));

/* ── CTA PARTICLES ── */
const pWrap=document.getElementById('particles');
if(pWrap){
    for(let i=0;i<18;i++){
      const p=document.createElement('div');
      const size=Math.random()*80+20;
      p.className='cta-particle';
      p.style.cssText=`
        width:${size}px;height:${size}px;
        left:${Math.random()*100}%;top:${Math.random()*100}%;
        animation-delay:${Math.random()*5}s;
        animation-duration:${4+Math.random()*4}s;
      `;
      pWrap.appendChild(p);
    }
}

/* ── FAQ ACCORDION ── */
document.querySelectorAll('.faq-trigger').forEach(trigger => {
  trigger.addEventListener('click', () => {
    const item = trigger.parentElement;
    const panel = item.querySelector('.faq-panel');
    const isActive = item.classList.contains('active');
    
    // Close other items
    document.querySelectorAll('.faq-item').forEach(otherItem => {
      otherItem.classList.remove('active');
      otherItem.querySelector('.faq-panel').style.maxHeight = null;
    });
    
    if (!isActive) {
      item.classList.add('active');
      panel.style.maxHeight = panel.scrollHeight + "px";
    }
  });
});

/* ── TESTIMONIAL SLIDER ── */
const slides = document.querySelectorAll('.test-slide');
const dots = document.querySelectorAll('.slider-dots .dot');
const prevBtn = document.getElementById('prev-test');
const nextBtn = document.getElementById('next-test');
let currentSlide = 0;
let slideInterval;

function showSlide(index) {
  slides.forEach(slide => slide.classList.remove('active'));
  dots.forEach(dot => dot.classList.remove('active'));
  
  currentSlide = (index + slides.length) % slides.length;
  slides[currentSlide].classList.add('active');
  dots[currentSlide].classList.add('active');
}

function nextSlide() {
  showSlide(currentSlide + 1);
}

function prevSlide() {
  showSlide(currentSlide - 1);
}

function startSlideShow() {
  stopSlideShow();
  slideInterval = setInterval(nextSlide, 6000);
}

function stopSlideShow() {
  if (slideInterval) clearInterval(slideInterval);
}

if (prevBtn && nextBtn) {
  prevBtn.addEventListener('click', () => { prevSlide(); startSlideShow(); });
  nextBtn.addEventListener('click', () => { nextSlide(); startSlideShow(); });
  dots.forEach((dot, idx) => {
    dot.addEventListener('click', () => { showSlide(idx); startSlideShow(); });
  });
  startSlideShow();
}

/* ── TIMELINE SCROLL PROGRESS ── */
const timeline = document.querySelector('.process-timeline');
const progLine = document.getElementById('timeline-prog');
if (timeline && progLine) {
  window.addEventListener('scroll', () => {
    const rect = timeline.getBoundingClientRect();
    const winHeight = window.innerHeight;
    const totalDist = rect.height;
    const startPoint = winHeight * 0.75;
    
    let progress = (startPoint - rect.top) / totalDist;
    progress = Math.max(0, Math.min(1, progress));
    progLine.style.height = (progress * 100) + '%';
  });
}

/* ── DYNAMIC SUBTITLE HIGHLIGHTER ── */
const subWords = document.querySelectorAll('.hero-subline .sub-word');
if (subWords.length > 0) {
  let wordIdx = 0;
  setInterval(() => {
    subWords.forEach(w => w.classList.remove('active'));
    wordIdx = (wordIdx + 1) % subWords.length;
    subWords[wordIdx].classList.add('active');
  }, 3000);
}

/* ── 2D PHYSICS SKILLS BOX ENGINE ── */
(function() {
  const canvas = document.getElementById('skills-canvas');
  const container = document.getElementById('physics-container');
  if (!canvas || !container) return;

  const ctx = canvas.getContext('2d');
  let width = 0, height = 0;
  let balls = [];
  let draggedBall = null;
  let isMouseDown = false;
  let mouse = { x: 0, y: 0, lastX: 0, lastY: 0, vx: 0, vy: 0 };

  const SKILLS_DATA = [
    { label: "React", icon: "⚛️", subtitle: "Frontend SPA", desc: "Modern single-page applications utilizing React Hooks, Context API, state management libraries, and optimized virtual DOM rendering.", tags: ["React.js", "Redux", "Hooks", "Context API", "SPAs"], type: "gold" },
    { label: "Next.js", icon: "🚀", subtitle: "SSR & SSG Architecture", desc: "Production-ready architectures with server-side rendering, static site generation, API routing, search optimization, and Vercel analytics.", tags: ["Next.js", "SSR", "SSG", "API Routes", "SEO Ready"], type: "black" },
    { label: "Angular", icon: "🅰️", subtitle: "Enterprise Apps", desc: "Robust typescript-driven client architectures, featuring modular structure, dependency injection, RxJS streams, and custom structural directives.", tags: ["Angular", "TypeScript", "RxJS", "Enterprise Stack"], type: "black" },
    { label: "PHP", icon: "🐘", subtitle: "Backend Development", desc: "Secure, object-oriented server-side programming, customized CRUD, secure REST APIs, session handling, and database integration.", tags: ["PHP", "OOP", "MVC", "REST APIs", "Laravel"], type: "gold" },
    { label: "WordPress", icon: "🌐", subtitle: "CMS Systems", desc: "High-end bespoke theme coding, Gutenberg blocks, advanced custom fields (ACF Pro), custom child theme structure, and secure core setup.", tags: ["WordPress", "ACF Pro", "Custom Themes", "Child Themes"], type: "black" },
    { label: "Shopify", icon: "🛍️", subtitle: "eCommerce Solutions", desc: "Premium custom Liquid section builds, checkout modifications, headless configurations, storefront API, and Shopify App integrations.", tags: ["Shopify", "Liquid", "Cart Drawer", "GraphQL", "Admin API"], type: "gold" },
    { label: "WooCommerce", icon: "🛒", subtitle: "Shop Platforms", desc: "Enterprise WooCommerce store setup, payment gateway integrations, membership features, custom subscription hooks, and order workflow automation.", tags: ["WooCommerce", "WordPress", "Stripe", "Subscriptions", "Checkout Customization"], type: "black" },
    { label: "REST API", icon: "⚙️", subtitle: "API Integration", desc: "Developing and integrating scalable, secure, authenticated JSON web endpoints utilizing JWT, CORS, OAuth, and efficient database indexing.", tags: ["RESTful APIs", "JWT Auth", "JSON", "CORS", "Postman Testing"], type: "gold" },
    { label: "MySQL", icon: "🗄️", subtitle: "Database Engineering", desc: "Relational database structures, high-performance query optimization, schema relationships, secure transactions, and data replication.", tags: ["MySQL", "SQL Queries", "Schema Design", "Optimization"], type: "black" },
    { label: "Speed Tuning", icon: "⚡", subtitle: "Performance Tuning", desc: "Core Web Vitals tuning, asset compilation, caching policies, image minification, CDN setup, lazy loading, and script deferral.", tags: ["Core Web Vitals", "Lighthouse 99+", "Caching", "CDN", "Webp Compression"], type: "gold" },
    { label: "UI/UX", icon: "🎨", subtitle: "Visual Systems", desc: "Bespoke spatial design systems, elite grid structures, elegant color schemes, visual hierarchies, and modern luxury design layouts.", tags: ["Figma-to-code", "Awwwards Style", "Typography", "Spatial Grids"], type: "black" },
    { label: "Tailwind", icon: "🍃", subtitle: "Utility styling", desc: "Rapid utility-first markup styling, responsive grids, custom configuration plugins, clean color tokens, and optimized CSS bundle compilations.", tags: ["Tailwind CSS", "Utility First", "Responsive Design", "PurgeCSS"], type: "gold" }
  ];

  function resize() {
    width = container.offsetWidth;
    height = container.offsetHeight;
    canvas.width = width;
    canvas.height = height;

    // Constrain balls inside screen on resize
    balls.forEach(ball => {
      ball.x = Math.max(ball.radius, Math.min(width - ball.radius, ball.x));
      ball.y = Math.max(ball.radius, Math.min(height - ball.radius, ball.y));
    });
  }

  class Ball {
    constructor(x, y, radius, data) {
      this.x = x;
      this.y = y;
      this.radius = radius;
      this.data = data;
      this.vx = (Math.random() - 0.5) * 1.5;
      this.vy = (Math.random() - 0.5) * 1.5;
      this.isDragged = false;
      this.pulsePhase = Math.random() * Math.PI * 2;
    }

    update() {
      if (this.isDragged) {
        this.vx = mouse.x - this.x;
        this.vy = mouse.y - this.y;
        this.x = mouse.x;
        this.y = mouse.y;
      } else {
        // Friction / Air resistance
        this.vx *= 0.98;
        this.vy *= 0.98;

        // Apply buoyancy drift (anti-gravity float to feel alive)
        this.pulsePhase += 0.015;
        this.vx += Math.sin(this.pulsePhase) * 0.03;
        this.vy += Math.cos(this.pulsePhase) * 0.03 - 0.005; // tiny rise

        this.x += this.vx;
        this.y += this.vy;

        // Border Collisions with spring bounce
        const restitution = 0.7; // bounciness
        if (this.x - this.radius < 0) {
          this.x = this.radius;
          this.vx = -this.vx * restitution;
        } else if (this.x + this.radius > width) {
          this.x = width - this.radius;
          this.vx = -this.vx * restitution;
        }

        if (this.y - this.radius < 0) {
          this.y = this.radius;
          this.vy = -this.vy * restitution;
        } else if (this.y + this.radius > height) {
          this.y = height - this.radius;
          this.vy = -this.vy * restitution;
        }
      }
    }

    draw(ctx) {
      ctx.save();
      
      // Shadow
      ctx.shadowColor = 'rgba(0, 0, 0, 0.4)';
      ctx.shadowBlur = 15;
      ctx.shadowOffsetX = 4;
      ctx.shadowOffsetY = 6;

      // Base circle
      ctx.beginPath();
      ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
      
      // Specular highlight and base gradients
      let grad = ctx.createRadialGradient(
        this.x - this.radius * 0.25, 
        this.y - this.radius * 0.25, 
        this.radius * 0.1, 
        this.x, 
        this.y, 
        this.radius
      );

      if (this.data.type === "gold") {
        // Luxury metallic gold
        grad.addColorStop(0, '#FFF3D0');
        grad.addColorStop(0.3, '#E1A558');
        grad.addColorStop(0.8, '#B2792D');
        grad.addColorStop(1, '#694212');
        ctx.fillStyle = grad;
        ctx.fill();

        // Delicate dark border
        ctx.shadowColor = 'transparent';
        ctx.strokeStyle = 'rgba(89, 45, 20, 0.4)';
        ctx.lineWidth = 1;
        ctx.stroke();
      } else {
        // Premium Obsidian/Carbon Black
        grad.addColorStop(0, '#2F2620');
        grad.addColorStop(0.4, '#140c08');
        grad.addColorStop(0.9, '#080503');
        grad.addColorStop(1, '#000000');
        ctx.fillStyle = grad;
        ctx.fill();

        // Distinct gold outline
        ctx.shadowColor = 'transparent';
        ctx.strokeStyle = 'rgba(207, 151, 53, 0.35)';
        ctx.lineWidth = 1.5;
        ctx.stroke();
      }

      // 3D Glass Specular Reflection Oval
      ctx.beginPath();
      ctx.ellipse(
        this.x - this.radius * 0.28, 
        this.y - this.radius * 0.28, 
        this.radius * 0.35, 
        this.radius * 0.2, 
        Math.PI * -0.25, 
        0, 
        Math.PI * 2
      );
      let specularGrad = ctx.createLinearGradient(
        this.x - this.radius * 0.5,
        this.y - this.radius * 0.5,
        this.x,
        this.y
      );
      specularGrad.addColorStop(0, 'rgba(255, 255, 255, 0.55)');
      specularGrad.addColorStop(1, 'rgba(255, 255, 255, 0)');
      ctx.fillStyle = specularGrad;
      ctx.fill();

      // Draw text label
      ctx.shadowColor = 'transparent';
      ctx.font = `600 ${this.radius * 0.26}px 'Outfit', sans-serif`;
      ctx.textAlign = 'center';
      ctx.textBaseline = 'middle';
      
      if (this.data.type === "gold") {
        ctx.fillStyle = '#080604'; // dark text on gold
      } else {
        ctx.fillStyle = '#E5E4E3'; // white text on black
      }
      ctx.fillText(this.data.label, this.x, this.y);

      ctx.restore();
    }
  }

  function setup() {
    balls = [];
    const cols = 4;
    const spacingX = width / (cols + 1);
    const spacingY = height / 4;

    SKILLS_DATA.forEach((skill, idx) => {
      const col = idx % cols;
      const row = Math.floor(idx / cols);
      const x = spacingX * (col + 1) + (Math.random() - 0.5) * 15;
      const y = spacingY * (row + 1) + (Math.random() - 0.5) * 15;
      const radius = 45 + skill.label.length * 1.5; // proportional sizing
      balls.push(new Ball(x, y, radius, skill));
    });
  }

  function resolveCollisions() {
    for (let i = 0; i < balls.length; i++) {
      for (let j = i + 1; j < balls.length; j++) {
        const b1 = balls[i];
        const b2 = balls[j];
        
        const dx = b2.x - b1.x;
        const dy = b2.y - b1.y;
        const dist = Math.hypot(dx, dy);
        const minDist = b1.radius + b2.radius;

        if (dist < minDist) {
          // Push out of overlap (position correction)
          const overlap = minDist - dist;
          const nx = dx / (dist || 1);
          const ny = dy / (dist || 1);

          if (!b1.isDragged && !b2.isDragged) {
            b1.x -= nx * overlap * 0.5;
            b1.y -= ny * overlap * 0.5;
            b2.x += nx * overlap * 0.5;
            b2.y += ny * overlap * 0.5;
          } else if (b1.isDragged) {
            b2.x += nx * overlap;
            b2.y += ny * overlap;
          } else {
            b1.x -= nx * overlap;
            b1.y -= ny * overlap;
          }

          // Elastic collision math
          const kx = b1.vx - b2.vx;
          const ky = b1.vy - b2.vy;
          const k = kx * nx + ky * ny;

          if (k > 0) {
            const restitution = 0.5;
            const impulse = k * (1 + restitution) * 0.5;
            
            if (!b1.isDragged) {
              b1.vx -= nx * impulse;
              b1.vy -= ny * impulse;
            }
            if (!b2.isDragged) {
              b2.vx += nx * impulse;
              b2.vy += ny * impulse;
            }
          }
        }
      }
    }
  }

  // Update Detail Panel Card
  const detailCard = document.getElementById('skills-detail-card');
  const detailIcon = document.getElementById('detail-icon');
  const detailTitle = document.getElementById('detail-title');
  const detailSubtitle = document.getElementById('detail-subtitle');
  const detailDesc = document.getElementById('detail-desc');
  const detailTags = document.getElementById('detail-tags');

  function updateDetailPanel(skill) {
    if (!detailCard || !skill) return;

    detailCard.classList.remove('active');
    
    setTimeout(() => {
      detailIcon.textContent = skill.icon;
      detailTitle.textContent = skill.label;
      detailSubtitle.textContent = skill.subtitle;
      detailDesc.textContent = skill.desc;
      
      // Update substack tags
      detailTags.innerHTML = '';
      skill.tags.forEach(tag => {
        const span = document.createElement('span');
        span.className = 'tag';
        span.textContent = tag;
        detailTags.appendChild(span);
      });
      
      detailCard.classList.add('active');
    }, 150);
  }

  // Drag & Flick Mechanics
  function getMousePos(e) {
    const rect = canvas.getBoundingClientRect();
    const clientX = e.touches ? e.touches[0].clientX : e.clientX;
    const clientY = e.touches ? e.touches[0].clientY : e.clientY;
    return {
      x: clientX - rect.left,
      y: clientY - rect.top
    };
  }

  function handleStart(e) {
    isMouseDown = true;
    const pos = getMousePos(e);
    mouse.x = pos.x;
    mouse.y = pos.y;
    mouse.lastX = pos.x;
    mouse.lastY = pos.y;

    // Check hit test
    for (let i = balls.length - 1; i >= 0; i--) {
      const b = balls[i];
      const dist = Math.hypot(b.x - mouse.x, b.y - mouse.y);
      if (dist < b.radius) {
        draggedBall = b;
        b.isDragged = true;
        b.vx = 0;
        b.vy = 0;
        updateDetailPanel(b.data);
        break;
      }
    }
  }

  function handleMove(e) {
    const pos = getMousePos(e);
    mouse.x = pos.x;
    mouse.y = pos.y;

    // Calculate drag velocity for throwing
    mouse.vx = mouse.x - mouse.lastX;
    mouse.vy = mouse.y - mouse.lastY;
    mouse.lastX = mouse.x;
    mouse.lastY = mouse.y;

    // Update active highlight on hovering balls (if not dragging)
    if (!draggedBall && isMouseDown === false) {
      for (let b of balls) {
        const dist = Math.hypot(b.x - mouse.x, b.y - mouse.y);
        if (dist < b.radius) {
          canvas.style.cursor = 'pointer';
          break;
        } else {
          canvas.style.cursor = 'grab';
        }
      }
    }
  }

  function handleEnd() {
    isMouseDown = false;
    if (draggedBall) {
      draggedBall.isDragged = false;
      // Throw with velocity capping
      draggedBall.vx = Math.max(-15, Math.min(15, mouse.vx * 0.7));
      draggedBall.vy = Math.max(-15, Math.min(15, mouse.vy * 0.7));
      draggedBall = null;
    }
  }

  // Hover detection to update panel
  canvas.addEventListener('mousemove', (e) => {
    if (draggedBall) return;
    const pos = getMousePos(e);
    for (let b of balls) {
      const dist = Math.hypot(b.x - pos.x, b.y - pos.y);
      if (dist < b.radius) {
        if (canvas.dataset.hoveredBallId !== b.data.label) {
          canvas.dataset.hoveredBallId = b.data.label;
          updateDetailPanel(b.data);
        }
        return;
      }
    }
  });

  // Attach mouse listeners
  canvas.addEventListener('mousedown', handleStart);
  canvas.addEventListener('mousemove', handleMove);
  window.addEventListener('mouseup', handleEnd);

  // Attach touch listeners (mobile support)
  canvas.addEventListener('touchstart', handleStart, { passive: true });
  canvas.addEventListener('touchmove', handleMove, { passive: true });
  window.addEventListener('touchend', handleEnd);

  // Kick off engine loop
  setup();
  resize();
  window.addEventListener('resize', resize);

  function loop() {
    ctx.clearRect(0, 0, width, height);

    balls.forEach(ball => {
      ball.update();
    });

    resolveCollisions();

    balls.forEach(ball => {
      ball.draw(ctx);
    });

    requestAnimationFrame(loop);
  }

  loop();
})();

/* ── TOOLKIT TECH GRID MOUSE GLOW & 3D TILT ── */
(function() {
  const cards = document.querySelectorAll('.tech-card');
  if (!cards.length) return;

  cards.forEach(card => {
    card.addEventListener('mousemove', (e) => {
      const rect = card.getBoundingClientRect();
      const x = e.clientX - rect.left;
      const y = e.clientY - rect.top;

      // Update CSS variables for radial glow center
      card.style.setProperty('--x', `${x}px`);
      card.style.setProperty('--y', `${y}px`);

      // 3D perspective tilt calculations
      const centerX = rect.width / 2;
      const centerY = rect.height / 2;
      const rotateY = ((x - centerX) / centerX) * 8; // Max 8 deg horizontal
      const rotateX = -((y - centerY) / centerY) * 8; // Max 8 deg vertical

      // Smoothly tilt the card
      card.style.transform = `rotateX(${rotateX}deg) rotateY(${rotateY}deg) translateY(-5px)`;
    });

    card.addEventListener('mouseleave', () => {
      // Reset position on leave
      card.style.transform = 'rotateX(0deg) rotateY(0deg) translateY(0px)';
    });
  });
})();

/* ── WHY WORK WITH ME ACCORDION SLIDER ── */
(function() {
  const items = document.querySelectorAll('.why-accordion-menu .accordion-item');
  const previews = document.querySelectorAll('.display-viewport .viewport-preview');

  if (!items.length) return;

  function setActive(prop) {
    // Update active class on menu items
    items.forEach(item => {
      if (item.dataset.prop === prop) {
        item.classList.add('active');
      } else {
        item.classList.remove('active');
      }
    });

    // Update active class on preview displays
    previews.forEach(p => {
      if (p.classList.contains(`preview-${prop}`)) {
        p.classList.add('active');
      } else {
        p.classList.remove('active');
      }
    });
  }

  items.forEach(item => {
    // Trigger on hover for premium fluid responsiveness
    item.addEventListener('mouseenter', () => {
      setActive(item.dataset.prop);
    });

    // Trigger on click for accessibility
    item.addEventListener('click', () => {
      setActive(item.dataset.prop);
    });
  });
})();

/* ── MOBILE NAVBAR TOGGLER ── */
(function() {
  const toggleBtn = document.getElementById('mobile-toggle');
  const navLinks = document.querySelector('.nav-links');
  const navLinksList = document.querySelectorAll('.nav-links a');

  if (!toggleBtn || !navLinks) return;

  toggleBtn.addEventListener('click', () => {
    toggleBtn.classList.toggle('open');
    navLinks.classList.toggle('open');
  });

  // Close menu when clicking links
  navLinksList.forEach(link => {
    link.addEventListener('click', () => {
      toggleBtn.classList.remove('open');
      navLinks.classList.remove('open');
    });
  });
})();



