package org.dentexa.entity;
import java.sql.Time;
import java.util.Date;

public class AgendaMensuel {
private Long idAgnd;
    private Date dateConsultation;
    private Time heurDebut;
    private Time heureFin;
    private String patientName;
    private String status;


    private CabinetMedical cabinetMedical;
}
