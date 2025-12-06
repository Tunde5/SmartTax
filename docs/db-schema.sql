-- SmartTax MySQL schema (no HMRC integration)
-- Default charset and engine
SET NAMES utf8mb4;
SET time_zone = '+00:00';

CREATE TABLE users (
  id CHAR(36) NOT NULL,
  email VARCHAR(191) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  name VARCHAR(191),
  role ENUM('user','admin') NOT NULL DEFAULT 'user',
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_users_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE sessions (
  id CHAR(36) NOT NULL,
  user_id CHAR(36) NOT NULL,
  expires_at DATETIME NOT NULL,
  mfa_verified TINYINT(1) NOT NULL DEFAULT 0,
  created_at DATETIME NOT NULL,
  last_seen_at DATETIME,
  PRIMARY KEY (id),
  KEY fk_sessions_user (user_id),
  CONSTRAINT fk_sessions_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE faq_categories (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(191) NOT NULL,
  order_index INT UNSIGNED DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE faq_articles (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  category_id BIGINT UNSIGNED NOT NULL,
  question VARCHAR(255) NOT NULL,
  answer TEXT NOT NULL,
  version_label VARCHAR(64),
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_faq_category (category_id),
  CONSTRAINT fk_faq_category FOREIGN KEY (category_id) REFERENCES faq_categories (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE news_posts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  slug VARCHAR(191) NOT NULL,
  excerpt VARCHAR(500),
  body LONGTEXT NOT NULL,
  status ENUM('draft','published') NOT NULL DEFAULT 'draft',
  published_at DATETIME,
  user_id CHAR(36),
  PRIMARY KEY (id),
  UNIQUE KEY uq_news_slug (slug),
  KEY fk_news_user (user_id),
  CONSTRAINT fk_news_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE news_tags (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  type ENUM('tax change','feature','guidance') DEFAULT 'feature',
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE news_post_tags (
  post_id BIGINT UNSIGNED NOT NULL,
  tag_id BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (post_id, tag_id),
  KEY fk_news_tag (tag_id),
  CONSTRAINT fk_news_post FOREIGN KEY (post_id) REFERENCES news_posts (id) ON DELETE CASCADE,
  CONSTRAINT fk_news_tag FOREIGN KEY (tag_id) REFERENCES news_tags (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE policy_versions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  type ENUM('terms','privacy') NOT NULL,
  version_label VARCHAR(64),
  content LONGTEXT NOT NULL,
  published_at DATETIME NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE contact_messages (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36),
  name VARCHAR(191) NOT NULL,
  email VARCHAR(191) NOT NULL,
  subject VARCHAR(255) NOT NULL,
  message TEXT NOT NULL,
  attachment_url VARCHAR(500),
  status ENUM('open','closed') NOT NULL DEFAULT 'open',
  created_at DATETIME NOT NULL,
  responded_at DATETIME,
  PRIMARY KEY (id),
  KEY fk_contact_user (user_id),
  CONSTRAINT fk_contact_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE newsletter_subscribers (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  email VARCHAR(191) NOT NULL,
  status ENUM('active','unsubscribed') NOT NULL DEFAULT 'active',
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_subscriber_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ledger_categories (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name VARCHAR(191) NOT NULL,
  type ENUM('income','expense') NOT NULL,
  hmrc_box VARCHAR(64),
  order_index INT UNSIGNED DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE ledger_entries (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  category_id BIGINT UNSIGNED NOT NULL,
  type ENUM('income','expense') NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  entry_date DATE NOT NULL,
  description VARCHAR(500),
  source ENUM('manual','csv','receipt') NOT NULL DEFAULT 'manual',
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_ledger_user (user_id),
  KEY fk_ledger_category (category_id),
  CONSTRAINT fk_ledger_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_ledger_category FOREIGN KEY (category_id) REFERENCES ledger_categories (id) ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE receipts (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  entry_id BIGINT UNSIGNED NOT NULL,
  file_url VARCHAR(500) NOT NULL,
  uploaded_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_receipt_entry (entry_id),
  CONSTRAINT fk_receipt_entry FOREIGN KEY (entry_id) REFERENCES ledger_entries (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE csv_imports (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  file_url VARCHAR(500) NOT NULL,
  status ENUM('pending','done','failed') NOT NULL DEFAULT 'pending',
  rows_processed INT UNSIGNED DEFAULT 0,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_csv_user (user_id),
  CONSTRAINT fk_csv_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tax_calculations (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  tax_year INT NOT NULL,
  total_income DECIMAL(12,2) NOT NULL,
  allowable_expenses DECIMAL(12,2) NOT NULL,
  personal_allowance_used TINYINT(1) NOT NULL DEFAULT 1,
  student_loan TINYINT(1) NOT NULL DEFAULT 0,
  pension TINYINT(1) NOT NULL DEFAULT 0,
  breakdown_json JSON,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_calc_user (user_id),
  CONSTRAINT fk_calc_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE filings (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  tax_year INT NOT NULL,
  status ENUM('draft','ready','submitted') NOT NULL DEFAULT 'draft',
  draft_payload JSON,
  submitted_at DATETIME,
  reference_code VARCHAR(100),
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_filing_user (user_id),
  CONSTRAINT fk_filing_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE filing_tasks (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  filing_id BIGINT UNSIGNED NOT NULL,
  label VARCHAR(255) NOT NULL,
  status ENUM('todo','done') NOT NULL DEFAULT 'todo',
  order_index INT UNSIGNED DEFAULT 0,
  PRIMARY KEY (id),
  KEY fk_task_filing (filing_id),
  CONSTRAINT fk_task_filing FOREIGN KEY (filing_id) REFERENCES filings (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE filing_documents (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  filing_id BIGINT UNSIGNED NOT NULL,
  file_url VARCHAR(500) NOT NULL,
  type ENUM('pdf','export','evidence') NOT NULL,
  uploaded_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_doc_filing (filing_id),
  CONSTRAINT fk_doc_filing FOREIGN KEY (filing_id) REFERENCES filings (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE payment_schedules (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  tax_year INT NOT NULL,
  due_date DATE NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  status ENUM('planned','paid') NOT NULL DEFAULT 'planned',
  PRIMARY KEY (id),
  KEY fk_schedule_user (user_id),
  CONSTRAINT fk_schedule_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE payment_transactions (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  schedule_id BIGINT UNSIGNED,
  paid_at DATETIME NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  method VARCHAR(100),
  receipt_url VARCHAR(500),
  PRIMARY KEY (id),
  KEY fk_payment_user (user_id),
  KEY fk_payment_schedule (schedule_id),
  CONSTRAINT fk_payment_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE,
  CONSTRAINT fk_payment_schedule FOREIGN KEY (schedule_id) REFERENCES payment_schedules (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tax_year_summaries (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  tax_year INT NOT NULL,
  income_total DECIMAL(12,2) NOT NULL DEFAULT 0,
  expense_total DECIMAL(12,2) NOT NULL DEFAULT 0,
  tax_due DECIMAL(12,2) NOT NULL DEFAULT 0,
  generated_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_summary_user (user_id),
  CONSTRAINT fk_summary_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE report_exports (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id CHAR(36) NOT NULL,
  tax_year INT NOT NULL,
  format ENUM('csv','pdf') NOT NULL,
  file_url VARCHAR(500) NOT NULL,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY fk_report_user (user_id),
  CONSTRAINT fk_report_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
