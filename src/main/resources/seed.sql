-- ============================================
-- Medical Cabinet Management System - Seed Data
-- ============================================

-- ============================================
-- ROLES
-- ============================================

INSERT INTO ROLES (role_id, label, privileges, created_by) VALUES
                                                               (1, 'Administrator', 'FULL_ACCESS,USER_MANAGEMENT,SYSTEM_CONFIG', 'SYSTEM'),
                                                               (2, 'Doctor', 'VIEW_PATIENTS,CREATE_CONSULTATION,WRITE_PRESCRIPTION,VIEW_APPOINTMENTS', 'SYSTEM'),
                                                               (3, 'Secretary', 'VIEW_PATIENTS,MANAGE_APPOINTMENTS,MANAGE_BILLING', 'SYSTEM'),
                                                               (4, 'Patient', 'VIEW_OWN_RECORDS,VIEW_APPOINTMENTS,VIEW_PRESCRIPTIONS', 'SYSTEM');

-- ============================================
-- USERS
-- ============================================

-- Admin User
INSERT INTO USERS (user_id, name, email, address, postal_code, phone, gender, login, password, birth_date, created_by) VALUES
    (1, 'John Administrator', 'admin@medicalcabinet.com', '123 Admin Street', '10001', '+1-555-0001', 'MALE', 'admin', '$2a$10$encrypted_password_here', '1985-01-15', 'SYSTEM');

INSERT INTO ADMINS (admin_id) VALUES (1);

-- Doctors
INSERT INTO USERS (user_id, name, email, address, postal_code, phone, gender, login, password, birth_date, created_by) VALUES
                                                                                                                           (2, 'Dr. Sarah Johnson', 'sarah.johnson@medicalcabinet.com', '456 Medical Plaza', '10002', '+1-555-0002', 'FEMALE', 'dr.johnson', '$2a$10$encrypted_password_here', '1980-05-20', 'SYSTEM'),
                                                                                                                           (3, 'Dr. Michael Chen', 'michael.chen@medicalcabinet.com', '789 Health Avenue', '10003', '+1-555-0003', 'MALE', 'dr.chen', '$2a$10$encrypted_password_here', '1978-09-10', 'SYSTEM');

INSERT INTO STAFF (staff_id, salary, bonus, recruitment_date, remaining_leave) VALUES
                                                                                   (2, 120000.00, 15000.00, '2020-01-15', 20),
                                                                                   (3, 135000.00, 18000.00, '2019-03-01', 15);

INSERT INTO DOCTORS (doctor_id, specialty) VALUES
                                               (2, 'Cardiology'),
                                               (3, 'Pediatrics');

-- Secretaries
INSERT INTO USERS (user_id, name, email, address, postal_code, phone, gender, login, password, birth_date, created_by) VALUES
    (4, 'Emily Roberts', 'emily.roberts@medicalcabinet.com', '321 Office Lane', '10004', '+1-555-0004', 'FEMALE', 'e.roberts', '$2a$10$encrypted_password_here', '1992-03-25', 'SYSTEM');

INSERT INTO STAFF (staff_id, salary, bonus, recruitment_date, remaining_leave) VALUES
    (4, 45000.00, 3000.00, '2021-06-01', 18);

INSERT INTO SECRETARIES (secretary_id, cnss_number, commission) VALUES
    (4, 'CNSS-2021-00456', 500.00);

-- Patients
INSERT INTO USERS (user_id, name, email, address, postal_code, phone, gender, login, password, birth_date, created_by) VALUES
                                                                                                                           (5, 'James Wilson', 'james.wilson@email.com', '111 Patient Street', '10005', '+1-555-0005', 'MALE', 'j.wilson', '$2a$10$encrypted_password_here', '1965-07-15', 'SYSTEM'),
                                                                                                                           (6, 'Maria Garcia', 'maria.garcia@email.com', '222 Health Road', '10006', '+1-555-0006', 'FEMALE', 'm.garcia', '$2a$10$encrypted_password_here', '1990-11-30', 'SYSTEM'),
                                                                                                                           (7, 'Robert Brown', 'robert.brown@email.com', '333 Wellness Drive', '10007', '+1-555-0007', 'MALE', 'r.brown', '$2a$10$encrypted_password_here', '1975-04-12', 'SYSTEM');

-- ============================================
-- USER ROLES ASSIGNMENT
-- ============================================

