<?php

require_once 'config.php';
$action = isset($_POST['action']) ? $_POST['action'] : (isset($_GET['action']) ? $_GET['action'] : '');

switch ($action) {
    case 'add':
        addPatient();
        break;
    case 'edit':
        editPatient();
        break;
    case 'delete':
        deletePatient();
        break;
    default:
        header('Location: index.php');
        exit;
}

function addPatient() {
    global $pdo;
    
    // Validation des données
    $required = ['name', 'mob', 'appointment_date', 'doctor_name', 'department'];
    foreach ($required as $field) {
        if (empty($_POST[$field])) {
            header('Location: index.php?action=add&error=Le champ ' . $field . ' est requis');
            exit;
        }
    }
    
    $data = [
        'name' => htmlspecialchars($_POST['name']),
        'mob' => htmlspecialchars($_POST['mob']),
        'appointment_date' => $_POST['appointment_date'],
        'doctor_name' => htmlspecialchars($_POST['doctor_name']),
        'department' => htmlspecialchars($_POST['department'])
    ];
    
    $sql = "INSERT INTO patients (name, mob, appointment_date, doctor_name, department) 
            VALUES (:name, :mob, :appointment_date, :doctor_name, :department)";
    
    $stmt = $pdo->prepare($sql);
    
    if ($stmt->execute($data)) {
        header('Location: index.php?message=Patient ajouté avec succès');
    } else {
        header('Location: index.php?action=add&error=Erreur lors de l\'ajout du patient');
    }
    exit;
}

function editPatient() {
    global $pdo;
    
    if (!isset($_POST['id']) || empty($_POST['id'])) {
        header('Location: index.php?error=ID patient manquant');
        exit;
    }
    
    $data = [
        'id' => intval($_POST['id']),
        'name' => htmlspecialchars($_POST['name']),
        'mob' => htmlspecialchars($_POST['mob']),
        'appointment_date' => $_POST['appointment_date'],
        'doctor_name' => htmlspecialchars($_POST['doctor_name']),
        'department' => htmlspecialchars($_POST['department'])
    ];
    
    $sql = "UPDATE patients SET name = :name, mob = :mob, appointment_date = :appointment_date, 
            doctor_name = :doctor_name, department = :department WHERE id = :id";
    
    $stmt = $pdo->prepare($sql);
    
    if ($stmt->execute($data)) {
        header('Location: index.php?message=Patient modifié avec succès');
    } else {
        header('Location: index.php?action=edit&id=' . $data['id'] . '&error=Erreur lors de la modification');
    }
    exit;
}

function deletePatient() {
    global $pdo;
    
    $id = isset($_GET['id']) ? intval($_GET['id']) : 0;
    
    if ($id > 0) {
        $stmt = $pdo->prepare("DELETE FROM patients WHERE id = ?");
        if ($stmt->execute([$id])) {
            header('Location: index.php?message=Patient supprimé avec succès');
        } else {
            header('Location: index.php?error=Erreur lors de la suppression');
        }
    } else {
        header('Location: index.php?error=ID patient invalide');
    }
    exit;
}
?>