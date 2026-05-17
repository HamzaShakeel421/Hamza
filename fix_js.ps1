$jsPath = 'c:\Users\Mian Hamza\Downloads\My Portfolio website\script.js'
$js = [System.IO.File]::ReadAllText($jsPath)

# 1. Update cursor colors
$js = $js.Replace('rgba(59,130,246,.3)', 'rgba(207,151,53,.3)')
$js = $js.Replace('rgba(59,130,246,.5)', 'rgba(207,151,53,.5)')

# 2. Append Swiper Init
$swiperJs = @"

/* ── SWIPER INIT ── */
document.addEventListener('DOMContentLoaded', () => {
  const swiper = new Swiper('.mySwiper', {
    slidesPerView: 1,
    spaceBetween: 30,
    loop: true,
    autoplay: {
      delay: 4000,
      disableOnInteraction: false,
    },
    pagination: {
      el: '.swiper-pagination',
      clickable: true,
    },
    navigation: {
      nextEl: '.swiper-button-next',
      prevEl: '.swiper-button-prev',
    },
  });
});
"@

if (-not $js.Contains('SWIPER INIT')) {
    $js += $swiperJs
}

[System.IO.File]::WriteAllText($jsPath, $js)
Write-Output "JS updated successfully"
