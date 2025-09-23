
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{$page_title} - MediCore Hospital</title>

  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css">
  <link rel="stylesheet" href="assets/dist/css/healthcare.css">
</head>
<body class="hold-transition sidebar-mini healthcare-form">
<div class="wrapper">

  <!-- Navigation simplifiée -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light border-bottom">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#"><i class="fas fa-bars"></i></a>
      </li>
      <li class="nav-item">
        <a href="index.php" class="nav-link"><i class="fas fa-arrow-left mr-2"></i>Retour au Dashboard</a>
      </li>
    </ul>
  </nav>

  <!-- Sidebar -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <a href="index.php" class="brand-link text-center">
      <span class="brand-text font-weight-light">
        <i class="fas fa-hospital-alt mr-2"></i>MediCore Hospital
      </span>
    </a>
    <div class="sidebar">
      <nav class="mt-3">
        <ul class="nav nav-pills nav-sidebar flex-column">
          <li class="nav-item">
            <a href="index.php" class="nav-link">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>Dashboard</p>
            </a>
          </li>
          <li class="nav-item">
            <a href="index.php?action=add" class="nav-link active">
              <i class="nav-icon fas fa-user-plus"></i>
              <p>{if $patient}Modifier{else}Ajouter{/if} Patient</p>
            </a>
          </li>
          
        </ul>
      </nav>
    </div>
  </aside>

  <!-- Content Wrapper -->
  <div class="content-wrapper">
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">
              <i class="fas fa-user-{if $patient}edit{else}plus{/if} mr-2 text-primary"></i>
              {$page_title}
            </h1>
            <p class="text-muted mb-0">{if $patient}Modifier les informations du patient{else}Ajouter un nouveau patient au système{/if}</p>
          </div>
          <div class="col-sm-6">
            <div class="float-right">
              <a href="index.php" class="btn btn-healthcare btn-healthcare-secondary">
                <i class="fas fa-times mr-2"></i>Annuler
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="content">
      <div class="container-fluid">
        <div class="row justify-content-center">
          <div class="col-lg-8 col-md-10">
            <div class="card form-card fade-in">
              <div class="card-header">
                <h3 class="card-title">
                  <i class="fas fa-id-card mr-2"></i>
                  Informations du Patient
                </h3>
              </div>

              <form action="patient_actions.php" method="post" class="needs-validation" novalidate>
                {if $patient}
                <input type="hidden" name="id" value="{$patient.id}">
                <input type="hidden" name="action" value="edit">
                {else}
                <input type="hidden" name="action" value="add">
                {/if}

                <div class="card-body p-4">
                 
                  {if $error}
                  <div class="alert alert-danger alert-dismissible fade show">
                    <button type="button" class="close" data-dismiss="alert">×</button>
                    <i class="icon fas fa-exclamation-circle mr-2"></i> 
                    <strong>Erreur !</strong> {$error}
                  </div>
                  {/if}

                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group form-icon">
                        <label for="name" class="form-label">
                          <i class="fas fa-user text-primary mr-2"></i>Nom complet *
                        </label>
                        <input type="text" class="form-control" id="name" name="name" 
                               value="{$patient.name|default:''}" required 
                               placeholder="Ex: Jean Dupont">
                        <div class="invalid-feedback">
                          Veuillez saisir le nom du patient.
                        </div>
                      </div>
                    </div>
                    
                    <div class="col-md-6">
                      <div class="form-group form-icon">
                        <label for="mob" class="form-label">
                          <i class="fas fa-phone text-primary mr-2"></i>Numéro de téléphone *
                        </label>
                        <input type="tel" class="form-control" id="mob" name="mob" 
                               value="{$patient.mob|default:''}" required 
                               placeholder="Ex: (212) 600-1234">
                        <div class="invalid-feedback">
                          Veuillez saisir un numéro de téléphone valide.
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="row">
                    <div class="col-md-6">
                      <div class="form-group form-icon">
                        <label for="appointment_date" class="form-label">
                          <i class="fas fa-calendar-alt text-primary mr-2"></i>Date et heure du rendez-vous *
                        </label>
                        <input type="datetime-local" class="form-control" id="appointment_date" name="appointment_date" 
                               value="{if $patient}{$patient.appointment_date|date_format:'%Y-%m-%dT%H:%M'}{/if}" required>
                        <div class="invalid-feedback">
                          Veuillez sélectionner une date et heure de rendez-vous.
                        </div>
                      </div>
                    </div>
                    
                    <div class="col-md-6">
                      <div class="form-group form-icon">
                        <label for="doctor_name" class="form-label">
                          <i class="fas fa-user-md text-primary mr-2"></i>Nom du docteur *
                        </label>
                        <input type="text" class="form-control" id="doctor_name" name="doctor_name" 
                               value="{$patient.doctor_name|default:''}" required 
                               placeholder="Ex: Dr. Aisha Ben Ali">
                        <div class="invalid-feedback">
                          Veuillez saisir le nom du médecin.
                        </div>
                      </div>
                    </div>
                  </div>

                  <div class="form-group">
                    <label for="department" class="form-label">
                      <i class="fas fa-hospital text-primary mr-2"></i>Département *
                    </label>
                    <select class="form-control" id="department" name="department" required>
                      <option value="">Sélectionnez un département</option>
                      {if $departments && is_array($departments)}
                        {foreach from=$departments key=value item=label}
                        <option value="{$value}" 
                                {if $patient && $patient.department == $value}selected{/if}>
                          {$label}
                        </option>
                        {/foreach}
                      {else}
                        <option value="Pediatrics (A-9987)">Pédiatrie</option>
                        <option value="Cardiology (A-9645)">Cardiologie</option>
                        <option value="Gynecology (A-9987)">Gynécologie</option>
                        <option value="Orthopedics (A-9988)">Orthopédie</option>
                        <option value="Dermatology (A-9987)">Dermatologie</option>
                        <option value="Neurology (A-9820)">Neurologie</option>
                        <option value="Internal Medicine (A-8648)">Médecine Interne</option>
                        <option value="Ophthalmology (A-9987)">Ophtalmologie</option>
                      {/if}
                    </select>
                    <div class="invalid-feedback">
                      Veuillez sélectionner un département.
                    </div>
                  </div>
                </div>

                <div class="card-footer bg-white border-top-0 text-center py-4">
                  <button type="submit" class="btn btn-healthcare btn-healthcare-primary mr-3">
                    <i class="fas fa-save mr-2"></i> 
                    {if $patient}Modifier{else}Ajouter{/if} le Patient
                  </button>
                  <a href="index.php" class="btn btn-healthcare btn-healthcare-secondary">
                    <i class="fas fa-times mr-2"></i>Annuler
                  </a>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js"></script>

<script>
// Validation du formulaire
(function() {
    'use strict';
    window.addEventListener('load', function() {
        var forms = document.getElementsByClassName('needs-validation');
        var validation = Array.prototype.filter.call(forms, function(form) {
            form.addEventListener('submit', function(event) {
                if (form.checkValidity() === false) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    }, false);
})();

setTimeout(function() {
    $('.alert').fadeOut('slow');
}, 5000);

{literal}
$(document).ready(function() {
    $('.fade-in').css('opacity', '0').animate({opacity: 1}, 800);
});
{/literal}
</script>
</body>
</html>