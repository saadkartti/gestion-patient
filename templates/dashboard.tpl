
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{$page_title|default:"Gestion des Patients"}</title>


  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
  <link rel="stylesheet" href="assets/dist/css/healthcare.css">
</head>
<body class="hold-transition sidebar-mini healthcare-dashboard">
<div class="wrapper">

  <!-- Sidebar -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="index.php" class="brand-link text-center">
        <i class="fas fa-hospital-alt fa-lg"></i>
        <span class="brand-text font-weight-light">MediCore</span>
    </a>
    <div class="sidebar">
      <nav class="mt-3">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
          <li class="nav-item"><a href="index.php" class="nav-link active"><i class="nav-icon fas fa-tachometer-alt"></i><p>Tableau de Bord</p></a></li>
          <li class="nav-item"><a href="index.php?action=add" class="nav-link"><i class="nav-icon fas fa-user-plus"></i><p>Nouveau Patient</p></a></li>
          <li class="nav-item mt-2"><a href="#" class="nav-link"><i class="nav-icon fas fa-calendar-check"></i><p>Rendez-vous</p></a></li>
          <li class="nav-item"><a href="#" class="nav-link"><i class="nav-icon fas fa-user-md"></i><p>Médecins</p></a></li>
        </ul>
      </nav>
    </div>
  </aside>

  <!-- Contenu Principal -->
  <div class="content-wrapper">
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2 align-items-center">
          <div class="col-sm-6">
            <h1 class="m-0"><strong>Tableau de Bord</strong></h1>
            <p class="text-muted">Vue d'ensemble du système</p>
          </div>
          <div class="col-sm-6 text-sm-end">
            <a href="index.php?action=add" class="btn btn-lg btn-healthcare-primary shadow-sm">
              <i class="fas fa-plus-circle me-2"></i>Ajouter un Patient
            </a>
          </div>
        </div>
      </div>
    </div>

    <div class="content">
      <div class="container-fluid">

        <!-- Messages d'alerte -->
        {if $message}<div class="alert alert-success alert-dismissible fade show">{$message}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>{/if}
        {if $error}<div class="alert alert-danger alert-dismissible fade show">{$error}<button type="button" class="btn-close" data-bs-dismiss="alert"></button></div>{/if}

        <!-- Cartes de Statistiques -->
        <div class="row">
          <div class="col-lg-3 col-6"><div class="card text-white bg-info shadow-sm border-0 mb-4 stats-card"><div class="card-body"><h3 class="fw-bold">{$stats.total_appointments|default:0}</h3><p>Rendez-vous</p><div class="icon fs-1 position-absolute end-0 bottom-0 p-3"><i class="fas fa-calendar-check"></i></div></div></div></div>
          <div class="col-lg-3 col-6"><div class="card text-white bg-success shadow-sm border-0 mb-4 stats-card"><div class="card-body"><h3 class="fw-bold">{$stats.total_patients|default:0}</h3><p>Patients</p><div class="icon fs-1 position-absolute end-0 bottom-0 p-3"><i class="fas fa-users"></i></div></div></div></div>
          <div class="col-lg-3 col-6"><div class="card text-white bg-warning shadow-sm border-0 mb-4 stats-card"><div class="card-body"><h3 class="fw-bold">{$stats.total_cancellations|default:0}</h3><p>Annulations</p><div class="icon fs-1 position-absolute end-0 bottom-0 p-3"><i class="fas fa-calendar-times"></i></div></div></div></div>
          <div class="col-lg-3 col-6"><div class="card text-white bg-danger shadow-sm border-0 mb-4 stats-card"><div class="card-body"><h3 class="fw-bold">{$stats.avg_per_doctor|default:0}</h3><p>Moy. / Médecin</p><div class="icon fs-1 position-absolute end-0 bottom-0 p-3"><i class="fas fa-user-md"></i></div></div></div></div>
        </div>
        
        <!-- Section Principale : Patients et Médecins -->
        <div class="row">
          <!-- Colonne des Patients -->
          <div class="col-lg-8">
            <div class="card shadow-sm h-100">
              <div class="card-header bg-white border-0 py-3">
                <h3 class="card-title d-flex align-items-center"><i class="fas fa-list-alt me-2 text-primary"></i><strong>Liste des Patients</strong></h3>
              </div>
              <div class="card-body p-0">
                <div class="table-responsive">
                  <table class="table table-hover patients-table mb-0">
                    <thead><tr><th>Patient</th><th>Rendez-vous</th><th>Médecin</th><th class="text-center">Actions</th></tr></thead>
                    <tbody>
                      {if $patients}
                        {foreach $patients as $patient}
                        <tr>
                          <td class="align-middle"><strong>{$patient.name}</strong><br><small class="text-muted">{$patient.mob}</small></td>
                          <td class="align-middle">{$patient.appointment_date|date_format:"%d/%m/%Y"} at {$patient.appointment_date|date_format:"%H:%M"}</td>
                          <td class="align-middle">Dr. {$patient.doctor_name}<br><span class="badge rounded-pill department-badge">{$patient.department}</span></td>
                          <td class="text-center align-middle">
                            <a href="index.php?action=edit&id={$patient.id}" class="btn btn-warning btn-sm" title="Modifier"><i class="fas fa-edit"></i></a>
                            <a href="patient_actions.php?action=delete&id={$patient.id}" class="btn btn-danger btn-sm" onclick="return confirm('Êtes-vous sûr ?')" title="Supprimer"><i class="fas fa-trash"></i></a>
                          </td>
                        </tr>
                        {/foreach}
                      {else}
                        <tr><td colspan="4" class="text-center py-5"><p class="text-muted">Aucun patient trouvé.</p></td></tr>
                      {/if}
                    </tbody>
                  </table>
                </div>
              </div>
              <div class="card-footer bg-white">
               
              </div>
            </div>
          </div>

          <!-- Colonne des Médecins -->
          <div class="col-lg-4">
            <div class="card shadow-sm doctors-section h-100">
              <div class="card-header py-3"><h3 class="card-title d-flex align-items-center"><i class="fas fa-user-md me-2"></i><strong>Médecins Disponibles</strong></h3></div>
              <div class="card-body">
                <div class="input-group mb-3"><span class="input-group-text"><i class="fas fa-search"></i></span><input type="text" id="doctorSearch" class="form-control" placeholder="Rechercher..."></div>
                <div id="doctorList" class="d-grid gap-3">
                  {foreach $doctors as $doc}
                  <div class="d-flex align-items-center p-2 rounded-3 shadow-sm border doctor-card">
                    <img src="{$doc.photo_path}" alt="{$doc.name}" class="doctor-photo me-3">
                    <div>
                      <div class="doctor-name">{$doc.name}</div>
                      <div class="doctor-specialty text-muted">{$doc.specialty}</div>
                      <div class="badge rounded-pill doctor-department">{$doc.department_code}</div>
                    </div>
                  </div>
                  {/foreach}
                </div>
              </div>
              <div class="card-footer bg-white">
                
              </div>
            </div>
          </div>
        </div>

        <!-- Section des Actions Rapides -->
        <div class="mt-4 pt-3">
            <h3 class="mb-3">Actions Rapides</h3>
            <div class="row">
                <div class="col-md-4 mb-3">
                    <a href="index.php?action=add" class="quick-action-card d-block p-4 rounded-3 shadow-sm text-center new-patient">
                        <div class="quick-action-icon"><i class="fas fa-user-plus"></i></div>
                        <h3 class="quick-action-name">Nouveau Patient</h3>
                        <div class="quick-action-title">ADMISSION</div>
                    </a>
                </div>
                <div class="col-md-4 mb-3">
                    <a href="#" class="quick-action-card d-block p-4 rounded-3 shadow-sm text-center emergency">
                        <div class="quick-action-icon"><i class="fas fa-ambulance"></i></div>
                        <h3 class="quick-action-name">Urgences</h3>
                        <div class="quick-action-title">SALLE D'ATTENTE</div>
                    </a>
                </div>
                <div class="col-md-4 mb-3">
                     <a href="#" class="quick-action-card d-block p-4 rounded-3 shadow-sm text-center pharmacy">
                        <div class="quick-action-icon"><i class="fas fa-pills"></i></div>
                        <h3 class="quick-action-name">Pharmacie</h3>
                        <div class="quick-action-title">GESTION DES STOCKS</div>
                    </a>
                </div>
            </div>
        </div>

      </div>
    </div>
  </div>

  <!-- Pied de page -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-inline">Version 1.0</div>
    <strong>Copyright &copy; 2024 <a href="#" class="text-primary">MediCore</a>.</strong> Tous droits réservés.
  </footer>
</div>

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>
<script>
$(document).ready(function() {
    
    setTimeout(() => $('.alert').fadeOut('slow'), 5000);

    // Filtre de recherche pour les médecins
    $('#doctorSearch').on('keyup', function() {
        var value = $(this).val().toLowerCase();
        $('#doctorList .doctor-card').filter(function() {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
});
</script>
</body>
</html>