INSERT INTO USER_ROLES (user_id, role_id) VALUES
                                              (1, 1), -- Admin
                                              (2, 2), -- Dr. Johnson
                                              (3, 2), -- Dr. Chen
                                              (4, 3), -- Secretary
                                              (5, 4), -- Patients
                                              (6, 4),
                                              (7, 4);

-- ============================================
-- MEDICAL CABINET
-- ============================================

INSERT INTO MEDICAL_CABINETS (cabinet_id, owner_id, name, email, logo, address, postal_code, phone1, phone2, website, instagram, facebook, description, created_by) VALUES
    (1, 1, 'City Medical Center', 'info@citymedicalcenter.com', 'logo.png', '500 Central Avenue', '10010', '+1-555-1000', '+1-555-1001', 'www.citymedicalcenter.com', '@citymedicalcenter', 'CityMedicalCenter', 'Premier healthcare facility providing comprehensive medical services', 'SYSTEM');

-- ============================================
-- PATIENTS
-- ============================================

INSERT INTO PATIENTS (patient_id, name, birth_date, gender, address, phone, insurance, created_by) VALUES
                                                                                                       (1, 'James Wilson', '1965-07-15', 'MALE', '111 Patient Street', '+1-555-0005', 'CNSS', 'dr.johnson'),
                                                                                                       (2, 'Maria Garcia', '1990-11-30', 'FEMALE', '222 Health Road', '+1-555-0006', 'PRIVATE', 'dr.johnson'),
                                                                                                       (3, 'Robert Brown', '1975-04-12', 'MALE', '333 Wellness Drive', '+1-555-0007', 'CNOPS', 'dr.chen'),
                                                                                                       (4, 'Lisa Anderson', '1988-02-28', 'FEMALE', '444 Care Boulevard', '+1-555-0008', 'CNSS', 'dr.chen'),
                                                                                                       (5, 'David Martinez', '1995-09-05', 'MALE', '555 Treatment Plaza', '+1-555-0009', 'NONE', 'dr.johnson');

-- ============================================
-- MEDICAL HISTORY
-- ============================================

INSERT INTO MEDICAL_HISTORY (history_id, patient_id, antecedent_id, name, category, risk_level, created_by) VALUES
                                                                                                                (1, 1, NULL, 'Hypertension', 'Cardiovascular', 'MEDIUM', 'dr.johnson'),
                                                                                                                (2, 1, NULL, 'Type 2 Diabetes', 'Metabolic', 'HIGH', 'dr.johnson'),
                                                                                                                (3, 2, NULL, 'Asthma', 'Respiratory', 'MEDIUM', 'dr.johnson'),
                                                                                                                (4, 3, NULL, 'High Cholesterol', 'Cardiovascular', 'MEDIUM', 'dr.chen'),
                                                                                                                (5, 4, NULL, 'Migraines', 'Neurological', 'LOW', 'dr.chen');

-- ============================================
-- MEDICAL RECORDS
-- ============================================

INSERT INTO MEDICAL_RECORDS (record_id, patient_id, creation_date, created_by) VALUES
                                                                                   (1, 1, '2023-01-15', 'dr.johnson'),
                                                                                   (2, 2, '2023-02-20', 'dr.johnson'),
                                                                                   (3, 3, '2023-03-10', 'dr.chen'),
                                                                                   (4, 4, '2023-04-05', 'dr.chen'),
                                                                                   (5, 5, '2023-05-12', 'dr.johnson');

-- ============================================
-- CONSULTATIONS
-- ============================================

INSERT INTO CONSULTATIONS (consultation_id, record_id, consultation_date, status, doctor_observation, created_by) VALUES
                                                                                                                      (1, 1, '2024-01-15', 'COMPLETED', 'Patient shows improvement in blood pressure control. Continue current medication.', 'dr.johnson'),
                                                                                                                      (2, 1, '2024-04-20', 'COMPLETED', 'Blood sugar levels stable. Recommended dietary adjustments.', 'dr.johnson'),
                                                                                                                      (3, 2, '2024-02-10', 'COMPLETED', 'Asthma under control with current inhaler. No emergency visits reported.', 'dr.johnson'),
                                                                                                                      (4, 3, '2024-03-15', 'COMPLETED', 'Cholesterol levels improving. Continue statin therapy.', 'dr.chen'),
                                                                                                                      (5, 4, '2024-05-01', 'COMPLETED', 'Migraine frequency reduced. Preventive medication working well.', 'dr.chen');

-- ============================================
-- APPOINTMENTS
-- ============================================

