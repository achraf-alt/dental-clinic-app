-- ============================================
-- Medical Cabinet Management System - Schema
-- ============================================

-- Base Entity (Abstract)
-- This serves as a template for common fields
-- Not created as actual table, but fields inherited by other tables

-- ============================================
-- USER MANAGEMENT
-- ============================================

CREATE TABLE USERS (
                       user_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(255) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       address TEXT,
                       postal_code VARCHAR(20),
                       phone VARCHAR(50),
                       gender ENUM('MALE', 'FEMALE', 'OTHER') NOT NULL,
                       login VARCHAR(100) UNIQUE NOT NULL,
                       password VARCHAR(255) NOT NULL,
                       last_login_date DATE,
                       birth_date DATE,
                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                       last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       modified_by VARCHAR(255),
                       created_by VARCHAR(255)
);

CREATE TABLE ROLES (
                       role_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                       label VARCHAR(100) NOT NULL,
                       privileges TEXT, -- JSON or comma-separated list of privileges
                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                       last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       modified_by VARCHAR(255),
                       created_by VARCHAR(255)
);

CREATE TABLE USER_ROLES (
                            user_id BIGINT,
                            role_id BIGINT,
                            PRIMARY KEY (user_id, role_id),
                            FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE,
                            FOREIGN KEY (role_id) REFERENCES ROLES(role_id) ON DELETE CASCADE
);

