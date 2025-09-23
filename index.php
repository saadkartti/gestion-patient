<?php
// Fichier: index.php
require_once 'config.php';

// Déterminer l'action
$action = isset($_GET['action']) ? $_GET['action'] : 'dashboard';

// Gérer les messages
if (isset($_GET['message'])) {
    $smarty->assign('message', $_GET['message']);
}
if (isset($_GET['error'])) {
    $smarty->assign('error', $_GET['error']);
}

// Router
switch ($action) {
    case 'add':
        showPatientForm();
        break;
    case 'edit':
        $id = isset($_GET['id']) ? intval($_GET['id']) : 0;
        showPatientForm($id);
        break;
    case 'list':
        showPatientList();
        break;
    case 'dashboard':
    default:
        showDashboard();
        break;
}

/**
 * Dashboard
 */
function showDashboard() {
    global $pdo, $smarty;

    // Patients
    $stmt = $pdo->query("SELECT * FROM patients ORDER BY appointment_date DESC");
    $patients = $stmt->fetchAll();

    // Statistiques
    $stats = getRealStatistics();

    // Médecins
    $doctors = getDoctorsFromDatabase();

    $smarty->assign('page_title', 'Healthcare Management Dashboard');
    $smarty->assign('patients', $patients);
    $smarty->assign('stats', $stats);
    $smarty->assign('doctors', $doctors);
    $smarty->display('dashboard.tpl');
}

/**
 * Formulaire patient
 */
function showPatientForm($id = 0) {
    global $pdo, $smarty;

    $patient = null;
    if ($id > 0) {
        $stmt = $pdo->prepare("SELECT * FROM patients WHERE id = ?");
        $stmt->execute([$id]);
        $patient = $stmt->fetch();
    }

    $smarty->assign('page_title', $id ? 'Modifier Patient' : 'Ajouter Patient');
    $smarty->assign('patient', $patient);
    $smarty->assign('departments', getDepartmentsList());
    $smarty->display('patient_form.tpl');
}

/**
 * Liste des patients
 */
function showPatientList() {
    global $pdo, $smarty;

    $stmt = $pdo->query("SELECT * FROM patients ORDER BY appointment_date DESC");
    $patients = $stmt->fetchAll();

    $smarty->assign('page_title', 'Liste des Patients');
    $smarty->assign('patients', $patients);
    $smarty->display('patient_list.tpl');
}

/**
 * Statistiques patients
 */
function getRealStatistics() {
    global $pdo;

    // Total des rendez-vous
    $stmt = $pdo->query("SELECT COUNT(*) as total FROM patients");
    $total_appointments = $stmt->fetch()['total'];

    // Total patients distincts
    $stmt = $pdo->query("SELECT COUNT(DISTINCT name) as total FROM patients");
    $total_patients = $stmt->fetch()['total'];

    return [
        'total_appointments' => $total_appointments,
        'total_patients' => $total_patients,
        'total_cancellations' => 0, // À implémenter si tu ajoutes une colonne status
        'avg_per_doctor' => round($total_appointments / max(1, count(getDoctorsFromDatabase())), 1)
    ];
}

/**
 * Récupérer médecins depuis la DB
 */
function getDoctorsFromDatabase() {
    global $pdo;

   
        $stmt = $pdo->query("SELECT * FROM doctors ORDER BY name");
        $doctors = $stmt->fetchAll(PDO::FETCH_ASSOC);

       
        return $doctors;

    
}


/**
 * Liste des départements
 */
function getDepartmentsList() {
    return [
        'Pediatrics (A-9987)' => 'Pédiatrie',
        'Cardiology (A-9645)' => 'Cardiologie',
        'Gynecology (A-9987)' => 'Gynécologie',
        'Orthopedics (A-9988)' => 'Orthopédie',
        'Dermatology (A-9987)' => 'Dermatologie',
        'Neurology (A-9820)' => 'Neurologie',
        'Internal Medicine (A-8648)' => 'Médecine Interne',
        'Ophthalmology (A-9987)' => 'Ophtalmologie'
    ];
}
?>