INSERT INTO APPOINTMENTS (appointment_id, record_id, doctor_id, appointment_date, appointment_time, reason, status, doctor_note, created_by) VALUES
                                                                                                                                                 (1, 1, 2, '2024-07-15', '09:00:00', 'Regular checkup - Blood pressure monitoring', 'SCHEDULED', NULL, 'e.roberts'),
                                                                                                                                                 (2, 2, 2, '2024-07-16', '10:30:00', 'Asthma follow-up', 'CONFIRMED', NULL, 'e.roberts'),
                                                                                                                                                 (3, 3, 3, '2024-07-17', '14:00:00', 'Cholesterol test results review', 'SCHEDULED', NULL, 'e.roberts'),
                                                                                                                                                 (4, 4, 3, '2024-07-18', '11:00:00', 'Migraine management consultation', 'CONFIRMED', NULL, 'e.roberts'),
                                                                                                                                                 (5, 5, 2, '2024-07-19', '15:30:00', 'Initial consultation', 'SCHEDULED', NULL, 'e.roberts');

-- ============================================
-- DOCTOR INTERVENTIONS
-- ============================================

INSERT INTO DOCTOR_INTERVENTIONS (intervention_id, consultation_id, patient_price, tooth_number, created_by) VALUES
                                                                                                                 (1, 1, 150.00, NULL, 'dr.johnson'),
                                                                                                                 (2, 2, 200.00, NULL, 'dr.johnson'),
                                                                                                                 (3, 3, 175.00, NULL, 'dr.johnson'),
                                                                                                                 (4, 4, 160.00, NULL, 'dr.chen'),
                                                                                                                 (5, 5, 145.00, NULL, 'dr.chen');

-- ============================================
-- MEDICAL ACTS
-- ============================================

INSERT INTO MEDICAL_ACTS (act_id, intervention_id, label, category, base_price, created_by) VALUES
                                                                                                (1, 1, 'Blood Pressure Measurement', 'Diagnostic', 30.00, 'dr.johnson'),
                                                                                                (2, 1, 'General Consultation', 'Consultation', 120.00, 'dr.johnson'),
                                                                                                (3, 2, 'Diabetes Monitoring', 'Diagnostic', 80.00, 'dr.johnson'),
                                                                                                (4, 2, 'Specialist Consultation', 'Consultation', 120.00, 'dr.johnson'),
                                                                                                (5, 3, 'Pulmonary Function Test', 'Diagnostic', 75.00, 'dr.johnson'),
                                                                                                (6, 3, 'Follow-up Consultation', 'Consultation', 100.00, 'dr.johnson'),
                                                                                                (7, 4, 'Lipid Panel Test', 'Laboratory', 60.00, 'dr.chen'),
                                                                                                (8, 4, 'Cardiology Consultation', 'Consultation', 115.00, 'dr.chen'),
                                                                                                (9, 5, 'Neurological Examination', 'Diagnostic', 70.00, 'dr.chen'),
                                                                                                (10, 5, 'Specialist Consultation', 'Consultation', 75.00, 'dr.chen');

-- ============================================
-- ORDERS & PRESCRIPTIONS
-- ============================================

INSERT INTO ORDERS (order_id, record_id, order_date, created_by) VALUES
                                                                     (1, 1, '2024-01-15', 'dr.johnson'),
                                                                     (2, 1, '2024-04-20', 'dr.johnson'),
                                                                     (3, 2, '2024-02-10', 'dr.johnson'),
                                                                     (4, 3, '2024-03-15', 'dr.chen'),
                                                                     (5, 4, '2024-05-01', 'dr.chen');

INSERT INTO PRESCRIPTIONS (prescription_id, order_id, quantity, frequency, duration_in_days, created_by) VALUES
                                                                                                             (1, 1, 30, 'Once daily', 30, 'dr.johnson'),
                                                                                                             (2, 1, 60, 'Twice daily', 30, 'dr.johnson'),
                                                                                                             (3, 2, 90, 'Once daily', 90, 'dr.johnson'),
                                                                                                             (4, 3, 1, 'As needed', 30, 'dr.johnson'),
                                                                                                             (5, 4, 30, 'Once daily', 30, 'dr.chen'),
                                                                                                             (6, 5, 30, 'Once daily', 30, 'dr.chen');

