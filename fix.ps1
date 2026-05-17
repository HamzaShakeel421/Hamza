$replacements = @{
    '#3b82f6' = '#CF9735'; '#60a5fa' = '#E1A558'; '59,130,246' = '207,151,53'; '#1e3a5f' = '#592D14';
    '#06b6d4' = '#A25F28'; '6,182,212' = '162,95,40'; '#10b981' = '#CF9735'; '#34d399' = '#E1A558';
    '16,185,129' = '207,151,53'; '#059669' = '#694928'; '#047857' = '#592D14'; '#052e16' = '#140c08';
    '#0f2e1e' = '#1a100b'; '#28c840' = '#CF9735'; '#7c3aed' = '#A25F28'; '124,58,237' = '162,95,40';
    '#f59e0b' = '#CF9735'; '245,158,11' = '207,151,53'; '#fbbf24' = '#E1A558'; '#febc2e' = '#E1A558';
    '#ff5f57' = '#592D14'; '#ef4444' = '#A25F28'; '#03071e' = '#140c08'; '#0d1f3c' = '#1a100b';
    '#0a1628' = '#140c08'; '#162032' = '#1a100b'; '#1e3a4a' = '#1a100b'; '#142a38' = '#140c08';
    '#080b12' = '#140c08'; '#0f172a' = '#1a100b'; '#0a0a0a' = '#080604'; '#1a1a2e' = '#140c08';
    'rgba(0,0,0,.2)' = 'rgba(8,6,4,.2)'
}

$html = [System.IO.File]::ReadAllText('index.html')
$css = [System.IO.File]::ReadAllText('style.css')

foreach ($key in $replacements.Keys) {
    $html = $html.Replace($key, $replacements[$key])
    $css = $css.Replace($key, $replacements[$key])
}

[System.IO.File]::WriteAllText('index.html', $html)
[System.IO.File]::WriteAllText('style.css', $css)
Write-Output 'Colors completely swept via PowerShell'
