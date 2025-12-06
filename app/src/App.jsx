import { useState } from 'react'
import './App.css'

const pages = [
  {
    id: 'home',
    title: 'Home',
    eyebrow: 'SmartTax',
    blurb: 'Simple, transparent tax guidance built for busy people and small teams.',
    points: ['See what’s changing, what to file, and when to act.'],
  },
  {
    id: 'about',
    title: 'About',
    eyebrow: 'Who we are',
    blurb: 'We are a small team of tax specialists and product folks who want filings to feel routine—not stressful.',
    points: ['Human-first support', 'Plain-language answers', 'Software that stays out of your way'],
  },
  {
    id: 'services',
    title: 'Services',
    eyebrow: 'What we offer',
    blurb: 'Pick the level of help you need; we combine guided software with human review.',
    points: ['Onboarding and entity setup', 'Quarterly and annual filing prep', 'Notice response templates', 'One-off consults with specialists'],
  },
  {
    id: 'news',
    title: 'News',
    eyebrow: 'Updates',
    blurb: 'New features ship weekly; we share short releases so you know what changed.',
    points: [
      'Dashboard reminders now surface deadlines by jurisdiction.',
      'New importer for payroll and 1099 data to cut manual entry.',
      'Privacy controls tightened; access logs now available in settings.',
    ],
  },
  {
    id: 'contact',
    title: 'Contact',
    eyebrow: 'Let’s talk',
    blurb: 'Reach us however is easiest; we respond within one business day.',
    points: ['Email: hello@smarttax.example', 'Phone: +1 (555) 123-4567', 'Office: 123 Market Street, Suite 400'],
  },
  {
    id: 'privacy',
    title: 'Privacy Policy',
    eyebrow: 'Your data',
    blurb: 'We collect only what we need to deliver filings, never sell data, and give you export/delete controls.',
    points: ['Data encryption at rest and in transit', 'Access limited to vetted staff', 'Full audit log available on request'],
  },
  {
    id: 'terms',
    title: 'Terms of Service',
    eyebrow: 'The essentials',
    blurb: 'Using SmartTax means you agree to our fair-use and compliance standards.',
    points: [
      'You keep ownership of uploaded documents.',
      'We provide guidance but final filings remain your responsibility unless contracted otherwise.',
      'Service may evolve; we will notify you of material changes.',
    ],
  },
]

export default function App() {
  const [activePage, setActivePage] = useState('home')
  const currentPage = pages.find((page) => page.id === activePage) ?? pages[0]

  return (
    <div className="app">
      <header className="top-bar">
        <div>
          <p className="logo">SmartTax</p>
          <p className="tagline">Clarity-first tax experience</p>
        </div>
        <nav>
          <ul className="nav-list">
            {pages.map((page) => (
              <li key={page.id}>
                <button
                  type="button"
                  className={`nav-link ${page.id === activePage ? 'active' : ''}`}
                  onClick={() => setActivePage(page.id)}
                >
                  {page.title}
                </button>
              </li>
            ))}
          </ul>
        </nav>
      </header>

      <main className="layout">
        <section className="card">
          <p className="eyebrow">{currentPage.eyebrow}</p>
          <h1>{currentPage.title}</h1>
          <p className="lede">{currentPage.blurb}</p>
          <ul className="points">
            {currentPage.points.map((point) => (
              <li key={point}>{point}</li>
            ))}
          </ul>
        </section>

        <section className="info">
          <div className="info-block">
            <p className="eyebrow">Need help?</p>
            <p className="info-text">
              Switch tabs above to see details for each page. Ready to file? Start from Home or Contact to talk with us.
            </p>
          </div>
          <div className="info-block highlight">
            <p className="eyebrow">Next steps</p>
            <p className="info-text">Invite your team, add entities, and set your filing deadlines so reminders stay accurate.</p>
          </div>
        </section>
      </main>
    </div>
  )
}