INSERT INTO MEDICATIONS (medication_id, prescription_id, name, laboratory, type, form, reimbursable, unit_price, description, created_by) VALUES
                                                                                                                                              (1, 1, 'Lisinopril 10mg', 'PharmaCorp', 'Antihypertensive', 'TABLET', TRUE, 0.50, 'ACE inhibitor for blood pressure control', 'dr.johnson'),
                                                                                                                                              (2, 2, 'Metformin 500mg', 'MediLabs', 'Antidiabetic', 'TABLET', TRUE, 0.35, 'Oral diabetes medication', 'dr.johnson'),
                                                                                                                                              (3, 3, 'Metformin Extended Release 1000mg', 'MediLabs', 'Antidiabetic', 'TABLET', TRUE, 0.65, 'Long-acting diabetes medication', 'dr.johnson'),
                                                                                                                                              (4, 4, 'Albuterol Inhaler', 'RespiraTech', 'Bronchodilator', 'INJECTION', TRUE, 45.00, 'Rescue inhaler for asthma', 'dr.johnson'),
                                                                                                                                              (5, 5, 'Atorvastatin 20mg', 'CardioPharm', 'Statin', 'TABLET', TRUE, 0.80, 'Cholesterol-lowering medication', 'dr.chen'),
                                                                                                                                              (6, 6, 'Sumatriptan 50mg', 'NeuroMed', 'Antimigraine', 'TABLET', FALSE, 8.50, 'Migraine treatment medication', 'dr.chen');

-- ============================================
-- CERTIFICATES
-- ============================================

INSERT INTO CERTIFICATES (certificate_id, record_id, doctor_id, start_date, end_date, duration, doctor_note, created_by) VALUES
                                                                                                                             (1, 1, 2, '2024-01-15', '2024-01-19', 5, 'Patient requires rest due to elevated blood pressure. Recommend work from home if possible.', 'dr.johnson'),
                                                                                                                             (2, 3, 3, '2024-03-15', '2024-03-17', 3, 'Medical leave granted for cardiovascular testing and recovery.', 'dr.chen');

-- ============================================
-- FINANCIAL SITUATIONS
-- ============================================

INSERT INTO FINANCIAL_SITUATIONS (situation_id, record_id, total_acts, total_paid, credit, status, on_promotion, created_by) VALUES
                                                                                                                                 (1, 1, 550.00, 550.00, 0.00, 'PAID', FALSE, 'e.roberts'),
                                                                                                                                 (2, 2, 175.00, 175.00, 0.00, 'PAID', FALSE, 'e.roberts'),
                                                                                                                                 (3, 3, 175.00, 100.00, 75.00, 'PARTIAL', FALSE, 'e.roberts'),
                                                                                                                                 (4, 4, 145.00, 0.00, 145.00, 'UNPAID', FALSE, 'e.roberts'),
                                                                                                                                 (5, 5, 200.00, 200.00, 0.00, 'PAID', TRUE, 'e.roberts');

-- ============================================
-- INVOICES
-- ============================================

INSERT INTO INVOICES (invoice_id, situation_id, total_invoice, total_paid, remaining, status, invoice_date, created_by) VALUES
                                                                                                                            (1, 1, 550.00, 550.00, 0.00, 'PAID', '2024-01-15 10:30:00', 'e.roberts'),
                                                                                                                            (2, 2, 175.00, 175.00, 0.00, 'PAID', '2024-02-10 11:15:00', 'e.roberts'),
                                                                                                                            (3, 3, 175.00, 100.00, 75.00, 'PARTIAL', '2024-03-15 14:30:00', 'e.roberts'),
                                                                                                                            (4, 4, 145.00, 0.00, 145.00, 'UNPAID', '2024-05-01 09:45:00', 'e.roberts'),
                                                                                                                            (5, 5, 200.00, 200.00, 0.00, 'PAID', '2024-05-12 16:00:00', 'e.roberts');

-- ============================================
-- CHARGES & REVENUES
-- ============================================

INSERT INTO CHARGES (charge_id, cabinet_id, title, description, amount, charge_date, created_by) VALUES
                                                                                                     (1, 1, 'Medical Supplies', 'Monthly restocking of examination room supplies', 1200.00, '2024-01-05 00:00:00', 'admin'),
                                                                                                     (2, 1, 'Equipment Maintenance', 'Annual maintenance contract for diagnostic equipment', 3500.00, '2024-02-15 00:00:00', 'admin'),
                                                                                                     (3, 1, 'Utilities', 'Electricity and water bills for January', 850.00, '2024-01-31 00:00:00', 'admin'),
                                                                                                     (4, 1, 'Staff Salaries', 'Monthly payroll for medical staff', 25000.00, '2024-01-31 00:00:00', 'admin'),
                                                                                                     (5, 1, 'Software Subscription', 'Medical records management system renewal', 500.00, '2024-03-01 00:00:00', 'admin');

