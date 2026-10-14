const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🚀 Starting Multi-Implementation Build...\n');

// 1. Ensure dist directories exist
const distDir = path.join(__dirname, '..', 'dist');
const jsonresumeDir = path.join(distDir, 'jsonresume');
const typstDir = path.join(distDir, 'typst');

[distDir, jsonresumeDir, typstDir].forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 2. Refresh index.html with latest JSON data
console.log('📦 Injecting latest JSON data into index.html...');
const frData = fs.readFileSync(path.join(__dirname, '..', 'data', 'resume.fr.json'), 'utf8');
const enData = fs.readFileSync(path.join(__dirname, '..', 'data', 'resume.en.json'), 'utf8');

let indexHtml = fs.readFileSync(path.join(__dirname, '..', 'index.html'), 'utf8');

// Replace script contents
indexHtml = indexHtml.replace(/<script id="data-fr" type="application\/json">[\s\S]*?<\/script>/, `<script id="data-fr" type="application/json">\n${frData}\n  </script>`);
indexHtml = indexHtml.replace(/<script id="data-en" type="application\/json">[\s\S]*?<\/script>/, `<script id="data-en" type="application/json">\n${enData}\n  </script>`);
fs.writeFileSync(path.join(__dirname, '..', 'index.html'), indexHtml);
console.log('✅ index.html updated.');

// 3. Compile JSON Resume themes
console.log('\n🎨 Compiling JSON Resume themes (Even, Elegant, Stackoverflow)...');
const themes = ['jsonresume-theme-even', 'jsonresume-theme-elegant', 'jsonresume-theme-stackoverflow'];
const langs = [
  { code: 'fr', file: 'data/resume.fr.json' },
  { code: 'en', file: 'data/resume.en.json' }
];

themes.forEach(theme => {
  const shortTheme = theme.replace('jsonresume-theme-', '');
  langs.forEach(lang => {
    const outFile = path.join(jsonresumeDir, `${shortTheme}-${lang.code}.html`);
    try {
      execSync(`npx resumed render ${lang.file} --theme ${theme} -o ${outFile}`, { stdio: 'pipe' });
      console.log(`   ✓ ${shortTheme} [${lang.code.toUpperCase()}] -> dist/jsonresume/${shortTheme}-${lang.code}.html`);
    } catch (e) {
      console.error(`   ✗ Error rendering ${theme} (${lang.code}):`, e.message);
    }
  });
});

// 4. Compile Typst PDFs
console.log('\n📄 Compiling Typst PDFs...');
try {
  execSync('typst compile --root . typst/resume_fr.typ dist/typst/resume-fr.pdf', { stdio: 'inherit' });
  console.log('   ✓ Typst FR PDF -> dist/typst/resume-fr.pdf');
  execSync('typst compile --root . typst/resume_en.typ dist/typst/resume-en.pdf', { stdio: 'inherit' });
  console.log('   ✓ Typst EN PDF -> dist/typst/resume-en.pdf');
} catch (e) {
  console.error('   ✗ Error compiling Typst PDFs:', e.message);
}

console.log('\n🎉 Build Complete! All implementations ready.\n');
