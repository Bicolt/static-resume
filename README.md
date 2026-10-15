# Nicolas Benning — Multi-Implementation Resume

> Modernized, data-driven resume repository featuring an interactive web app, official JSON Resume themes, and high-precision Typst ATS PDF exports.

[![Deploy to GitHub Pages](https://github.com/Bicolt/static-resume/actions/workflows/deploy.yml/badge.svg)](https://github.com/Bicolt/static-resume/actions/workflows/deploy.yml)
[![JSON Resume Standard](https://img.shields.io/badge/JSON%20Resume-Standard-blue.svg)](https://jsonresume.org)
[![Typst](https://img.shields.io/badge/PDF%20Engine-Typst%200.15-239dad.svg)](https://typst.app)

---

## 🎯 Architecture: Single Source of Truth

All resume content is stored in standardized JSON files adhering to the official [JSON Resume schema](https://jsonresume.org/schema/):
- **[`data/resume.fr.json`](data/resume.fr.json)** — French resume data.
- **[`data/resume.en.json`](data/resume.en.json)** — English resume data.

Editing either file automatically updates all 3 implementations!

---

## 🚀 Implementations Included

### 1. 🌐 Modern Interactive Web App (`index.html`)
- **Interactive Language Toggle**: Instant client-side switching between **FR** and **EN**.
- **Dark / Light Theme**: Detects system preference + manual toggle button.
- **Interactive Skill Filter**: Click any skill badge (e.g. `C#`, `TypeScript`, `ELK Stack`) to highlight the jobs where it was applied.
- **Print / PDF Optimization**: Clean `@media print` rules ensuring clean margins and exact page breaks when using browser print (`Ctrl + P`).
- **Zero-Toolchain**: Can be opened directly in any browser (`file:///...`) or served statically.

### 2. 📄 Executive ATS PDF (`typst/`)
- Powered by [Typst](https://typst.app), the high-performance modern alternative to LaTeX.
- Compiles directly to clean 2-page ATS-optimized PDFs in milliseconds.
- Outputs:
  - `dist/typst/resume-fr.pdf`
  - `dist/typst/resume-en.pdf`

### 3. 📜 Official JSON Resume Themes (`dist/jsonresume/`)
- Uses [`resumed`](https://github.com/jsonresume/resumed) to render official open-source community themes:
  - **Even** (`dist/jsonresume/even-fr.html` / `even-en.html`)
  - **Elegant** (`dist/jsonresume/elegant-fr.html` / `elegant-en.html`)
  - **StackOverflow** (`dist/jsonresume/stackoverflow-fr.html` / `stackoverflow-en.html`)

---

## 🛠️ Quick Start & Local Development

### Prerequisites
- [Node.js](https://nodejs.org) (v20+)
- [Typst CLI](https://github.com/typst/typst) (`winget install Typst.Typst` or `brew install typst`)

### Install Dependencies
```bash
npm install
```

### Build Everything (Web, JSON Resume themes & Typst PDFs)
```bash
npm run build
```

### Local Live Preview
```bash
npm run dev
# Or simply open index.html in your browser!
```

---

## 📂 Repository Structure

```text
├── data/
│   ├── resume.fr.json         # Single source of truth (FR) - JSON Resume spec
│   └── resume.en.json         # Single source of truth (EN) - JSON Resume spec
├── typst/
│   ├── template.typ           # Modular Typst design template
│   ├── resume_fr.typ          # French Typst entry point
│   └── resume_en.typ          # English Typst entry point
├── dist/
│   ├── typst/                 # Compiled PDFs & SVG previews
│   └── jsonresume/            # Rendered JSON Resume theme pages
├── scripts/
│   └── build.js               # Multi-target build orchestrator
├── .github/workflows/
│   └── deploy.yml             # GitHub Actions CI/CD to GitHub Pages
├── index.html                 # Interactive Web Resume & showcase viewer
├── photo_kds.png              # Avatar photo
└── package.json               # Scripts & theme dependencies
```

---

## 📜 License
MIT License.