INSERT INTO REVENUES (revenue_id, cabinet_id, title, description, amount, revenue_date, created_by) VALUES
                                                                                                        (1, 1, 'Consultation Fees', 'Revenue from patient consultations - January', 15000.00, '2024-01-31 00:00:00', 'e.roberts'),
                                                                                                        (2, 1, 'Diagnostic Tests', 'Revenue from laboratory and diagnostic services', 8500.00, '2024-01-31 00:00:00', 'e.roberts'),
                                                                                                        (3, 1, 'Specialist Services', 'Revenue from specialist consultations', 12000.00, '2024-02-28 00:00:00', 'e.roberts'),
                                                                                                        (4, 1, 'Medical Procedures', 'Revenue from minor medical procedures', 6500.00, '2024-02-28 00:00:00', 'e.roberts'),
                                                                                                        (5, 1, 'Certificate Fees', 'Revenue from medical certificates and documentation', 2000.00, '2024-03-31 00:00:00', 'e.roberts');

-- ============================================
-- STATISTICS
-- ============================================

INSERT INTO STATISTICS (statistic_id, cabinet_id, name, category, value, calculation_date, created_by) VALUES
                                                                                                           (1, 1, 'Total Patients', 'PATIENTS', 5, '2024-06-01', 'SYSTEM'),
                                                                                                           (2, 1, 'Monthly Revenue', 'FINANCIAL', 44000.00, '2024-05-31', 'SYSTEM'),
                                                                                                           (3, 1, 'Monthly Expenses', 'FINANCIAL', 31050.00, '2024-05-31', 'SYSTEM'),
                                                                                                           (4, 1, 'Appointments Completed', 'APPOINTMENTS', 45, '2024-05-31', 'SYSTEM'),
                                                                                                           (5, 1, 'Average Consultation Fee', 'FINANCIAL', 135.50, '2024-05-31', 'SYSTEM'),
                                                                                                           (6, 1, 'Patient Satisfaction Rate', 'PATIENTS', 4.6, '2024-05-31', 'SYSTEM');

-- ============================================
-- MONTHLY SCHEDULES
-- ============================================

INSERT INTO MONTHLY_SCHEDULES (schedule_id, cabinet_id, month, unavailable_days, created_by) VALUES
                                                                                                 (1, 1, 'JANUARY', '["2024-01-01", "2024-01-14", "2024-01-28"]', 'admin'),
                                                                                                 (2, 1, 'FEBRUARY', '["2024-02-11", "2024-02-25"]', 'admin'),
                                                                                                 (3, 1, 'MARCH', '["2024-03-10", "2024-03-24"]', 'admin'),
                                                                                                 (4, 1, 'APRIL', '["2024-04-07", "2024-04-21"]', 'admin'),
                                                                                                 (5, 1, 'MAY', '["2024-05-01", "2024-05-19"]', 'admin'),
                                                                                                 (6, 1, 'JUNE', '["2024-06-09", "2024-06-23"]', 'admin');

-- ============================================
-- NOTIFICATIONS
-- ============================================

INSERT INTO NOTIFICATIONS (notification_id, user_id, title, message, notification_date, notification_time, type, priority, created_by) VALUES
                                                                                                                                           (1, 5, 'APPOINTMENT', 'Your appointment with Dr. Johnson is scheduled for July 15, 2024 at 09:00 AM', '2024-07-14', '09:00:00', 'EMAIL', 'MEDIUM', 'SYSTEM'),
                                                                                                                                           (2, 6, 'APPOINTMENT', 'Reminder: Your appointment is tomorrow at 10:30 AM', '2024-07-15', '09:00:00', 'SMS', 'HIGH', 'SYSTEM'),
                                                                                                                                           (3, 7, 'APPOINTMENT', 'Your appointment with Dr. Chen is scheduled for July 17, 2024 at 02:00 PM', '2024-07-16', '09:00:00', 'EMAIL', 'MEDIUM', 'SYSTEM'),
                                                                                                                                           (4, 5, 'PAYMENT', 'Your payment of $550.00 has been received. Thank you!', '2024-01-15', '10:35:00', 'EMAIL', 'LOW', 'SYSTEM'),
                                                                                                                                           (5, 7, 'REMINDER', 'Please remember to take your prescribed medication daily', '2024-03-16', '08:00:00', 'PUSH', 'MEDIUM', 'SYSTEM');