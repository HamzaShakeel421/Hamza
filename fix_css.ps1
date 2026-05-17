$cssPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\style.css'
$css = [System.IO.File]::ReadAllText($cssPath)

# 1. Update Hero padding and min-height
$css = $css -replace 'padding:120px 5vw 40px;', 'padding:100px 5vw 20px;'
$css = $css -replace 'min-height:100vh;', 'min-height:85vh;'

# 2. Replace Projects CSS
$swiperCss = @"
/* ══ PROJECTS (SWIPER) ══ */
#projects{background:var(--bg2);}
.swiper { width: 100%; padding-bottom: 3.5rem; overflow: hidden; position: relative; }
.swiper-slide { height: auto; }
.proj-c{
  background:var(--card);border:1px solid var(--border);
  border-radius:var(--r2);overflow:hidden;
  transition:.35s;position:relative;
  display:flex;align-items:stretch;
  height: 100%;
}
.proj-c:hover{
  border-color:var(--gold);
  box-shadow:0 20px 60px rgba(0,0,0,.6),0 0 30px rgba(207,151,53,.15);
}
.proj-mock{
  width:50%;position:relative;overflow:hidden;
  border-right:1px solid var(--border);flex-shrink:0;
}
.mock-img{width:100%;height:100%;display:block;object-fit:cover;transition: transform 0.6s ease;}
.proj-c:hover .mock-img { transform: scale(1.05); }
.proj-overlay{
  position:absolute;inset:0;background:rgba(8,6,4,.6);
  display:flex;justify-content:center;align-items:center;
  opacity:0;transition:.3s;backdrop-filter:blur(4px);
}
.proj-c:hover .proj-overlay{opacity:1;}
.proj-view{
  background:var(--text);color:var(--bg);padding:.6rem 1.4rem;
  border-radius:50px;font-weight:700;font-size:.8rem;text-decoration:none;
  transform:translateY(20px);transition:.3s;
}
.proj-c:hover .proj-view{transform:translateY(0);}
.proj-body{padding:3rem;width:50%;display:flex;flex-direction:column;justify-content:center;}
.swiper-pagination-bullet { background: var(--muted); opacity: 1; transition: .3s; }
.swiper-pagination-bullet-active { background: var(--gold); width: 24px; border-radius: 8px; }
.swiper-button-next, .swiper-button-prev { color: var(--gold); top: 40%; }
.swiper-button-next::after, .swiper-button-prev::after { font-size: 1.5rem; font-weight: bold; }
"@

$css = $css -replace '(?s)/\* ══ PROJECTS ══ \*/.*?\.proj-body.*?\}', $swiperCss

# Remove the responsive overrides that are no longer needed for the slider
$css = $css -replace '(?s)\.proj-grid\{gap:2rem;padding-bottom:0;\}.*?\.proj-body\{width:100%;padding:2rem;\}', '.proj-c{flex-direction:column;}.proj-mock{width:100%;height:250px;border-right:none;border-bottom:1px solid var(--border);}.proj-body{width:100%;padding:2rem;}'

[System.IO.File]::WriteAllText($cssPath, $css)
Write-Output "CSS updated successfully"