-- Staff (inherits from Users)
CREATE TABLE STAFF (
                       staff_id BIGINT PRIMARY KEY,
                       salary DOUBLE,
                       bonus DOUBLE,
                       recruitment_date DATE,
                       remaining_leave INT,
                       FOREIGN KEY (staff_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- Doctor (inherits from Staff)
CREATE TABLE DOCTORS (
                         doctor_id BIGINT PRIMARY KEY,
                         specialty VARCHAR(255),
                         FOREIGN KEY (doctor_id) REFERENCES STAFF(staff_id) ON DELETE CASCADE
);

-- Secretary (inherits from Staff)
CREATE TABLE SECRETARIES (
                             secretary_id BIGINT PRIMARY KEY,
                             cnss_number VARCHAR(100),
                             commission DOUBLE,
                             FOREIGN KEY (secretary_id) REFERENCES STAFF(staff_id) ON DELETE CASCADE
);

-- Admin (inherits from Users)
CREATE TABLE ADMINS (
                        admin_id BIGINT PRIMARY KEY,
                        FOREIGN KEY (admin_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- ============================================
-- MEDICAL CABINET
-- ============================================

CREATE TABLE MEDICAL_CABINETS (
                                  cabinet_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                  owner_id BIGINT NOT NULL,
                                  name VARCHAR(255) NOT NULL,
                                  email VARCHAR(255),
                                  logo VARCHAR(500),
                                  address TEXT,
                                  postal_code VARCHAR(20),
                                  phone1 VARCHAR(50),
                                  phone2 VARCHAR(50),
                                  website VARCHAR(255),
                                  instagram VARCHAR(255),
                                  facebook VARCHAR(255),
                                  description TEXT,
                                  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                  last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                  modified_by VARCHAR(255),
                                  created_by VARCHAR(255),
                                  FOREIGN KEY (owner_id) REFERENCES USERS(user_id)
);

-- ============================================
-- FINANCIAL MANAGEMENT
-- ============================================

CREATE TABLE CHARGES (
                         charge_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                         cabinet_id BIGINT NOT NULL,
                         title VARCHAR(255) NOT NULL,
                         description TEXT,
                         amount DOUBLE NOT NULL,
                         charge_date DATETIME NOT NULL,
                         created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                         last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         modified_by VARCHAR(255),
                         created_by VARCHAR(255),
                         FOREIGN KEY (cabinet_id) REFERENCES MEDICAL_CABINETS(cabinet_id) ON DELETE CASCADE
);

CREATE TABLE REVENUES (
                          revenue_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          cabinet_id BIGINT NOT NULL,
                          title VARCHAR(255) NOT NULL,
                          description TEXT,
                          amount DOUBLE NOT NULL,
                          revenue_date DATETIME NOT NULL,
                          created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                          last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          modified_by VARCHAR(255),
                          created_by VARCHAR(255),
                          FOREIGN KEY (cabinet_id) REFERENCES MEDICAL_CABINETS(cabinet_id) ON DELETE CASCADE
);

CREATE TABLE STATISTICS (
                            statistic_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                            cabinet_id BIGINT NOT NULL,
                            name VARCHAR(255) NOT NULL,
                            category ENUM('FINANCIAL', 'PATIENTS', 'APPOINTMENTS', 'OTHER'),
                            value DOUBLE,
                            calculation_date DATE,
                            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                            last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            modified_by VARCHAR(255),
                            created_by VARCHAR(255),
                            FOREIGN KEY (cabinet_id) REFERENCES MEDICAL_CABINETS(cabinet_id) ON DELETE CASCADE
);

-- ============================================
-- SCHEDULING
-- ============================================

CREATE TABLE MONTHLY_SCHEDULES (
                                   schedule_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                   cabinet_id BIGINT NOT NULL,
                                   month ENUM('JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE',
               'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'),
                                   unavailable_days TEXT, -- JSON array of days
                                   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                   last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                   modified_by VARCHAR(255),
                                   created_by VARCHAR(255),
                                   FOREIGN KEY (cabinet_id) REFERENCES MEDICAL_CABINETS(cabinet_id) ON DELETE CASCADE
);

-- ============================================
-- NOTIFICATIONS
-- ============================================

CREATE TABLE NOTIFICATIONS (
                               notification_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                               user_id BIGINT NOT NULL,
                               title ENUM('APPOINTMENT', 'PAYMENT', 'REMINDER', 'ALERT', 'OTHER'),
                               message TEXT,
                               notification_date DATE,
                               notification_time TIME,
                               type ENUM('SMS', 'EMAIL', 'PUSH', 'IN_APP'),
                               priority ENUM('LOW', 'MEDIUM', 'HIGH', 'URGENT'),
                               created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                               last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               modified_by VARCHAR(255),
                               created_by VARCHAR(255),
                               FOREIGN KEY (user_id) REFERENCES USERS(user_id) ON DELETE CASCADE
);

-- ============================================
-- PATIENT MANAGEMENT
-- ============================================

CREATE TABLE PATIENTS (
                          patient_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(255) NOT NULL,
                          birth_date DATE,
                          gender ENUM('MALE', 'FEMALE', 'OTHER'),
                          address TEXT,
                          phone VARCHAR(50),
                          insurance ENUM('CNSS', 'CNOPS', 'PRIVATE', 'NONE'),
                          created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                          last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          modified_by VARCHAR(255),
                          created_by VARCHAR(255)
);

CREATE TABLE MEDICAL_HISTORY (
                                 history_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                 patient_id BIGINT NOT NULL,
                                 antecedent_id BIGINT,
                                 name VARCHAR(255),
                                 category VARCHAR(100),
                                 risk_level ENUM('LOW', 'MEDIUM', 'HIGH', 'CRITICAL'),
                                 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                 last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 modified_by VARCHAR(255),
                                 created_by VARCHAR(255),
                                 FOREIGN KEY (patient_id) REFERENCES PATIENTS(patient_id) ON DELETE CASCADE
);

-- ============================================
-- MEDICAL RECORDS
-- ============================================

CREATE TABLE MEDICAL_RECORDS (
                                 record_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                 patient_id BIGINT NOT NULL,
                                 creation_date DATE,
                                 created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                 last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 modified_by VARCHAR(255),
                                 created_by VARCHAR(255),
                                 FOREIGN KEY (patient_id) REFERENCES PATIENTS(patient_id) ON DELETE CASCADE
);

CREATE TABLE CONSULTATIONS (
                               consultation_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                               record_id BIGINT NOT NULL,
                               consultation_date DATE,
                               status ENUM('SCHEDULED', 'COMPLETED', 'CANCELLED', 'NO_SHOW'),
                               doctor_observation TEXT,
                               created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                               last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               modified_by VARCHAR(255),
                               created_by VARCHAR(255),
                               FOREIGN KEY (record_id) REFERENCES MEDICAL_RECORDS(record_id) ON DELETE CASCADE
);

CREATE TABLE APPOINTMENTS (
                              appointment_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                              record_id BIGINT NOT NULL,
                              doctor_id BIGINT NOT NULL,
                              appointment_date DATE,
                              appointment_time TIME,
                              reason TEXT,
                              status ENUM('SCHEDULED', 'CONFIRMED', 'CANCELLED', 'COMPLETED', 'NO_SHOW'),
                              doctor_note TEXT,
                              created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                              last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              modified_by VARCHAR(255),
                              created_by VARCHAR(255),
                              FOREIGN KEY (record_id) REFERENCES MEDICAL_RECORDS(record_id) ON DELETE CASCADE,
                              FOREIGN KEY (doctor_id) REFERENCES DOCTORS(doctor_id)
);

CREATE TABLE DOCTOR_INTERVENTIONS (
                                      intervention_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                      consultation_id BIGINT NOT NULL,
                                      patient_price DOUBLE,
                                      tooth_number INT,
                                      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                      last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      modified_by VARCHAR(255),
                                      created_by VARCHAR(255),
                                      FOREIGN KEY (consultation_id) REFERENCES CONSULTATIONS(consultation_id) ON DELETE CASCADE
);

CREATE TABLE MEDICAL_ACTS (
                              act_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                              intervention_id BIGINT NOT NULL,
                              label VARCHAR(255),
                              category VARCHAR(100),
                              base_price DOUBLE,
                              created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                              last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              modified_by VARCHAR(255),
                              created_by VARCHAR(255),
                              FOREIGN KEY (intervention_id) REFERENCES DOCTOR_INTERVENTIONS(intervention_id) ON DELETE CASCADE
);

-- ============================================
-- PRESCRIPTIONS & MEDICATIONS
-- ============================================

CREATE TABLE PRESCRIPTIONS (
                               prescription_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                               order_id BIGINT NOT NULL,
                               quantity INT,
                               frequency VARCHAR(100),
                               duration_in_days INT,
                               created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                               last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               modified_by VARCHAR(255),
                               created_by VARCHAR(255)
);

CREATE TABLE MEDICATIONS (
                             medication_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                             prescription_id BIGINT NOT NULL,
                             name VARCHAR(255) NOT NULL,
                             laboratory VARCHAR(255),
                             type VARCHAR(100),
                             form ENUM('TABLET', 'CAPSULE', 'SYRUP', 'INJECTION', 'CREAM', 'OTHER'),
                             reimbursable BOOLEAN DEFAULT FALSE,
                             unit_price DOUBLE,
                             description TEXT,
                             created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                             last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                             modified_by VARCHAR(255),
                             created_by VARCHAR(255),
                             FOREIGN KEY (prescription_id) REFERENCES PRESCRIPTIONS(prescription_id) ON DELETE CASCADE
);

CREATE TABLE ORDERS (
                        order_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                        record_id BIGINT NOT NULL,
                        order_date DATE,
                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        modified_by VARCHAR(255),
                        created_by VARCHAR(255),
                        FOREIGN KEY (record_id) REFERENCES MEDICAL_RECORDS(record_id) ON DELETE CASCADE
);

-- Link prescriptions to orders
ALTER TABLE PRESCRIPTIONS
    ADD FOREIGN KEY (order_id) REFERENCES ORDERS(order_id) ON DELETE CASCADE;

-- ============================================
-- CERTIFICATES
-- ============================================

CREATE TABLE CERTIFICATES (
                              certificate_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                              record_id BIGINT NOT NULL,
                              doctor_id BIGINT NOT NULL,
                              start_date DATE,
                              end_date DATE,
                              duration INT,
                              doctor_note TEXT,
                              created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                              last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              modified_by VARCHAR(255),
                              created_by VARCHAR(255),
                              FOREIGN KEY (record_id) REFERENCES MEDICAL_RECORDS(record_id) ON DELETE CASCADE,
                              FOREIGN KEY (doctor_id) REFERENCES DOCTORS(doctor_id)
);

-- ============================================
-- FINANCIAL RECORDS
-- ============================================

CREATE TABLE FINANCIAL_SITUATIONS (
                                      situation_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                                      record_id BIGINT NOT NULL,
                                      total_acts DOUBLE DEFAULT 0,
                                      total_paid DOUBLE DEFAULT 0,
                                      credit DOUBLE DEFAULT 0,
                                      status ENUM('PAID', 'PARTIAL', 'UNPAID'),
                                      on_promotion BOOLEAN DEFAULT FALSE,
                                      created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                                      last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      modified_by VARCHAR(255),
                                      created_by VARCHAR(255),
                                      FOREIGN KEY (record_id) REFERENCES MEDICAL_RECORDS(record_id) ON DELETE CASCADE
);

CREATE TABLE INVOICES (
                          invoice_id BIGINT PRIMARY KEY AUTO_INCREMENT,
                          situation_id BIGINT NOT NULL,
                          total_invoice DOUBLE NOT NULL,
                          total_paid DOUBLE DEFAULT 0,
                          remaining DOUBLE,
                          status ENUM('PAID', 'PARTIAL', 'UNPAID', 'CANCELLED'),
                          invoice_date DATETIME,
                          created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                          last_modified_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          modified_by VARCHAR(255),
                          created_by VARCHAR(255),
                          FOREIGN KEY (situation_id) REFERENCES FINANCIAL_SITUATIONS(situation_id) ON DELETE CASCADE
);

-- ============================================
-- INDEXES FOR PERFORMANCE
-- ============================================

CREATE INDEX idx_users_email ON USERS(email);
CREATE INDEX idx_users_login ON USERS(login);
CREATE INDEX idx_staff_recruitment ON STAFF(recruitment_date);
CREATE INDEX idx_patients_name ON PATIENTS(name);
CREATE INDEX idx_appointments_date ON APPOINTMENTS(appointment_date);
CREATE INDEX idx_consultations_date ON CONSULTATIONS(consultation_date);
CREATE INDEX idx_medical_records_patient ON MEDICAL_RECORDS(patient_id);
CREATE INDEX idx_notifications_user ON NOTIFICATIONS(user_id);
CREATE INDEX idx_charges_cabinet ON CHARGES(cabinet_id);
CREATE INDEX idx_revenues_cabinet ON REVENUES(cabinet_id);
CREATE INDEX idx_invoices_status ON INVOICES(status);
CREATE INDEX idx_appointments_doctor ON APPOINTMENTS(doctor_id);
CREATE INDEX idx_certificates_doctor ON CERTIFICATES(doctor_id);